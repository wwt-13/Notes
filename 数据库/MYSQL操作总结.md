[toc]

# MYSQL操作总结

## 杂

### 关于大小写支持

-   数据库名+表名都不支持大写（自动转换为小写）
-   字段名支持大写

## 数据库、表操作和数据更新

> 这里讲的是数据库和表的创建和删除等一系列操作（不包括关系模型的细节操作）

### 数据库操作

- 查看数据库

  ```mysql
  show databases;# 显示所有数据库
  ```

- 使用数据库

  ```mysql
  use db_name;# 使用该数据库进行操作(操作环境更换为该数据库下的表)
  ```

- 数据库创建

  ```mysql
  create database db_name;
  ```

- 删除数据库

  ```mysql
  drop database db_name;
  ```

### 表操作

- 创建表

  ```mysql
  create table if not exists tb_name( # 如果表不存在的话，创建表
  	...... # 这里放对各种数据字段的定义和声明、主键约束/外键约束等等
  )
  ```

- 查看表

  ```mysql
  show tables; # 查看当前数据库中可用的表
  ```

- 删除表

  ```mysql
  drop table if exists tb_name;
  ```

- 查看表的具体结构

  ```mysql
  desc tb_name;
  ```

- 表重命名

  ```mysql
  rename table name_old to name_new; # 方法1
  alter table name_old rename name_new; # 方法2，推荐使用，更加规范
  ```

#### 修改表的具体结构

>   整体结构如下
>
>   ```mysql
>   alter table tb_name
>   [add new_col_name data_type [integrity_constraints]|integrity_constraints]
>   [drop col_name|integrity_constraints]
>   [modify col_name data_type [integrity_constraints]]
>   [change col_name new_col_name data_type [integrity_constraints]];
>   ```
>
>   <u>add语句</u>：用于增加新列和新的**完整性约束条件**
>
>   <u>drop语句</u>：删除指定的列或者完整性约束条件
>
>   <u>modify语句</u>：修改指定列的数据类型
>
>   <u>change语句</u>：modify的基础上添加修改列名
>
>   $Plus:$修改原有列定义可能会破坏已有数据。

- 添加字段

  ```mysql
  alter table tb_name add column co_name varchar(80) not null;
  ```

  添加完整性约束条件

  ```mysql
  alter table review add index(col0);
  ```

- 删除字段

  ```mysql
  alter table tb_name drop co_name;
  ```

  删除完整性约束

  ```mysql
  # 方法1:直接删除
  alter table tb_name drop intrgrity_constraints col_name;
  # 方法2:先查看约束名再进行删除(更加稳妥)
  show create table tb_name;# 查看约束名和约束key
  alter table tb_name drop in_co_key in_co_name;
  ```

- 修改字段结构+重命名

  ```mysql
  alter table tb_name change column1 column2 varchar(100) not null;
  # change比modify更加全面,可以修改字段名
  ```
  
- 更新字段的值（不建议使用，建议update全部用于元组操作）

  ```mysql
  update table_name set col_name=new_value where condition;# 需要记忆
  ```

### 数据更新

>   对表中的元组进行操作
>
>   三种常见数据更新类型
>
>   -   ==Insert==插入一条或多条元组（常用，已基本掌握）
>
>       两种用法
>
>       1.   自己构造数据插入
>
>            ```mysql
>            insert into tb_name(col1,col2....)
>            values
>            (col1_va1,col2_va1,....),
>            (col1_va2,....),
>            ....;
>            ```
>
>       2.   将从其他表查询得到的数据插入表
>
>            ```mysql
>            insert into tb_name(col1,col2...)
>            select ......;# 数据查询语句
>            ```
>
>   -   ==Delete== 删除一条或多条**元组**（删除表中满足where语句条件的***元组***）
>
>       ```mysql
>       delete from tb_name
>       where conditions;
>       ```
>
>   -   ==Update== 更新**现有**一条或多条**元组**中的值（注意update用于更新的是元组的值）
>
>       ```mysql
>       update tb_name
>       set col1=expression1,col2=expression2.....
>       where conditions;
>       ```

实例（这里讲讲之前比较少操作的方法）：

