[toc]

# MYSQL操作总结

## 数据库和表操作

> 这里讲的是数据库和表的创建和删除等一系列操作（不包括关系模型的细节操作）

### 数据库操作

- 查看数据库

  ```mysql
  show databases;# 显示所有数据库
  ```

- 使用数据库

  ```mysql
  use db_name;# 使用该数据库进行操作(操作该数据库下的表)
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
  alter table name_old rename name_new; # 方法2
  ```

#### 修改表的具体结构

- 添加字段

  ```mysql
  alter table tb_name add column co_name varchar(80) not null;
  ```

- 删除字段

  ```mysql
  alter table tb_name drop co_name;
  ```

- 修改字段结构+重命名

  ```mysql
  alter table tb_name change column1 column2 varchar(100) not null;
  # change比modify更加全面,可以修改字段名
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

> 设计关系数据表的时候，看上去唯一的列，例如身份证号、邮箱地址，但是因为他们具备业务含义（身份证号和邮箱都有可能会修改），所以不宜作为主键
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

> 无论是否创建索引，对于用户和应用程序来说，使用关系数据库不会有任何区别。这里的意思是说，当我们在数据库中查询时，如果有相应的索引可用，数据库系统就会自动使用索引来提高查询效率，如果没有索引，查询也能正常执行，只是速度会变慢。因此，索引可以在使用数据库的过程中逐步优化。

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
     - $float(M,D)$其中M表示浮点型的长度（不包括符号和小数点），d表示小数点后面数字的位数
     - $decimal(M,D)$以字符串的形式存储，定点类型小数，如果对于精度要求比较高的话推荐使用decimal类型

   ![MySQL的数据类型及其常用修饰符详解_Mysql的数据类型](http://s9.51cto.com/wyfs02/M02/8A/AC/wKioL1g3mobgsiRQAAEOuN_LocM545.png)

2. 字符型：$CHAR,VARVHAR,BINARY,VARBINARY,TEXT等$

   比较常用的就是char型和varchar型

   ![MySQL的数据类型及其常用修饰符详解_Mysql的数据类型_02](http://s5.51cto.com/wyfs02/M00/8A/B0/wKiom1g3mqOxypGaAACjNfEmuW8532.png)

3. 日期时间型：$DATE,TIME,DATETIME,TIMESTAMP$

   ![MySQL的数据类型及其常用修饰符详解_Mysql的数据类型_03](https://s4.51cto.com//wyfs02/M00/8A/B0/wKiom1g3mrPRp64CAABsxlmpJZs268.png)

4. 枚举型：需要列出该字段的所有可能值，存储范围是0-65535bytes

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

- 利用distinct去除重复行

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

- 集合查询

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

  ASC：降序（空值最后显示） DESC：升序（空值最先显示）

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

> Where子句中的连接运算符为=号的连接操作（等价于**内连接**）
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
  select is.sno,sname,cno
  from sc,(
  	select sno,sname
      from student
      where sdept='is'
  )as is
  where sc.sno=is.sno;
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
  from Student natural join SC natural join Course;
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

### 集合查询



## SQL操纵语句



## SQL控制语句





# MySql语句规范

> 自己总结的MySql书写时的语句规范
