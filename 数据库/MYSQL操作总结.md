[toc]

# MYSQL操作总结

## 杂

### 关于大小写支持

-   数据库名+表名都不支持大写（自动转换为小写）
-   字段名支持大写

### MySQL不允许的语法格式

```mysql
create table test if not exists(
	id int primary key,
    num int not null,# 此行不可以用‘,’进行结尾
)
```

### MySQL注释

```mysql
#这是一个注释
-- 这也是一个注释，但是必须空一格
```

### MySQL输出格式

>   有时候，由于数据库字段过多或者数据集过大，查询操作会导致数据无法显示在一行而出现无法对齐的问题，此时可以使用`\G`使得查询结果垂直显示
>
>   $Plus:$更多更好的解决方案可以看这里https://www.itranslater.com/qa/details/2117995727778481152

```mysql
select * from test \G;
```

### 优化MySQL体验

[mycli](https://zhuanlan.zhihu.com/p/349104648)

### 关于MySQL的各种报错解决

-   `1418`:函数创建失败报错，该报错产生的原因是MySQL默认会关闭创建函数的功能，可以通过`show variables like "%func%";`语句来查看函数功能是否开启，如果未开启的话可以使用`set global log_bin_trust_function_creators=1;`进行开启（该命令的目的是设置临时环境变量）。

    ![image-20220423103924940](https://wwt13-images-1305051431.cos.ap-beijing.myqcloud.com/img/image-20220423103924940.png)

## SQL分类

- 数据查询语言（DQL）： 其语句也称为“数据检索语句”，用以从表中获得数据，确定数据怎样在应用程序给出。`Database Query Language`
- 数据操作语言（DML）： 其语句包括动词 *INSERT、UPDATE 和 DELETE*。它们分别用于添加、修改和删除。`Database Manage Language`
- 事务控制语言（TCL）： 它的语句能确保被 DML 语句影响的表的所有行及时得以更新。包括COMMIT（提交）命令、SAVEPOINT（保存点）命令、ROLLBACK（回滚）命令。`Transaction Control Language`
- 数据控制语言（DCL）： 它的语句通过 GRANT 或 REVOKE 实现权限控制，确定单个用户和用户组对数据库对象的访问。某些 RDBMS 可用 GRANT 或 REVOKE 控制对表单个列的访问。`Database Control Language`
- 数据定义语言（DDL）： 其语句包括动词 *CREATE、ALTER 和 DROP*。在数据库中创建新表或修改、删除表（CREATE TABLE 或 DROP TABLE）、为表加入索引等。`Database Define Languaga`
- 指针控制语言（CCL）： 它的语句，像 DECLARE CURSOR、FETCH INTO 和 UPDATE WHERE CURRENT 用于对一个或多个表单独行的操作。`Cursor Control Language`

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
>   *<font color="red">Attention:</font>修改数据类型的时候无法对完整性约束条件进行修改，完整性约束条件必须单独修改定义。*
>
>   $Plus:$修改原有列定义可能会破坏已有数据。

- 添加字段

  ```mysql
  alter table tb_name add column co_name varchar(80) not null;
  ```

  添加完整性约束条件

  ```mysql
  alter table review add [约束名] index(col0);# 给col0字段添加index
  ```

- 删除字段

  ```mysql
  alter table tb_name drop co_name;
  ```

  删除完整性约束

  ```mysql
  # 方法1:直接删除
  alter table tb_name drop intrgrity_constraints_name col_name;
  # 方法2:先查看约束名再进行删除(更加稳妥)
  show create table tb_name;# 查看约束名和约束key
  alter table tb_name drop in_co_key in_co_name;# 不太明白怎么删除
  # 感觉下面这种方法更好
  alter table tb_name drop constraint key_name;
  ```

- 修改字段结构+重命名

  ```mysql
  alter table tb_name change column1 column2 varchar(100) not null;
  # change比modify更加全面,可以修改字段名
  alter table tb_name modify col1 .....;
  ```
  
- 更新字段的值（不建议使用，建议update全部用于元组操作）

  ```mysql
  update table_name set col_name=new_value where condition;# 需要记忆
  ```

### 数据更新

>   对表中的*元组*进行操作
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
>            # 可以依据此对表进行扩容
>            insert into tb_name(col1,col2,...)
>            select col1,col2,....
>            from tb_name;
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

2.   **数据更新操作**（修改多个元组的值，不指定where的话，**默认作用范围为所有元组**）

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

> 设计关系数据表的时候，看上去唯一的列，例如身份证号、邮箱地址，但是因为他们具备业务含义（身份证号和邮箱都**有可能会修改**），所以不宜作为主键（主键原则：唯一且不会进行修改）
>
> *但是这些列根据业务要求，又同时具备了唯一性约束*，这种时候，就可以给这些列添加一个唯一索引
>
> 注意：MySql对于唯一索引不区分大小写

```mysql
alter table students add unique index uni_name(name);
# 也可以只对某一列添加一个唯一约束而不创建唯一索引
alter table students add constraint uni_name unique(name);
```

![image-20220721092420443](/Users/apple/Documents/Notes/assets/image-20220721092420443.png)

---

> 无论是否创建索引，对于用户和应用程序来说，使用关系数据库不会有任何区别。这里的意思是说，当我们在数据库中查询时，如果有相应的索引可用，数据库系统就会自动使用索引来提高查询效率，如果没有索引，查询也能正常执行，只是速度会变慢。因此，***索引可以在使用数据库的过程中逐步优化***。

## 约束

> 约束，*是一种限制*，它是对表的行和列的数据做出约束，确保表中数据的完整性和唯一性
>
> 三种完整性：域、实体、参照完整性（其实还有一个用户完整性，但是这里不提及，因为这完全是用户自定义的）
>
> 域完整性：就是对于数据表中*字段的约束*（unique,not null,default,unsigned等等）
>
> 实体完整性：通过主键约束和候选键约束实现
>
> 参照完整性：就是外键约束

**分类如下**

- *default*：默认约束，域完整性

  指定某列的**默认值**，插入数据时，如果此列赋值，则使用default指定的值来填充

- *not null*: 非空约束，域完整性

  指定某列的值不为空，在插入数据的时候必须非空 '' 不等于 null, 0不等于 null

- *unique*: 唯一约束，实体完整性

- *primary key*: 主键约束，实体完整性

- *foreign key*: 外键约束，参照完整性

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

- *check*: 检查约束，域完整性

  类似于自定义约束，具体使用方法见<a href="#check">此处</a>

- *auto_increment*: 自增长约束

  ==自增列必须是键，但是不一定非是主键，并且只能存在一个自增列==

  ```mysql
  create table test(
  	id int unsigned not null,
      col int auto_increment not null,
      primary key(id),
      key(col)
  );# 可以创建成功!
  ```

  ![image-20220404141310760](https://wwt13-images-1305051431.cos.ap-beijing.myqcloud.com/img/image-20220404141310760.png)

  关于mysql中主键(primary key)、外键(foreign key)、键(key)和索引(index)的区别

  key 是数据库的**物理结构**，它包含两层意义和作用，

  1. 约束（偏重于约束和规范数据库的结构完整性）

  2. 索引index（辅助查询用的）

  单纯的key和index起的作用相同

  **primary key** 有两个作用，一是约束作用（constraint），用来**规范一个存储主键和唯一性**，但同时也在此key上建立了一个主键索引

  **unique key** 也有两个作用，一是约束作用（constraint），规范数据的**唯一性**，但同时也在这个key上建立了一个唯一索引（当然也可以选择不创建索引，但是一般都默认创建）

  **foreign key** 也有两个作用，一是约束作用（constraint），规范数据的引用完整性，但同时也在这个key上建立了一个index

- *unsigned*: 无符号约束

- *zerofill*: 零填充约束

  ![image-20220721093714599](/Users/apple/Documents/Notes/assets/image-20220721093714599.png)

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

### <span name="check">check约束拓展</span>

>   支持正则表达式

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

   char(10)和varchar(10)的区别，char(10)代表开辟用于存储的空间就是固定的用于存放10个==字符==，而varchar(10)则是可以变动的，只是在数据库初始化的时候会预存10个字符的空间来适应它（可扩容）

   ![MySQL的数据类型及其常用修饰符详解_Mysql的数据类型_02](http://s5.51cto.com/wyfs02/M00/8A/B0/wKiom1g3mqOxypGaAACjNfEmuW8532.png)

3. 日期时间型：$DATE,TIME,DATETIME,TIMESTAMP$

   常用的为$DATE,DATETIME,TIMESTAMP$

   ![MySQL的数据类型及其常用修饰符详解_Mysql的数据类型_03](https://s4.51cto.com//wyfs02/M00/8A/B0/wKiom1g3mrPRp64CAABsxlmpJZs268.png)

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

   ![image-20220404150710634](https://wwt13-images-1305051431.cos.ap-beijing.myqcloud.com/img/image-20220404150710634.png)

   关于默认值设置：只有时间戳timestamp类型支持系统默认值设置，其他类型都不支持

4. 枚举型：需要列出该字段的所有可能值，存储范围是0-65535bytes（可以*在一定程度上代替check约束*）

   ```mysql
   CREATE TABLE tickets (
       id INT PRIMARY KEY AUTO_INCREMENT,
       title VARCHAR(255) NOT NULL,
       priority ENUM('Low', 'Medium', 'High') NOT NULL
   );
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
## SQL内建函数汇总

#### 一.聚合函数

1. max(x)：最大值函数

2. min(x)：最小值函数

3. count()：总数函数

4. round(x,d)：四舍五入函数，x是需要处理的数，d是保留几位小数

   ![image-20220721100848427](/Users/apple/Documents/Notes/assets/image-20220721100848427.png)

5. sum(x)：累加值函数

6. avg(x)：平均值函数

7. uniq(x)：取去充数函数（近似结果）

8. uniqExact(x)：取去重数函数（准确结果）

9. argMax(arg,val)：按val排序，取val最大时对应arg的值

10. argMin(arg,val)：按val排序，取val最小时对应arg的值

11. uniqIf(x,v)：当v成立时，取去重数（近似结果）

12. uniqExactIf(x,v)：当v成立时，取去重数（准确结果）

13. quantile(level)(x)：取分位数（近似值）

14. quantileExact(level)(x)：取分位数（准确值）

#### 二.时间函数

1. now()：获取当前时间戳

2. curate/curtime：获取当前日期/时间

3. time()：将时间戳转化成时分秒

4. date()：将时间戳或日期转成日月年

   ![image-20220721102030569](/Users/apple/Documents/Notes/assets/image-20220721102030569.png)

5. date_format(time,format)：将时间转化为字符串

   ![image-20220721102554436](/Users/apple/Documents/Notes/assets/image-20220721102554436.png)

6. str_to_date(str,format)：将字符串转化为时间（注意时间字符串的格式和*是否符合正常日期范围*）

   ![image-20220721102945172](/Users/apple/Documents/Notes/assets/image-20220721102945172.png)

7. date_add(time, interval number unit)：为日期增加一个时间间隔

   ```mysql
   # 普通日期增加
   select date_add(now(),interval 1 day),date_add(now(),interval 1 hour),date_add(now(),interval 1 second),date_add(now(),interval 1 microsecond),date_add(now(),interval 1 week),date_add(now(),interval 1 month),date_add(now(),interval 1 quarter),date_add(now(),interval 1 year);
   select date_add(now(),interval '1 1:12:12' day_second);# day_second指单位范围是天到秒
   ```

   ![image-20220721103906257](/Users/apple/Documents/Notes/assets/image-20220721103906257.png)

8. date_sub()同上

9. date_diff()日期相减函数，基本同date_add

#### 三.字符串函数

1. length(s)：字符串格式长度（中英文各占一个宽度）

   ![image-20220721100549332](/Users/apple/Documents/Notes/assets/image-20220721100549332.png)

2. lower(s)/upper(s)：将英文字符全部小（大）写（与ucase和lcase等价）

   ```mysql
   select upper(col1) as u_col1 from test;
   ```

   ![image-20220721095429660](/Users/apple/Documents/Notes/assets/image-20220721095429660.png)

3. concat(s1,s2,s3...)：拼接字符串

   concat函数在连接的时候首先将所有值转换为字符串，如果任何参数为null，concat返回null

   ```mysql
   select concat(z_test,' ',v_test) from test;
   ```

   ![image-20220721095816213](/Users/apple/Documents/Notes/assets/image-20220721095816213.png)

4. substring(s,position,length)/mid(…)：从position开始截取长度为length的字符串

   ```mysql
   select substring(v_test,4,12) from test;
   ```

   ![image-20220721100115851](/Users/apple/Documents/Notes/assets/image-20220721100115851.png)

5. trim(s)：去掉前后空白字符

   ![image-20220721100221667](/Users/apple/Documents/Notes/assets/image-20220721100221667.png)

6. replaceOne(s,pattern,replacement)/replace(s,pattern,replacement)：替换字符串

#### 四.URL函数

1. path(URL)：获取url的path
2. pathFull(URL)：获取URL全路径
3. extractURLParameter(URL,name)：获取url query中对应的参数值
4. decodeURLComponent(URL)：decode url

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

![image-20220403183426311](https://wwt13-images-1305051431.cos.ap-beijing.myqcloud.com/img/image-20220403183426311.png)

可以投影查询的设置列别名（或者还可以再修改表名使得形式更加简洁）来解决

```mysql
select 
s1.id s1id,s2.id s2id,
s1.name s1name,s2.name s2name,
s1.gender s1gender,s2.gender s2gender
from mysqlearn as s1,mysqlearn1 as s2;# 虽然但是，还是相当麻烦.....
```

![image-20220403184022237](https://wwt13-images-1305051431.cos.ap-beijing.myqcloud.com/img/image-20220403184022237.png)

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

![image-20220412145526514](https://wwt13-images-1305051431.cos.ap-beijing.myqcloud.com/img/image-20220412145526514.png)

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

## 数据库的查询优化问题

>   SQL语句对于不同的执行方案对性能的差距巨大
>
>   $Plus:$主要掌握这类问题的计算方法和分析方法

`例题分析`

求：选修了课程c2的学生姓名

```mysql
select student.Sname
from student,cs
where student.sno=sc.sno 
and sc.cno='c2';
```

问：此查询的IO和CPU处理代价是多少？

假设：

-   外存：student1000条，sc10000条，选修2号课程的学生50条
-   内存：一个内存块可以装10个student或者100个sc，内存中一次可以存取5块student元组，1块sc元组和若干块连接元组

-   读写速度：20块/秒

$$
Q1=\Pi_{Sname}(\sigma_{student.Sno=sc.Sno\and sc.Cno='c2'}(student\times sc))
$$

1.   $student \times sc$

     读取总块数

     = 读student块表数+读sc表的次数\*每遍块数

     = $1000/10+(1000/10/5)\times(10000/100)$

     = $2100$

     是否可以有第二种方法

     读取总块数

     = 读sc表的块数+读student的次数*每遍块数

     = $10000/100+(1000/10)*(10000/100/1)$

     = $100+100*100$

     = $10100$

     读写时间=$2100/20$=105s

2.   中间结果处理

     中间表大小=$1000*10000=10^7$(一千万条元组)

     写中间结果的时间=$10^7/10/20=50000s$

3.   $\sigma$

     同样需要遍历整个中间表

     耗费时间=$50000s$

4.   $\Pi$

5.   总时间？

## SQL控制语句

>   1.   授予或访问数据库的某种特权
>   2.   控制数据库操纵事务发生的事件以及效果
>   3.   对数据库实行监控等等
>
>   其余在后续课程学习中完善

## SQL存储过程

>   基本定义：**存储过程**（Stored Procedure）是在大型数据库系统中，*一组为了完成特定功能的SQL 语句集*，存储在数据库中，<u>经过第一次编译后调用不需要再次编译（因此执行速度优越）</u>，用户通过指定存储过程的名字并给出参数（如果该存储过程带有参数）来执行它。存储过程是数据库中的一个重要对象

---

==一些和存储过程无关但是比较重要的tip==

### delimiter命令

>   默认情况下，所有sql语句都是以分号“;”结尾
>
>   这样的话对于存储过程就会产生一个问题（整体执行和语句执行的问题）
>
>   <u>见下方语句</u>

```mysql
# 当然下面的语句改成小写也无所谓
CREATE PROCEDURE `proc_if`(IN type int)
BEGIN
    DECLARE c varchar(500);
    IF type = 0 THEN
        set c = 'param is 0';
    ELSEIF type = 1 THEN
        set c = 'param is 1';
    ELSE
        set c = 'param is others, not 0 or 1';
    END IF;
    select c;
END;
```

对于上面的存储过程，它们应该是一个整体，应该一起执行，而不是遇到`;`就执行。

默认情况下，不可能等到用户把这些语句全部输入完之后，再执行整段语句。

此时就需要使用==`delimiter`==语句，定义**定界符**（默认定界符是`;`）

<font color="red">$Attention:$</font>delimiter的作用域是会话级别的，如果设置`delimiter $`那么当前的会话都会变成以`$`结束

所以此时可以将上面的存储过程改写如下

```mysql
delimiter $
CREATE PROCEDURE `proc_if`(IN type int)
BEGIN
    DECLARE c varchar(500);
    IF type = 0 THEN
        set c = 'param is 0';
    ELSEIF type = 1 THEN
        set c = 'param is 1';
    ELSE
        set c = 'param is others, not 0 or 1';
    END IF;
    select c;
END;$
# 恢复默认定界符
delimiter ;
```

### 自定义变量

>   用户自定义变量是一个==用来存储内容的临时容器==，在连接MySQL的整个过程中都存在，可以使用下面的`set`和`select`来定义它们
>
>   基本格式：`set @var:=something`

```mysql
# 定义
set @tmp:=1;
set @min_actor:=select * from table_name;
set @last_week:=current_date-interval 1 week;
# 使用
select ... where col<=@last_week;
```

---

### 存储过程的特点

1.   能够完成比较复杂的判断和运算
2.   **可编程性强**、比较灵活（类比函数和方法）
3.   SQL编程的代码可以==重复使用==
4.   执行速度快（不需要再次编译）、
5.   减少网络之间的数据传输，节省开销（这个应该指的是云端数据库）
6.   和触发器类似，都是一组SQL语句集合，但是存储过程时==主动调用==，而触发器则是==被动调用==（需要出发条件），并且能够实现的功能比触发器更加强大。

<font color="red">$Attention:$</font>由于存储过程是预编译的，所以**无法在数据库脚本中进行定义**（自相矛盾，因为数据库脚本每次运行都要编译）

### 创建存储过程

**简单实例**

```mysql
create procedure pro_name()
begin
	......
	......
end;
# 非常类似与创建函数
-----------------------------
# 简单存储过程创建
create procedure show_tables()
begin
	select * from users;
	select * from orders;
end;
# 调用存储过程
call show_tables();
```

### 存储过程的变量

>   通过一个简单的例子来学习一下存储过程中变量的**声明**和**赋值**

```mysql
# 此处省略delimiter定义
create procedure test()
begin
	# 使用declare语句来声明一个变量
	declare username varchar(20) default "wwt";
	# 使用set语句来给变量赋值
	set username="hello,world";
	# 使用select into语句将users表中id=1的名称赋值给username
	# select into语句用于变量赋值
	# 元组的赋值需要使用游标
	select name into username from users where id=1;
	# 返回变量，类似return
	select username;
end;
```

1.   变量的声明使用`declare`,一句declare只声明一个变量，变量必须先声明后使用

     <font color="red">注意</font>：`declare`无法声明`not null`，并且未初始化的变量值均为`null`，并且`declare`声明必须在存储过程的最初完成`if`等块中无法使用`declare`语句

2.   变量具有**数据类型**和**长度**，与<u>mysql的SQL数据类型保持一致</u>，因此甚至还能制定默认值、字符集和排序规则等

3.   变量可以通过`set`来赋值，也可以通过`select into`的方式赋值

4.   返回变量需要使用`select`语句，如：select 变量名

#### 作用域

>   存储过程中的作用域仅限与`begin...end`块之间
>
>   如果需要在多个块之间传值的话，需要使用全局变量（这个非常简单）

比较简单，通过一个实例来进行说明即可

```mysql
create procedure test3()
begin
  # 全局变量
  declare userscount int default 0; -- 用户表中的数量
  declare ordercount int default 0; -- 订单表中的数量
  begin
    select count(*) into userscount from users;
    select count(*) into ordercount from orders;
    select userscount,ordercount; -- 返回用户表中的数量、订单表中的数量
  end;
  begin
  	# 局部变量
    declare maxmoney int default 0; -- 最大金额
    declare minmoney int default 0; -- 最小金额
    select max(money) into maxmoney from orders;
    select min(money) into minmoney from orders;
    select usercount,ordercount,maxmoney,minmoney; -- 返回最金额、最小金额
   end;
end;
```

### 存储过程参数模式

>   三种模式：in、out、inout
>
>   -   in（默认）：该参数可以作为**输入**，也就是该参数需要调用方传入值
>   -   out：该参数可以作为**输出**，也就是该参数可以作为返回值（需要*改变传入值*的时候使用）
>   -   inout：该参数既可以作为输入又可以作为输出，也就是该参数既需要传入值，又可以返回值

<u>**使用实例**</u>

```mysql
# in实例
create procedure test(in user_id int)
begin
	# set user_id=100; 该语句不会对传入值进行改变
	select user_id;
end;
set @tmp:=1000;
call test(@tmp);
# out实例
create procedure test1(out user_id int)
begin
	set user_id=1000000; # 修改值
end;
call test1(@tmp); # 传入值必须是定义的变量
# inout就是同时集成了上面两者的功能
```

### 存储过程条件语句

>   条件判断语句`if() then...else...end if`
>
>   多条件判断`if() then... elseif() then... ... else ... end if;`

<u>实例演示</u>

```mysql
create procedure test(in user_id int)
begin
	declare username varchar(32) default '';
	if(user_id%2=0)
	then
		select name into username from users where id=user_id;
		select username;
	else
		select user_id;
	end if;
end;
```

### 存储过程循环语句

>   while语句基本结构`while(表达式) do ... end while;`
>
>   Plus：mysql中其实还有一些集中循环语句，~~但是这里掌握`while`即可~~（不够还得了解其他两种用法）

#### while

<u>while实例演示</u>

```mysql
create procedure test()
begin
	declare i int default 0;
	while(i<0) do
		select i;
		set i=i+1;
		insert into test1(id) values (i);
	end while;
end;	
```

#### repeat

>   基本循环格式`repeat ... until(表达式) end repeat`
>
>   和while的主要区别就是它在语句执行之后检查是否满足循环条件（这点可以用于==游标==的循环）

*实例演示*

```mysql
create procedure proc()
begin
	declare i int default 0;
	repeat
		insert into t(field) values(i);
		set i=i+1;
		until(i>=5)
	end repeat;
end;
```

#### loop、leave、iterate语句

>   loop语句使得某些语句重复执行，但是注意**loop语句本身没有停止循环的语句，必须是遇到leave语句等等才能停止循环**
>
>   leave语句就是用于跳出循环的（需要搭配label标签使用）
>
>   iteate也是用于跳出本次循环的，它的作用可以类比continue（同样需要搭配label使用）
>
>   但是在正式开始学习这些之前，还需要了解一样东西——`label循环标签`

#### label循环标签

>   $什么是label？$
>
>   label并不是一种特定的语句，它约定了一种<u>*标志*</u>，而`leave、iterate`语句就需要用到这种标志
>
>   比方说下面的几个例子

```mysql
add_num:loop
set @count=@count+1;# 该循环会死循环
end loop add_num;
```

在这里，add_num就是对于loop循环的标志，类似于给该loop循环的变量名（注意：二者都是==可选的！==）

下面这个例子可以看到定义label的真正作用

```mysql
add_num: loop
	set @count=@count+1;
	if(@count>100) then
		leave add_num;# 定义label的真正作用，用于给leave等语句提供标记
end loop; # 此处的add_num就可有可无
```

实例：输出start-end之间的所有偶数

```mysql
create procedure tmp(in start int,in end int)
begin
	declare i int default(0);
	set i=start-1;
	loop_label:loop # 注意loop后面不能加';'
		set i=i+1;
		if(i>end) then
			leave loop_label;
		elseif(i%2=0) then
			iterate loop_label;
		else
			select i;
	end loop;
end;
```

### 存储过程之临时表（未完成）



### ==存储过程之游标的使用==

>   $What\ is\ cursor(游标)?$
>
>   游标类似于==指针==，是一种能从包含多条数据记录的结果集中每次提取**一条记录**的机制
>
>   游标可以遍历所有行，但是他*<u>一次只能指向一行</u>*
>
>   **游标的作用就是用于对查询数据库所返回的记录进行遍历，以便进行相应的操作**

<u>游标基本用法</u>

1.   声明游标`declare cursor_name cursor for table_name;`（这里的table可以是你查询出来的任意集合）
2.   打开定义的游标`open cursor_name`
3.   使用游标获取一行数据`fetch cursor_name into col1,col2,....`
4.   依据获取的数据执行数据更新、删改操作
5.   释放游标`close cursor_name;`

<u>示例演示1</u>

```mysql
create procedure test()
begin
	declare stopflag int default 0;
	declare username varchar(20);
	declare username_cur cursor for select name from users where id%2=0;
	# 如果游标未找到结果的话(全部遍历一遍)，将stopflag置为1(常用于遍历过程)
	declare continue handler for not found set stopflag=1;
	# 打开游标
	open username_cur;
	while(stopflag=0) do
		update users set name=concat(username,'_cur') where name=username;
		fetch username_cur into username;
	end while;
	# 关闭游标
	close username_cur;
end;
```

<u>实例演示2</u>

```mysql
create function check_user_cursor( 
    name_t varchar(20),
    password_t varchar( 30 ),
    password_new varchar( 30 ),
    process int unsigned) RETURNS smallint
begin
	declare stopflag int default 0;# 设置循环标志
	declare fe_uname varchar(20);
	declare fe_password varchar(30);
	declare tmp cursor for select uname,password from account;# 声明游标管理的数据
	declare continue handler for not found set stopflag=1; # 用于判断游标循环结束
	open tmp; # 打开游标
	loop_label: loop
		fetch tmp into fe_uname,fe_password;
		if(stopflag=1) then
			leave loop_label;
		end if;
		case process 
			when 1 then
				if(name_t=fe_uname and password_t=fe_password) then
					return true; # 此时查询到对应的用户记录
				end if; # 一定要记得退出块
			when 2 then
				if(name_t=fe_uname and password_t=fe_password) then
					update account as a set a.password=password_new
					where a.password=fe_password and a.uname=fe_uname; # 更新为new_password
					return true;
				end if;
		end case;
	end loop;
	close tmp;
	return false;
end
```

==**关于游标使用的注意事项**==

1.   `FETCH INTO`的变量名绝对不能是你定义==CURSOR时SQL语句查出来的列名或者列别名==，也就说你定义的变量名既不能是表中已经存在的列名，也不能是你定义游标时用过的别名，==只要一个条件不符合，FETCH INTO就把全部的变量赋NULL值==（所以定义游标变量的时候加个前缀是好习惯）

### 存储过程流程控制

>   使用case分支语句，和if...then类似

*基本语法结构*

```mysql
case ...
when ... then ...
when ... then ...
else ... # if语句同款else
end case;
```

**实例演示**

```mysql
create procedure testcase(userid int)
begin
	declare my_status int default 0;
	select status into my_status from users where id=userid;
	
	case my_status
		when 1 then update users set score=10 where id=userid;
		when 2 then update users set score=20 where id=userid;
		when 3 then update users set score=30 where id=userid;
		else update users set score=0 where id=userid;
	end case;
end;
```



### 存储过程整体操作语句

1.   删除某个存储过程`drop procedure if exists procedure_name`

2.   查看存储过程创建代码`show create procedure procedure_name`

3.   查看存储过程`show procedure status like 'proc_name'\G;`

     -   mysql：可以查看但是出现乱码
     -   mycli：无法查看（直接卡死）
     -   tableplus：可以查看，查看所有`show procedure status`

     ![image-20220422134607212](https://wwt13-images-1305051431.cos.ap-beijing.myqcloud.com/img/image-20220422134607212.png)

4.   查看所有存储过程的名字`select name from mysql.proc where db='xx' and type='procedure'`

     查看所有函数也是同理`select name from mysql.proc where db='xx' and type='function'`

Plus：存储过程可修改，但是我个人认为那样还不如直接删了重建

## 数据库完整性约束

## SQL时间类型使用

>   MySQL中支持的几种时间类型（常用的是`date、time、datetime、timestamp`）
>
>   ![MySQL的数据类型及其常用修饰符详解_Mysql的数据类型_03](https://s4.51cto.com//wyfs02/M00/8A/B0/wKiom1g3mrPRp64CAABsxlmpJZs268.png)

## MySQL函数介绍

### 字符串类

1.   `concat(str1,str2,str3...)`需要一个或者多个字符串参数，并将它们拼接成一个字符串

     ```mysql
     select concat('MySQL','CONCAT');
     # 空一行防止遮挡
     ```

2.   `concat_ws(sep,str1,str2....)`和上面类似，但是第一个参数是字符串连接的分隔符

---

*触发器创建示例*

```mysql
create trigger fruittrig # 创建触发器
after insert on sells # trigger time,before/after指定了触发器执行的时间(在时间发生之前/后
# 三类触发器:insert,update,delete
# 如果需要执行多条触发语句:可以使用begin...end
# mysql中定义了new和old,来知道触发器发生的表中,触发了触发器的哪一行数据,来引用触发器中发生变化的记录内容
referencing new as newtuple
for each row
#when(
# 	newtuple.fname not in
#   (select fname from fruits)
#)
insert into fruits(fname)
values
(newtuple.fname);
```

---

## MySQL事务管理

### 数据库的并发性

>   数据库的最大特点之一就是==数据库中的数据资源是共享的==

​	每个用户在存取数据库中的数据时，可能是*串行执行*，即每个时刻只有一个用户程序运行，也可能是多个用户并行地存取数据库。

​	串行执行意味着一个用户在运行程序时，*其他用户程序必须等到这个用户程序结束才能对数据库进行存取*，这样如果一个用户程序涉及大量数据的输入/输出交换，则数据库系统的大部分时间将处于闲置（只对一个用户提供服务）状态。

​	因此，为了充分利用数据库资源，数据库用户都是对数据库系统**并行存取**数据。

#### 关于数据库的一致性

>   数据的一致性：==在任何时刻用户面对的数据库都是符合现实世界的语义逻辑的==
>
>   当多个用户对数据库进行并发存取时（同一个数据块），如果不对并发操作进行控制，就会产生不正确的数据，破坏数据的一致性
>
>   而数据库的并发控制是以**事务**为基本单位进行的，可以通过对事务所操作的数据*施加封锁*来实现一致性

#### 事务的基本概念

>   $What\ is\ affairs?$
>
>   *数据库事务*：是数据库管理系统执行过程中的一个<u>逻辑单位</u>，由有限的数据库操作序列构成
>
>   当事务被提交给了DBMS（数据库管理系统），则DBMS需要确保*该事务中的所有操作都成功完成且其结果被永久保存在数据库中*，如果**事务中有的操作没有成功完成，则事务中的所有操作都需要被回滚，回到事务执行前的状态**;同时，该事务对数据库或者其他事务的执行无影响，所有的事务都好像在独立的运行

>   $Why\ we\ need\ affairs?$
>
>   -   为数据库操作序列提供了一个**从失败中恢复到正常状态的方法**，同时提供了数据库即使在异常状态下仍能保持一致性的方法
>   -   当多个应用程序在并发访问数据库时，可以在这些应用程序之间提供一个隔离方法，以防止彼此的操作互相干扰

>   事务的开始与结束可以由用户显式控制，如果用户没有显式的定义事务，则由DBMS按照缺省规定自动划分事务（通常一条DML*Date manipulation language*语句为一个事务）
>
>   用户自定义的事务以`Begin transaction`开始，以`Commit`或者`Rollback`结束
>
>   -   `Commit`表示事务的提交，即将事务中所有对数据库的更新写回到磁盘上的物理数据库中去，此时事务正常结束
>   -   `Rollback`表示事务的回滚，即在事务运行的过程中发生了某种故障，事务不能继续执行，系统将事务中已完成的操作全部撤销，回滚到事务执行前的状态
>
>   一个基础事务实例(银行账户转账)
>
>   ```mysql
>   start transaction
>   select balance from checking where customer_id=123;
>   update checking set balance=balance-200 where customer_id=123;
>   update checking set balance=balance+200 where customer_id=123;
>   commit;
>   ```

##### 事务的特性——ACID

1.   原子性（$Atomicity$）：事务作为一个整体被执行，包含在其中的对数据库的操作要么全部被执行，要么都不执行（==通过事务日志实现==）
2.   一致性（$Consistency$）：事务应确保数据库的状态从一个一致状态转变为另一个一致状态。一致状态的含义是数据库中的数据应满足完整性约束（==通过事务日志实现==）
3.   隔离性（$Isolation$）：多个事务并发执行的时候，一个事务的执行不影响其他事务的执行（==通过锁、MVCC实现==）
4.   持久性（$Durability$）：以及被提交的事务对数据库的修改应该永久保存在数据库中（==通过事务日志实现==）

### 并发事务带来的问题

#### 更新丢失（Lost Update）

>   当两个或多个事务选择同一行，然后基于最初选定的值更新该行时，由于每个事务都不知道其他事务的存在，就会发生丢失更新问题——**最后的更新覆盖了由其他事务所做的更新**

#### 脏读（Dirty Reads）

>   一个事务正在对一条记录做修改，在这个事务完成并提交前， 这条记录的数据就处于*不一致状态*； <u>这时， 另一个事务也来读取同一条记录</u>，如果不加控制，第二个事务读取了这些“脏”数据，并据此做进一步的处理，就会产生未提交的数据依赖关系

#### 不可重复读（Non-Repeatable Reads）

>   一个事务在读取某些数据后的某个时间，再次读取以前读过的数据，却*发现其读出的数据已经发生了改变、或某些记录已经被删除了*，这种现象就叫做“不可重复读”
>
>   至于“幻读（Phantom Reads）”，这里不做细分
>
>   稍微提一下：
>
>   -   不可重复读的重点是修改：在同一事务中，同样的条件，第一次读的数据和第二次读的数据不一样。（因为中间有其他事务提交了修改）
>   -   幻读的重点在于新增或者删除：在同一事务中，同样的条件,，第一次和第二次读出来的记录数不一样。（因为中间有其他事务提交了插入/删除）

#### 各问题的解决办法

1.   更新丢失：通常应该==完全避免==，防止更新丢失，*并不能单靠数据库事务控制器来解决*，需要**应用程序对要更新的数据加必要的锁来解决**，因此，防止更新丢失应该是应用的责任
2.   脏读、不可重复读、幻读：都是数据库读一致性的问题，必须由数据库提供一定的事务隔离机制来解决：
     -   ==加锁==：在读取数据的时候，对数据加锁，防止其他事务对数据进行修改
     -   ==数据的多版本并发控制==（MultiVersion Concurrency Control，简称MVCC）：多版本数据库，不需要添加任何锁，通过一定的机制生成一个数据请求时间点的一致性数据快照（Snapshot），并通过这个快照来提供一定级别（语句级或事务级）的一致性读取。此时从用户的角度看，就像数据库可以提供同一数据的多个版本

### 事务的隔离级别

>   SQL标准定义了4类隔离级别，每一种级别都规定了对于一个事务中所作的修改，哪些在事务内和事务间是可见的，哪些是不可见的。
>
>   *低级别的隔离级一般支持更高的并发处理，并拥有更低的系统开销*

##### 第一级别：Read Uncommitted（读取未提交内容）

>   ==可以直接看到其他未提交事务的执行结果==
>
>   该隔离级别很少用于实际应用，因为它的性能不比其他级别好多少
>
>   该级别引发的问题：**脏读**

#### 第二级别：Read Committed（读取提交内容）

>   *大多数数据库的默认隔离级别（==注意不是MySQL中默认的==）*
>
>   满足隔离的基本定义：一个事务只能看见已经提交的事务所作的改变
>
>   该级别引发的问题：**不可重复读**
>
>   1.   交叉的事务有新的commit导致的数据改变
>   2.   *一个数据库被多个实例操作时，同一事物的其他实例在该实例处理期间可能会有新的commit*

#### 第三级别：Repeatable Read（可重读）

>   *MySQL的默认事务隔离等级*
>
>   可以确保同一个事务的多个实例在并发读取数据的时候，会看到同样的数据行
>
>   此级别可能出现的问题——幻读(Phantom Read)：当用户读取某一范围的数据行时，另一个事务又在该范围内插入了新行，当用户再读取该范围的数据行时，会发现有新的“幻影” 行（**不太理解为啥会出现“幻读” 的问题**）
>
>   InnoDB和Falcon存储引擎通过多版本并发控制(MVCC，Multiversion Concurrency Control)机制解决幻读问题；InnoDB还通过间隙锁解决幻读问题

#### 第四级别（暂时不写了，先看PPT上的内容）

---

### 事务的并发控制机制

>   主要目的：对事物的并行运行顺序进行合理安排，达成事物的*隔离性*和*一致性*

#### 调度（Schedule）

>   在保留统一事务原有的执行顺序的同时，对各事务中各个指令的执行序列做出安排

#### 锁（）

#### 协议（）



# MySQL语句规范

> 自己总结的MySql书写时的语句规范