1.   将从其他表中查找出的数据插入到表中（**select子句目标列必须和insert匹配**）

     ```mysql
     insert into deptage(sdept,avage)
     select sdept,avg(sage)
     from student
     group by sdept;
     ```

2.   数据更新操作（修改多个元组的值，不指定where的话，**默认作用范围为所有元组**）

     ```mysql
     update student
     set sage=sage+1;# 将所有学生的年龄+1
     ```

## 索引

> 关系数据库中，如果有上万甚至上亿条记录的话，在查找记录的时候，还想获得非常快的速度，就需要使用==索引==
>
> 索引是关系数据库中对某一列或者多个列的值进行预排序的数据结构。
>
> 通过使用索引，可以让数据库系统不必扫描整个表，而是可以直接定位到符合条件的记录，大大加快查询速度。

对于`students`表，如果要经常对`score`列进行查询，就可以对`score`列创建索引

```mysql
# 创建时添加索引
index index_score(score) # 和添加主键类似，同样可以添加多个
alter table student add index idx_score(score) # 对score列创建了一个名称为idx_score的索引，如果要对多列创建索引，那么只需要在括号里放上多个列名即可
```

对于主键，关系数据库会自动对其创建主键索引（效率高，因为主键保证了绝对唯一性）

### 唯一索引

> 设计关系数据表的时候，看上去唯一的列，例如身份证号、邮箱地址，但是因为他们具备业务含义（身份证号和邮箱都**有可能会修改**），所以不宜作为主键
>
> 但是这些列根据业务要求，又同时具备了唯一性约束，这种时候，就可以给这些列添加一个唯一索引
>
> 注意：MySql对于唯一索引不区分大小写

```mysql
alter table students add unique index uni_name(name);
# 也可以只对某一列添加一个唯一约束而不创建唯一索引
alter table students add constraint uni_name unique(name);
```

---

> 无论是否创建索引，对于用户和应用程序来说，使用关系数据库不会有任何区别。这里的意思是说，当我们在数据库中查询时，如果有相应的索引可用，数据库系统就会自动使用索引来提高查询效率，如果没有索引，查询也能正常执行，只是速度会变慢。因此，***索引可以在使用数据库的过程中逐步优化***。

## 约束

> 约束，是一种限制，它是对表的行和列的数据做出约束，确保表中数据的完整性和唯一性
>
> 三种完整性：域、实体、参照完整性（其实还有一个用户完整性，但是这里不提及）
>
> 域完整性：就是对于数据表中字段的约束
>
> 实体完整性：通过主键约束和候选键约束实现
>
> 参照完整性：就是外键约束

**分类如下**

- default：默认约束，域完整性

  指定某列的**默认值**，插入数据时，如果此列赋值，则使用default指定的值来填充

- not null: 非空约束，域完整性

  指定某列的值不为空，在插入数据的时候必须非空 '' 不等于 null, 0不等于 null

- unique: 唯一约束，实体完整性

- primary key: 主键约束，实体完整性

- foreign key: 外键约束，参照完整性

  通过建立外键，设置表与表之间的约束性，限制数据的录入

  被外键约束的列，要么为null，要么取值必须参照主表列中的值

  ```mysql
  create table emp(
  	id int primary key auto_increment,
      name varchar(30) not null,
      deptno int default 0,
      foreign key(deptno) references dept(id) # 直接添加外键约束
  );
  ```

  为已经添加好的数据表添加外键（当表与表之间需要互相添加外键的时候需要用到）

  ```mysql
  alter table table_name add constraint table_name(col_name) references tb_name(co_name);# 注意外键和主键的数据类型必须一致，包括是否无符号(是否为)
  ```

  ***级联关系***

  - on delete cascade：删除主表中的数据时，从表中的数据随之删除
  - on update cascase：更新主表中的数据时，从表中的数据随之更新
  - on delete set null：删除主表中的数据时，从表中的数据置空

- check: 检查约束，域完整性

  类似于自定义约束，具体使用方法如下

- auto_increment: 自增长约束

  ==自增列必须是键，但是不一定非是主键，并且只能存在一个自增列==

  ```mysql
  create table test(
  	id int unsigned not null,
      col int auto_increment not null,
      primary key(id),
      key(col)
  );# 可以创建成功!
  ```

  ![image-20220404141310760](https://gitee.com/ababa-317/image/raw/master/images/image-20220404141310760.png)

  关于mysql中主键(primary key)、外键(foreign key)、键(key)和索引(index)的区别

  key 是数据库的**物理结构**，它包含两层意义和作用，

  1. 约束（偏重于约束和规范数据库的结构完整性）

  2. 索引index（辅助查询用的）

  单纯的key和index起的作用相同

  **primary key** 有两个作用，一是约束作用（constraint），用来**规范一个存储主键和唯一性**，但同时也在此key上建立了一个主键索引

  **unique key** 也有两个作用，一是约束作用（constraint），规范数据的**唯一性**，但同时也在这个key上建立了一个唯一索引（当然也可以选择不创建索引，但是一般都默认创建）

  **foreign key** 也有两个作用，一是约束作用（constraint），规范数据的引用完整性，但同时也在这个key上建立了一个index

- unsigned: 无符号约束

- zerofill: 零填充约束

==所有约束的实现如下==

```mysql
creata table tmp(
    col0 int,
    col1 int default 0, # 默认约束
    col2 int not null, # 非空约束
    col3 int unique, # 唯一约束
    col4 int auto_increment, # 自增长约束
    col5 int unsigned, # 无符号约束
    col6 int(6) zerofill, # 零填充约束
    col7 int default 0,
    primary key (col0), # 主键约束
    index (col1) # 创建索引
    unique (col1,col2), # 复合唯一约束
    key (col4), # 自增长约束必须设置为键
    foreign key(col7) references main(id) on delete cascade, # 添加外键约束
    check(col1>3000) # 添加检查约束
);
```

## 字段

### 数据类型

> 选择原则：符合需求+够用+不浪费

**数据类型以及类型修饰的意义**：

- 确定该字段值的类型
- 确定该字段所占据的空间大小
- 确定该字段是定长还是变长的
- 该字段如何进行比较和排序
- 该字段是否能够索引
- 该字段是外键、主键....?

**数据类型分类**

1. 数值型

   - 整型：$TINYINT,SMALLINT,MEDIUINT,INT,BIGINT$
   - 浮点型：包括单精度和双精度浮点型
     - $float(M,D)$其中M表示浮点型的长度（不包括符号和小数点），D表示小数点后面数字的位数
     - $decimal(M,D)$以字符串的形式存储，定点类型小数，如果对于精度要求比较高的话推荐使用decimal类型

   ![MySQL的数据类型及其常用修饰符详解_Mysql的数据类型](http://s9.51cto.com/wyfs02/M02/8A/AC/wKioL1g3mobgsiRQAAEOuN_LocM545.png)

2. 字符型：$CHAR,VARVHAR,BINARY,VARBINARY,TEXT等$

   比较常用的就是char型和varchar型

   ![MySQL的数据类型及其常用修饰符详解_Mysql的数据类型_02](http://s5.51cto.com/wyfs02/M00/8A/B0/wKiom1g3mqOxypGaAACjNfEmuW8532.png)

   SQL内建函数（需要实践一下）

   UCASE() - 将某个字段转换为大写 

   LCASE() - 将某个字段转换为小写

   MID() - 从某个文本字段提取字符，MySql 中使用 

   SubString(字段，1，end) - 从某个文本字段提取字符 

   LEN() - 返回某个文本字段的长度 

   ROUND() - 对某个数值字段进行指定小数位数的四舍五入

   ```mysql
   
   ```

3. 日期时间型：$DATE,TIME,DATETIME,TIMESTAMP$

   常用的为$DATE,DATETIME,TIMESTAMP$

   ![MySQL的数据类型及其常用修饰符详解_Mysql的数据类型_03](https://s4.51cto.com//wyfs02/M00/8A/B0/wKiom1g3mrPRp64CAABsxlmpJZs268.png)

   **内建函数**

   NOW() 返回当前的日期和时间 

   CURDATE() 返回当前的日期 

   CURTIME() 返回当前的时间 

   DATE() 提取日期或日期/时间表达式的日期部分 

   EXTRACT() 返回日期/时间按的单独部分 

   DATE_ADD() 给日期添加指定的时间间隔 

   DATE_SUB() 从日期减去指定的时间间隔 

   DATEDIFF() 返回两个日期之间的天数 

   DATE_FORMAT()用不同的格式显示日期/时间

   **基本使用**

   ```mysql
   create table people(
   	id int auto_increment primary key,
       birth_date date not null default '1999-1-1',
   );
   insert into people(birth_date)
   values
   ('1999-1-2'),
   (curdate()),
   (date(now()));# now()返回的数据是datatime类型,使用data(now())来获取对应的data段数据
   # 日期格式转换
   select date_format(birth_date,'%Y-%M/%b-%D;%y-%m-%d') from people;
   ```

   ![image-20220404150710634](https://gitee.com/ababa-317/image/raw/master/images/image-20220404150710634.png)

   关于默认值设置：只有时间戳timestamp类型支持系统默认值设置，其他类型都不支持

4. 枚举型：需要列出该字段的所有可能值，存储范围是0-65535bytes（可以在一定程度上代替check约束）

   ```mysql
   enum('Female','Male')
   ```

5. 布尔型：mysql中会自动转换为tinyint，只有两种取值，1代表true、0代表false

### 字段修饰

> 在添加数据库字段的时候，可以为数据库添加字段修饰符用于**约束**数据库表中的一些字段，根据字段的不同，有不同的修饰符

<table border='1'>
    <th>数据类型</th>
    <th>修饰符</th>
    <tr>
        <td align='center' valign='center'>通用</td>
        <td valign='center'>
            <ul>
                <li>NULL:允许为空</li>
                <li>NOT NULL:必须非空</li>
                <li>DEFAULT N:设置默认值为N</li>
                <li>PRIMARY KEY:设置主键约束</li>
                <li>UNIQUE:设置唯一约束</li>
            </ul>
        </td>
    </tr>
    <tr>
    	<td align='center' valign='center'>整型</td>
        <td valign='center'>
            <ul>
                <li>UNSIGNED:无符号</li>
                <li>AUTO_INCREMENT:自动增长</li>
            </ul>
        </td>
    </tr>
    <tr>
    	<td align='center' valign='center'>浮点型</td>
        <td valign='center'>
            <ul>
                <li>UNSIGNED:无符号</li>
            </ul>
        </td>
    </tr>
</table>
## SQL查询语句

> 数据查询语言（Query Language），从数据库中获取指定的数据，是数据库中的核心操作

==查询语句基本结构==

```mysql
select 字段
from table_names
where conditions about tuples of the tables
group by one or more attributes
having attributes
order by one or more attributes;
```

- select语句：指定要显示的属性列
- from语句：执行查询对象
- where语句：执行查询条件
- group by语句：对查询结果按照执行列的值进行分组（通常会在每组中作用**集函数**）
- having语句：筛选出只有满足指定条件的组
- order by语句：对查询结果按照指定列值进行升序或者降序排序

==查询语句的执行顺序==

> 和其他编程语言不同，sql查询语句并不是顺序执行的

1. from语句组装来自不同数据源的数据（先join再on）$\rightarrow$==首先获取数据源==
2. where语句基于执行的条件对于记录行进行筛选$\rightarrow$==对获取的数据源进行初步筛选==
3. group by语句将数据划分为多个分组$\rightarrow$==数据分组==（如果应用了group by，那么后面的所有步骤都只能得到的分组依据值或者是聚合函数值（count、sum、avg等）。原因在于最终的结果集中只为每个组包含一行，这一点需要牢记 ）
4. 使用集函数（聚合函数）进行计算$\rightarrow$==将分组的数据合并为一行==
5. 使用having语句筛选分组$\rightarrow$==对已分组的数据进行筛选==
6. select语句选择字段$\rightarrow$==筛选出所需字段==
7. 使用order by语句对结果进行排序$\rightarrow$==排序==

**每个步骤都会产生一个虚拟表，该表将作为下一个步骤的输入（虚拟表对于使用者不可见，只有最后一步生成的表才会传给调用者）**

### 单表查询

- 普通查询

  ```mysql
  select Sno,Sname
  from student;
  select *
  from student;
  ```

- 查询经过计算的值（select语句的目标列可以为<表达式>）

  ```mysql
  select Sname,2022-Sage,lower(Sname) # lower代表小写
  from student;
  ```

- 使用列别名改变查询得到的列标题

  ```mysql
  select Sname as NAME,birth as BIRTHDAY
  from student;
  ```

- 利用distinct去除重复行（去重）

  ```mysql
  select distinct Sno,Sname # distinct作用的范围是选出的所有行
  from student;
  ```

  

**where语句表达查询条件**

| 查询条件 |                 谓词                 |
| :------: | :----------------------------------: |
|   比较   | =,>,<,>=,<=,!=<br>NOT+上述比较运算符 |
| 确定范围 |     between and,not between and      |
| 确定集合 |              in,not in               |
|   空值   |         is null,is not null          |
| 多重条件 |                and,or                |
| 字符匹配 |            like,not like             |

- **集合查询**

  ```mysql
  select Sname,Ssex
  from student
  where Sname in ('wwt','test','hhh');
  ```

- 字符匹配

  where语句中可以对字符串进行模板匹配

  where attribute [not] like pattern

  其中%代表任意长度的字符串，_代表任意单个字符

  ```mysql
  # 查询姓刘学生的姓名、学号和性别
  select *
  from student
  where Sname like '刘%';
  # 查询全名为3个字的学生姓名
  select Sname
  from student
  where Sname like '___';
  ```

  *当用户需要查询的字符本身就含有%或者_的时候，就需要使用ESCAPE+换码字符对通配符进行转义*

  ```mysql
  select *
  from student
  where Cname like 'DB\_Design' escape '\';
  ```

**涉及空值的查询**

> 规则： 
>
> Where 语句中的条件表达式有三种可能的计算结果：True，False，或者 UnKnown 
>
> 任何一个值与NULL进行比较，返回的结果是UnKnown 
>
> Where子句对被查询表中每一条记录进行条件表达式的计算，只有在计算结果为True时当前记录才会被选中
>
> 也就是说会默认忽视空值不将其放到查询结果中

测试是否为空值需要使用is null或者is not null来代替

```mysql
# 查询缺考的学生姓名
select Sname
from student
where grade is null;
```

**对查询得到的结果进行排序**

- 可以按照一个或者多个属性进行排序（排序优先级逐步递减）

  ==ASC==（ascend：上升）：升序（空值最先显示）

  ==DESC==（descend：下降）：降序（空值最后显示） 
  
  注意上面这两个要放在列名的后面
  
  ```mysql
  select Sno,Grade
  from student
  where Cno='3'
  order by Grade desc;
  select *
  from student
  order by Sdept asc,Sage desc;
  ```

### 聚集和分组

> 在select语句中可以使用集函数，对指定的列进行聚合计算
>
> 聚合函数——又名组函数，也就是对一个组进行操作，返回一个值的函数
>
> Plus：同样是默认忽略缺省值null

*常见集函数如下*

1. 计数count([distinct|all] 列名 | *)
2. 计算总和sum([distinct|all] 列名)
3. 计算平均值avg([distinct|all] 列名)
4. 求最大值max([distinct|all] 列名)
5. 求最小值min([distinct|all] 列名)

**对查询结果进行分组**

使用GROUP BY子句分组

- 细化集函数的作用对象

- 未对查询结果分组时，集函数将作用于**整个查询结果**

  对查询结果分组后，集函数将**分别作用于每个组**

- GROUP BY子句的作用对象是查询的中间结果表

- 分组方法：按指定的一列或多列值分组，值相等的为一组

- 使用GROUP BY子句后，SELECT子句的列名列表中只能出现**分组属性**和**集函数**

使用having语句筛选出最终结果

- having语句和where语句的区别：两者的作用对象不同

  where语句作用于基表和视图，从中选择满足条件的元组

  **having语句作用于组**，从中选出满足条件的组

- having语句中出现的列只能是**group by子句或者集函数中出现的列**。

  ```mysql
  select Sno
  from student
  group by Grade
  having max(Grade)>100;
  ```

### 多表查询

> 针对多张表的数据查询（本质上就是先对两个表进行笛卡尔积再由select选择返回结果）
>
> 最基本语法格式为：`select * from tb1,tb2`

#### 广义笛卡尔积

> 最普通的连接（又名无脑连接）
>
> 直接进行多表查询的结果集巨大，慎用。
>
> 可以不写连接符（默认），也可以规范一点写`from tb1 cross join tb2`

问题1：多表查询的列重名问题

![image-20220403183426311](https://gitee.com/ababa-317/image/raw/master/images/image-20220403183426311.png)

可以投影查询的设置列别名（或者还可以再修改表名使得形式更加简洁）来解决

```mysql
select 
s1.id s1id,s2.id s2id,
s1.name s1name,s2.name s2name,
s1.gender s1gender,s2.gender s2gender
from mysqlearn as s1,mysqlearn1 as s2;# 虽然但是，还是相当麻烦.....
```

![image-20220403184022237](https://gitee.com/ababa-317/image/raw/master/images/image-20220403184022237.png)

#### 等值连接

> Where子句中的连接运算符为=号的连接操作（等价于**内连接**+on）
>
> `[tb1.]col1=[tb2.]col2`（引用唯一属性名的时候可以省略表名前缀）

```mysql
select student.sno,sname,cno
from student,sc
where student.sno=sc.sno;
```

#### 自然连接

> 自然连接就是对两表之间**相同名字**和**数据类型**的列进行等值连接

```mysql
select *
from t_student natural join t_class
```

#### 内连接

> 查询出两个表的**共同部分**，也就是笛卡尔积满足on条件的部分（等价于等值连接）
>
> ![inner-join](https://www.liaoxuefeng.com/files/attachments/1246892164662976/l)

```mysql
select * 
from student inner join class
on student.class_id=class.id;
# 上述语句等价于
select *
from student,class
where student.class_id=class.id;
```

#### 外连接

> mysql中不支持全外连接（outer join），但是其实全外连接就是一个笛卡尔积......，所以全外连接其实没啥意义
>
> 所以主要需要注意的就是左外连接（left join）和右外连接（outer join）
>
> Plus：这些连接操作都只有在**on**条件下才有意义，否则不加条件的话都是笛卡尔积

**左外连接**

> 选出左表存在右表不存在+左右表都存在的记录
>
> 右表不存在的字段使用null补齐

![left-outer-join](https://www.liaoxuefeng.com/files/attachments/1246893588481376/l)

**右外连接**

> 选出右表存在右左表不存在+左右表都存在的记录
>
> 左表不存在的字段使用null补齐

![right-outer-join](https://www.liaoxuefeng.com/files/attachments/1246893609222688/l)

### 子查询

> 我们通常将一个select-from-where语句称为一个查询块
>
> 子查询就是将一个查询块嵌套在另外一个查询块的where语句或者having语句的条件中（就是==嵌套查询==），**这是比较常用的方式**
>
> Plus：子查询不能使用order by语句，因为用了也没啥意义

```mysql
select Sname
from student
where Sno in (
	select Sno
    from sc
    where cno='2'
);
```

- 子查询还可以插入from子句中作为临时表使用，但是此时需要对临时表进行更名操作（废话）

  ```mysql
  select tmp.sno,sname,cno
  from sc,(
  	select sno,sname
      from student
      where sdept='is'
  )as tmp
  where sc.sno=tmp.sno;
  ```

相关子查询和不相关子查询

- 相关子查询：**内层查询依赖于外层子查询的结果**

  首先取外层查询中表的第一个元组（==逐行考察==），根据它与内层查询相关的属性值处理内层查询，若WHERE子句返回值为真，则取此元组放入结果表；

  然后再取外层表的下一个元组；

  重复这一过程，直至外层表全部检查完为止。

- 不相关子查询：**子查询的结果用于建立其父查询的查找条件**

  由里向外逐层处理。即每个子查询在上一级查询处理之前求解

#### 子查询——谓词

- 带==in==谓词的子查询

  ```mysql
  select Sno,Sname,Sdept
  from student
  where Sdept in(
  	select Sdept
      from student
      where Sname='刘晨'
  ); # 不相关子查询
  ```

  比较复杂的例子：查询选修了课程名为"信息系统"的学生学号和姓名

  ```mysql
  # 方法一:利用子查询，思路清晰但是代码冗长
  select Sno,Sname # 最终查询得到的结果，可以直接在第一步确定
  from Student # 数据来源同样是确定的
  where Sno in( # 找到选课表中选修了"信息系统"这门课的学生
  	select Sno
      from SC
      where Cno in(
      	select Cno
          from Course
          where Cname="信息系统"
      )
  );
  # 方法二:利用自然连接，一下搞定
  select Sno,Sname
  from Student natural join SC natural join Course
  where Course.name='信息系统';
  # 方法三:等值连接，和方法二类似
  select Sno,Sname
  from Student,SC,Course
  where Student.Sno=SC.Sno
  and SC.Cno=Course.Cno
  and Course.name='信息系统';
  ```

- 带有==any==或者==all==谓词的子查询

  any：任意一个值

  all：所有制
  
  一般与比较运算符（>,<,>=,<=,!=,=）配合使用
  
  例：查询其他系比信息系任意一个学生年龄小的学生姓名和年龄
  
  ```mysql
  select Sanme,Sage
  from student
  where Sage < any(
  	select Sage
      from student
      where Sdept='IS'
  ) and Sdept!='IS';
  ```
  
  通常，any和all谓词可以使用***集函数***去实现，并且使用集函数实现子查询一般比直接使用any和all的查询效率要高很多，因为集函数通常能够减少比较次数
  
  ```mysql
  select Sanme,Sage
  from student
  where Sage < (
  	select max(Sage)
      from student
      where Sdept='IS'
  ) and Sdept!='IS';
  ```
  
- 带有==exists/not exists==谓词的子查询

  带有exists谓词的子查询不返回任何数据，**只产生逻辑真值"true"或逻辑假值"false"**

  若内层查询结果非空，则返回真值；若内层查询结果为空，则返回假值。

  由EXISTS引出的子查询，其目标列表达式通常都用==*== ，因为带EXISTS的子查询只返回真值或假值，给出列名无实际意义

  ```mysql
  select * 
  from A
  where exists(
  	select *
      from B
      where B.a=A.a
  ); # 相关子查询
  ```

  所有带in谓词、比较运算符、any和all谓词的子查询都能用带exists谓词的子查询等价替换。

  - 使用==exists/not exists==实现全称量词$\forall$
  
    例子：***查询选修了全部课程的学生姓名***。
  
    Student(学生表)、SC(选课表)、Course(课程表)
  
    查询选修了全部课程的学生姓名$\leftrightarrow$查询一个学生，不存在这样的课程他没有选修
    $$
    (\forall)P\leftrightarrow \neg(\exist(\neg P))
    $$
    mysql貌似不支持除法操作（😓）
  
    ```mysql
    select Sname
    from Student
    where not exists(
    	select *
        from Course
        where not exists(
        	select *
            from SC
            where SC.Sno=Student.Sno and
            SC.Cno=Cource.Cno
        )
    );
    ```
  
  - 使用==exists/not exists==实现逻辑蕴含$\rightarrow$（implication）
  
    SQL语言中不存在蕴含谓词，需要通过谓词演算进行等价转化
    $$
    p\rightarrow q\leftrightarrow \neg p \and q
    $$
    例子：查询至少选修了学生95002选修的全部课程的学生号码
  
    关系代数实现
    $$
    \Pi_{Sno,C\#}\div \Pi_{C\#}{\sigma_{Sno='95002'}{SC}}
    $$
    对于任意课程y，学生95002选修了，则学生x也选修了
    
    得到关系式如下
    $$
    \forall y (p\rightarrow q) = \neg(\exist(y)(\neg (p\rightarrow q)))=\neg\exist(y)(p\and \neg q)
    $$
    
    ```mysql
    select Sno
    from Student
    where not exist(
    	select *
        from SC
        where SC.Cno in (
        	select Cno
            from SC
            where SC.Sno='95502'
        ) and SC.Cno not in(
      		select Cno
            from SC
            where Sno!=SC.Sno
        )
    );
    ```
    
    

### 集合查询

mysql只支持并操作Union，其他交（intersect）、差（except）都可以简单的利用where语句实现（因为太简单就不赘述了）

## 视图

>   视图是一种==虚表==（virtual table），是从一个或多个基本表中导出的表（视图就是在数据库中存储的一条数据查询语句）。
>
>   DBMS指定CREATIVE VIEW语句只是*把视图的定义存入数据字典*，并不执行其中的查询语句。
>
>   对视图进行查询的时候，按照视图的定义从基本表中将数据查出
>
>   对于某些视图（可更新视图），可以对视图执行数据更新操作，数据库会根据视图的定义去更新对应的基本表数据。
>
>   ==$What\ is\ 视图\ used\ for?$==
>
>   可以看看视图的优点，体会视图的用途
>
>   1.   **简单**：使用视图的用户完全不需要关心后面对应的**表的结构、关联条件和筛选条件**，对用户来说已经是<u>***过滤好的复合条件的结果集***</u>。
>   2.   ==**安全**==：使用视图的用户==只能访问他们被允许查询的结果集==，**对表的权限管理并不能限制到某个行某个列**，但是通过视图就可以简单的实现
>   3.   **数据独立**：一旦视图的结构确定了，可以屏蔽表结构变化对用户的影响，源表增加列对视图没有影响；源表修改列名，则可以通过修改视图来解决，不会造成对访问者的影响
>
>   总而言之，使用视图的大部分情况是为了==保障数据安全性==，==提高查询效率==。比如说我们<u>**经常用到几个表的关联结果**</u>，那么我们就可以使用视图来处理，或者说第三方程序需要调用我们的业务库，可以按需创建视图给第三方程序查询。

### 视图创建以及使用方法

**全语法汇总：**

```mysql
CREATE
    [OR REPLACE] # 表示替换已有视图，如果该视图不存在，则无效
    [ALGORITHM = {UNDEFINED | MERGE | TEMPTABLE}] # 表示视图选择算法
    [DEFINER = user] # 指定谁是视图的创建者或定义者，如果不指定，则默认创建视图的用户就是定义者
    [SQL SECURITY { DEFINER | INVOKER }] # SQL安全性
    VIEW view_name [(column_list)]
    AS select_statement # select语句，表示从基表或其他视图中选择列
    [WITH [CASCADED | LOCAL] CHECK OPTION]; # 表示在视图更新的时候保证约束
    # cascade是默认值,表示更新视图的时候,要满足视图和表的相关条件(推荐)
    # local表示更新视图的时候,满足视图定义的一个条件即可
```

**创建视图的基本格式：**

```mysql
create view view_name
[(column_list)]
as select_statement
with check option;
```

**视图创建范例**

```mysql
create view v_match
as 
select a.PLAYERNO,a.NAME,MATCHNO,WON,LOST,c.TEAMNO,c.DIVISION
from 
PLAYERS a,MATCHES b,TEAMS c
where a.PLAYERNO=b.PLAYERNO and b.TEAMNO=c.TEAMNO;
```

定义视图时，组成视图的属性列需要**全部省略**或者**全部指定**。

-   全省略：视图属性由子查询select目标列中的字段构成
-   全指定：具体见如下情形
    1.   某个目标列是<u>集函数</u>或者<u>列表达式</u>
    2.   多表连接的时候出现了**同名列**作为视图字段
    3.   需要在视图中为某个**列重命名**更合适的名字

不建议以`select *`的方式创建视图，这样定义的视图，当<u>修改基表的结构时</u>（添加列不会影响，并且默认不会将添加的列放入视图中），**基表和视图之间的映像关系很容易被破坏（当然正常创建的也会被破坏，只是不会那么容易？）**，导致视图无法正常工作

![image-20220412145526514](https://gitee.com/ababa-317/image/raw/master/images/image-20220412145526514.png)

where语句可能会限制视图查询的输出，导致插入视图的数据在视图中看不到（“矛盾语句”可以插入，但是查询的时候看不到）

可以通过with check option增加插入限制（添加后矛盾语句无法插入）

### 视图规范

-   视图命名建议统一前缀，比如==以v或view开头==，便于识别。

-   SQL SECURITY使用默认的DEFINER，表示已视图定义者的权限去查询视图。

-   视图定义者建议使用相关程序用户。

-   视图不要关联太多的表，造成数据冗余。

-   查询视图时要附带条件，不建议每次都查询出所有数据。

-   视图迁移要注意在新环境有该视图的定义者用户。

-   不要直接更新视图中的数据，视图只作查询。

## SQL控制语句

>   1.   授予或访问数据库的某种特权
>   2.   控制数据库操纵事务发生的事件以及效果
>   3.   对数据库实行监控等等
>
>   其余在后续课程学习中完善

# MySql语句规范

> 自己总结的MySql书写时的语句规范
