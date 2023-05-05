#Database/MySQL

> Only record what I need to know and what I'am not so familar with.

## 杂

> 这里放的是不知道该如何归类的MySQL内容，包括了一些约定俗称的基础等等

1. 命令默认以;截止[^1]
2. 数据库名+==表名==都不支持大写（==会自动转换为小写，但可能按照大写显示==），但是字段名支持大写
3. 两种注释格式：`#`(常用) ` --  `
4. 在命令末尾加上`\G`,可以打打改善某些指令的显示效果(_原理是将查询结果从默认的按行打印切换为按列打印_)

### 报错处理

> 鉴于MySQL离谱的报错机制（往往一处语法错误会报出另外一个风牛马不相及的报错提示），所以进行常见的报错整理是非常有必要的

### 数据类型

> 关系代数中的属性类型，在MySQL中，就是数据库下表中的字段类型
> ps：MySQL中，定义一个字段类型的基本语法（`col_name date_type constraint`）

1. 数值型
   - 整型 $tinyint,smallint,mediumint,int,bigint$
   - 浮点型 $float,double,dccimal(M,D)$
     _M,D_分别代表浮点数长度（不包括小数点和符号），和小数点后位数
     比较常用的一般只有`int`和`float`
   
   | 类型      | 字节数 |
   | --------- | ------ |
   | tinyint   | 1      |
   | smallint  | 2      |
   | mediunint | 3      |
   | int       | 4      |
   | bigint    | 8      |
   
2. 字符型
   一般常用的只有$char$和$varchar$,二者区别是`char(10)`开辟出的存储空间是固定的10个字符，而`varchar(10)`则在开辟是为空，后续再根据存放内容自动分配空间(char追求时间效率，varchar追求空间效率)
3. 日期时间型
4. 枚举型(用于给字段指定一个特定范围)
   `enum(value1,value2,value3......)`
5. 布尔型
   mysql中没有内置的布尔类型，但是为了方便，MYSQL提供`boolean`作为`tinyint(1)`的同义词，其中0为false,1为true
   > [!hint] 关于TRUE、FALSE和UNKNOWN
   > 在mysql中，Where语句中的条件表达式有三种可能的计算结果：true,false,unknown
   > 三者均可通过数值来代替：true=1,false=0,unknown=0.5

```sql
create table if not exists tb1(
   id int auto_increment,
   name char(10) not null,
   gender enum('male','female'),
   passed boolean default false, 
   primary key(id) # 需要注意的是最后一行不需要,
);
```

## 基本MySQL语法

> 讲解最为基础的SQL语法

### 数据库操作

> 数据库层级的基本操作语法(因为数量不多，所以直接以列表形式展示)

1. `show databases;`查看所有数据库(注意**s**)
2. `create database db_name;`创建数据库
3. `use db_name;`使用数据库（操作环境变更为该数据库下的表）
4. `drop database db_name;`删除数据库

### 表操作

> 表层级的基本操作语法

1. `show tables;`查看当前数据库下的所有表
2. `select * from tb_name;`查看表中的所有内容
3. `drop table tb_name;`删除表

### Constraints

> 约束是一种限制，对表的行和列的数据进行限制，用于确保表中数据的完整性和唯一性，比方说限制人的年龄不能为负数等等
> 约束一般在表创建的时候添加，或者在表创建完成后通过`alter`语句进行修改

基本使用形式：`col_name col_type constraint`(指创建表时)

_**基本书写规范**_👇🏻

```sql
CREATE TABLE 表名(
    字段名 字段类型 列级约束,
    字段名 字段类型,
    表级约束 # 注意列级约束和表级约束的位置
)
```

- `default`：默认约束，指定某列的**默认值**，插入数据时，如果此列未赋值，则使用default指定的值来填充
  ```sql
  name varchar(10) default 'wwt'
  ```
- `not null`: 非空约束，指定某列的值**不能为空**，在插入数据的时候必须指定， ''不等于 null, 0不等于 null
- `unique`：唯一约束，但不等同于`primary key`
  - 指定**列**或**列组合**唯一，保证数据唯一性
  - 不能出现重复值，但是可以出现多个NULL
  - _同一张表可以存在多个唯一约束_
  > [!todo]
  > 对于unique相关的知识将在_**索引**_章节具体介绍，这里只是进行粗略了解
- _`primary key`_: ==主键约束==
  **等价于唯一约束+非空约束**
  **注意，主键等价于关系代数的主码，可能不止一个字段**
  **如果建表时未建主键，mysql会自动选择第一个唯一非空字段作为主键，如果没有则会内建一个不可见字段作为主键**
- `foreign key`：外键约束
  - 通过建立外键，设置表与表之间的约束性，限制数据的录入,被外键约束的列，_**要么为null，要么取值必须参照主表列中的值**_
  - _**外键约束的列类型必须和原表主键类型完全一致**_（比如`unsigned`等等）
  ```sql
  create table dept(
      id int unsigned auto_increment,
      primary key(id)
  );
  create table tb_test(
      id int auto_increment,
      name varchar(10) not null,
      d_no int default 0,
      primary key(id),
      foreign key(d_no) references dept(id)
  );
  # 创建数据表tb_test时会报错"...are incompatible."
  # 数据格式不匹配(d_no同样需要unsigned,但是default貌似没有影响？)
  create table tb_test(
      id int auto_increment,
      name varchar(10) not null,
      d_no int unsigned default 0,
      primary key(id),
      foreign key(d_no) references dept(id)
  );
  # success
  ```
- `auto_increment`：自增长约束
  - 自增长的必须是**键**(必须有key约束)，但不一定是非得是主键
  - ==一个表只能有一个自增长约束==
- `check`：自定义约束
  使用方式为：`check+表达式`，可以对列单独添加约束，也可以列直接添加约束，下面直接看例子⬇️
  ```sql
  create table if not exist test_tb(
      id int unsigned auto_increment,
      tid int,
      sid int not null check(sid>10),
      check(tid>sid and tid<100),
      primary key(id)
  );
  ```
  ^d28ee7

> [!note] 拓展：外键级联操作
>
> 1. `on delete cascade`：删除主表中的数据时，从表中的数据随之删除
> 2. `on update cascase`：更新主表中的数据时，从表中的数据随之更新
> 3. `on delete set null`：删除主表中的数据时，从表中的数据置空
>
> 使用范例：`FOREIGN KEY (sid) REFERENCES stu(sid) ON DELETE CASCADE ON UPDATE CASCADE)`

#### 查看约束

> 两种方法，个人推荐第二种

1. `desc tb_name`同时还能查看表结构（虽然这条命令本来的功能就是查看表结构）
   ![[CleanShot 2023-02-22 at 19.47.55.png]]
2. `show create table tb_name`可以直接查看**当前的**表语法结构_(推荐与`\G`结合使用)_
   ![[CleanShot 2023-03-09 at 15.46.25.png]]

### 表基本操作

> 创建、删除表等在关系层面的操作

1. 创建：`create table [if not exists] tb_name(col_name col_type ...)`
   ```mysql
   create table if not exists tb2(
       id int unsigned auto_increment,
       name varchar(10) default "name",
       primary key(id)
   ); # 注意截止符
   ```
   > [!attention] 说明
   > 有关约束部分的内容将在之后进行详细说明(primary key,unsigned之类的)
2. 删除：`drop table [if exists] tb_name`

#### alter语句

> 通用的表修改语句，可以对表进行列删除、列添加、约束修改、重命名等等操作
> 关键在与学了alter后，就不用学习其他非通用的表修改语句了（防止记忆混乱）

```sql
# 实验表，用于测试alter语句
create table stu(
	id int not null, 
	name char(10) not null, 
	class int not null, 
	age int,
	primary key(id) 
);
```

1. 删除列：`alter table tb_name drop col_name;`
2. 添加列：`alter tale tb_name add col_name constraint`
3. 修改列：`alter table tb_name modify col_name constraint`
4. 表重命名：`alter table tb_name rename tb_name2`
5. 添加约束：`alter table tb_name add constriant field_name constriant_type`
6. 删除约束：`alter table tb_name drop constraint`

### 数据查询

> 从数据库中获取指定的数据，这是数据库管理技术中的**核心操作**

基本查询流程如下👇🏻

```sql
select 字段 # 指定了要显示的属性列
from table_names # 指定查询对象(可能执行表连接操作等等)
where conditions about tuples of the tables # 指定查询条件
group by one or more attributes # 对查询结果按照列的值进行分组（分组依据为集函数作用的值）
having attributes # 筛选出满足条件的组
order by one or more attributes; # 对查询结果按照指定列值进行升序降序排列
```

^f25911

#### SQL查询语句执行顺序

> 和其他编程语言不同，_sql的查询语句并不是顺序执行的_

![[MySQL#^f25911]]

1. `from`语句组装来自不同数据源的数据->==首先获取到查询总表==
2. `where`语句基于执行条件对记录行进行筛选->对获取到的数据进行==初步筛选==
3. `group by`语句将初步筛选后的数据划分为多个分组->==对数据按照依据列进行分组==，如果使用了`group by`，那么==后续步骤得到的数据都只能是分组依据列和聚合函数值==
4. `select`对最终显示的数据列进行选择->选出数据列，如果之前使用了`group by`则`select`字句也**只能包含分组依据列和聚合函数**
5. `having`语句对分组结果进行筛选->==类似`where`，但作用对象是组==，同理，在`having`语句中出现的==只能是作为分组依据的列或者聚集函数==
6. `order by`对结果进行排序->排序

> [!important] 重要
> 该部分内容必须熟记于心

#### 单表查询

> 顾名思义，指的是仅涉及一个表的查询操作，相对简单(其实就是`from`语句中不涉及类似`join`的表连接操作)

表查询实例模型👇🏻

- 学生表`Stu(Sno,Sname,Ssex,Sage,Sdept)`
- 课程表`Co(Cno,Cname,Cpno,Ccredit)`
- 学生选课表`SC(Sno,Cno,Grade)`

```sql
# 表创建脚本
create table Stu(
	Sno int auto_increment,
	Sname char(10) not null,
	Ssex enum('male','female'),
	Sage int default 18,
	Sdept char(10),
	check(Sage>0 and Sage<200),
	primary key(Sno)
);
create table Co(
	Cno int auto_increment,
	Cname char(10) not null,
	Cpno int,
	Ccredit float(2,1),
	primary key(Cno,Cpno)
);
create table SC(
	Sno int,
	Cno int,
	Grade int default 0,
	primary key(Sno,Cno),
	foreign key(Sno) references Stu(Sno),
	foreign key(Cno) references Co(Cno)
);
# 经过验证，上诉三表均可创建成功
insert into Stu(Sname,Ssex,Sage,Sdept)
values
("小王",'male',17,'Math'),
("小绿",'female',18,'Software'),
("小美",'female',17,'Physics'),
("小住",'male',19,'Math'),
("小阿",'male',17,'Sofeware');
```

^4fa73c

![[CleanShot 2023-03-09 at 16.33.40.png]]
数据插入成功👆🏻

##### 查询经过修改的值

> `select`查询语句后的字段可以经过_表达式计算_、_重命名_、_内置函数_后作为结果表中的值
> 该部分内容比较简单，举个例子就行了

```sql
# 查询全体学生的出生年份,姓名和小写专业名
select Sname,2023-Sage as 'Year of Birth',lower(Sdept) from stu
```

> [!note] distinct
> 有时查询得到的表会包含重复的元组，此时可以通过`distinct`来消除重复行
>
> ```sql
> select distinct Sname,Sage from Stu;
> ```
>
> 需要注意的是`distinct`作用于所有列

##### where语句查询条件

> 简单，这里只提及一下`like`部分的内容

![[CleanShot 2023-03-09 at 16.49.00.png]]

- `where attribute like pattern`
  1. `%`代表任意长度的字符串
  2. `_`代表任意单个字符
  3. **如果用户查询结果中本身包含了`%`或`_`，可以通过`escape`指定特定转义字符**

_**Now use some example to explain things above.**_

```sql
# 1
select * from Stu
where Sage>18;
# 2
select * from Stu
where Sage between 15 and 20;
# 3
select * from Stu
where Sdept in ('Math','Software');
# 4:查找不学数学的姓王的同学
select Sname,Sage,Sdept from Stu
where Sname like '王%' and Sdept not like 'Ma__';
# 5:查询以“DB_”开头，且倒数第3个字符为 i 的课程 的详细情况
select * from Stu
where Sdept like 'DB*_%i__'
escape '*'
```

##### 结果排序

> 使用`order by`子句可以对查询结果进行排序，基本使用方式：`order by field asc/desc`
> _**ps：默认排序方式为升序asc**_

```sql
select * from Stu
where Sdept="Math"
order by Sage desc;
```

##### 分组和聚集

> _**通过`group by`语句可以对查询结果进行分组**，**分组后，聚集函数的作用对象将切换为各个分组，==分组的作用就是细化聚集函数的作用对象==**_
> 在`select`语句中可以使用聚集函数，对指定的列进行聚集计算（SUM、AVE、COUNT等等）

常见的聚集函数如下所示👇🏻

- `COUNT([DISTINCT|ALL] COL_NAME|*)`计数函数
- `SUM([DISTINCT|ALL] COL_NAME)`求和函数
- `AVG([DISTINCT|ALL] COL_NAME)`取平均函数
- `MAX([DISTINCT|ALL] COL_NAME)`最大值
- `MIN([DISTINCT|ALL] COL_NAME)`最小值

> [!hint]
> 空值不会加入COUNT、SUM、AVG等函数的计算，`avg(Sage)=sum(Sage)/count(Sage)`

```sql
select Sdept,avg(Sage)
from stu
group by Sdept;
```

##### 分组筛选

> 通过`having`语句对分组结果进行筛选，和`where`语句类似，区别是作用对象

```sql
select Sdept,avg(Sage) 
from stu group by Sdept 
having count(*)>1
```

#### 多表查询

##### 连接方式介绍

> 在`from`语句中，可以进行关系代数中进行各种连接操作（笛卡尔积、内连接、$\theta-连接$、自然连接、外连接[^2]、左-外连接、右-外连接）
> 下面将对各种连接方法进行一一介绍

- 内连接、笛卡尔积、$\theta-连接$：这三者本质上都是一类，都是在笛卡尔积的基础上+on条件+where条件
- 自然连接：只保留相同列名的属性值相同的元组
- 左-外连接、右-外连接：以左为例，对于on条件而言，**无论如何都会保留左表的内容**，但对于where而言，会依据相关条件进行筛选

![[Pasted image 20230309190020.png]]

> [!tip] 关于`on`和`where`的区别
>
> 1. `on`是生成临时表时使用的条件，它不管 on 中的条件是否为真，都会返回左边表中的记录
> 2. `where` 条件是在临时表生成好后，再对临时表进行过滤的条件。这时已经没有 left join 的含义（必须返回左边表的记录）了，_**条件不为真的就全部过滤掉**_
>
> [该部分参考文章地址](https://www.cnblogs.com/jessy/p/3525419.html)

##### 子查询

> 称一个`select-from-where`语句为一个查询块
> _将一个查询块嵌套到另外一个查询块中，这样的查询方式称为子查询（不是所有DBMS都支持子查询）_
> _**ps：通常查询块嵌套在where语句和having语句中，当然其他地方也可以放置**_

```sql
select * from stu s1 # 对stu重命名为s1，只需要之间空一格即可，当然通过as命名也可以
where s1.name in(select name from stu2);
# 也可以将子查询嵌套到from语句中作为临时表👇🏻
select SIS.Sno, Sname, Cno
from SC, (select Sno, Sname from Student where Sdept= 'IS') as SIS
where SC.Sno=SIS.Sno
```

> [!note] order by
> 子查询中，使用`order by`语句是没有意义的，因为只需要用到内容，不需要子查询的顺序

- 相关子查询：子查询的**查询条件**依赖于父查询
  - 首先取外层查询中表的第一个元组，根据它与内层查询相关的属性值处理内层查询，**若WHERE子句返回值为真，则取此元组放入结果表**；
  - 然后再取外层表的下一个元组；
  - 重复这一过程，直至外层表全部检查完为止
- 不相关子查询：由内向外逐层处理，_**子查询的结果用于建立其父查询的查找条件**_

> [!warning]
> 需要注意的是，相关与不相关子查询仅仅只是子查询的两个分类（只是概念上的不同，与子查询使用的谓词无关）
> 并且这块内容不太好进行语言描述，所以之后均采用`代码+注释`的形式进行理解

[[MySQL#^4fa73c]]:别忘了实例表的结构

带有`in`谓词的子查询👇🏻

```sql
select Sno,Sname,Sdept 
from Student
where Sdept in
(
	select Sdept 
	from Student
	where Sname="刘晨"
); # 此为不相关子查询
```

```sql
# 稍微复杂一点的例子(emmmmm...这里的复杂貌似是在你不用自然连接的前提下(不用的话需要三层查询))
# 查询选修了课程名为“信息系统”的学生的学号和姓名
# 1. SC和Co自然连接，得到选修信息系统学生的学号
# 2. 从Stu中选择学号在子查询中的学生的学号和姓名即可
select Sno,Sname
from Stu
where Sno in
(
	select Sno
	from SC natural join Co
	where Cname="信息系统"
);
```

比较运算符的子查询👇🏻($>,<,>=,<=,<>,!=,=$)

1. 内层查询返回的得是==单值==，否则会报错
2. 子查询要跟在比较运算符后面

```sql
select Sno,Sname
from Stu
where Sage > (
	select avg(Sage)
	from Stu
);
```

带有`all,any`谓词的子查询(一般和比较运算符配合使用)

```sql
select Sname,Sage
from Stu
where Sage < any(
	select Sage
	from Stu
	where Sdept="Math"
); 
# 这里 any 等价于 `< select max(Sage) ...`
# 同理，把any换成all的话就等价于`< select min(Sage) ...`
```

> [!tip]
> 相比all和any谓词，更推荐使用集函数替代(因为集函数的查询次数少，查询效率高)

###### exists谓词

> 存在量词$\exists$,此谓词较为特殊，需要单独分区进行阐述

- 带有`exists`谓词的子查询不返回任何数据，只产生逻辑真值`true`(子查询结果非空)或逻辑假值`false`(子查询结果为空)
- 由exists引出的子查询，其==目标列表达式通常用`*`==(因为只要看有无结果元组即可，给出列名毫无意义)
- 一些带`exists/not exists`的子查询不能被其他形式的子查询等价替换，但是所有带`in`、比较运算符、`all`和`any`的子查询都可以被带`exists`的子查询等价替换***(exists子查询的特殊之处)***
- `exists`谓词修饰的子查询，多为==_相关子查询_==
- `not exists`谓词同理

```sql
# 示例脚本
create table A(
	a int,
	b int,
	primary key(a)
);
create table B(
	a int,
	c int,
	primary key(a)
);
insert into A(a,b)
values
(1,2),(2,3);
insert into B(a,c)
values
(1,2),(3,3)
```

关于`exists`查询的执行过程👇🏻

![[CleanShot 2023-03-09 at 20.50.14.png]]

![[CleanShot 2023-03-09 at 20.50.32.png]]

```sql
# 查询所有选修了1号课程的学生名称
select Sname
from Stu
where exists(
	select * from SC
	where SC.Sno=Stu.Sno and SC.Cno=1
); # 相关子查询
```

> [!important] 通过exists/not exists实现全称量词$\forall$
> MySQL不支持$\forall$[^3],通过离散数学等价转化实现$(\forall x)P<=>\neg(\exists x(\neg P))$
> 并且只能通过`exists`谓词来实现全称量词相关的查询操作
> 为了表达全称量化，需要将=="所有的行都满足条件P" 这样的命题转换成 "不存在不满足条件P的行"==

```sql
# 查询选修了全部课程的学生姓名=>x=课程,P(x)代表该学生S选修了这门课程=>不存在这样的课程，学生S没有选修
# 上面的等价转换过程非常关键!!!!
select Sno,Sname
from Stu
where not exists(
	select *
	from Co
	where not exists(
		select *
		from SC
		where SC.Cno=Co.Cno and SC.Sno=Stu.Sno
	)
);
```

> [!important] 通过exists/not exists实现逻辑蕴涵$\rightarrow$
> 同样可以通过谓词演算，将逻辑谓词蕴涵等价转换为$p\rightarrow q<=>\neg p\vee q$

```sql
# 查询至少选修了学生95002选修的全部课程的学生号码
# 查询学号为x的学生，对所有的课程y，只要95002选修了y，则x也选修了y(牛逼plus的思路)
# 所以把p等价于95002选修了课程y，q等价于学生x选修了课程y
select Sno
from Stu
where exists(
	select Cno
	from SC
	where Cno not in(
		select Cno
		from SC where Sno='95002'
	)
	and Cno in (
		select Cno from SC where Sno=Stu.Sno
	)
);
# 该方法不正确🙅🏻‍♀️
```

> [!warning]
> 逻辑谓词相关的子查询，必须转换为$\neg,\exists$的形式

$$
\begin{gather*}
(\forall y)p(y)\rightarrow q(y) \\
(\forall y)(p(y)\rightarrow q(y)) \\
(\forall y)(\neg p(y)\vee q(y)) \\
\neg(\exists y(\neg p(y)\vee q(y)))
\end{gather*}
$$

```sql
# 查询至少选修了学生95002选修的全部课程的学生号码
select Sno
from Stu
where not exists(
	select *
	from SC
	# nt了，这部分恒假了，导致整体恒真，所以最后所有学生都被筛选出来了
	where not exists(
		select *
		from SC as SC1
		where SC1.Sno='95002' and SC1.Cno=SC.Cno
	) and exists(
		select *
		from SC as SC2
		where SC2.Sno=1 and Sc2.Cno=SC.Cno
	) 
);
# 还是错🙅🏻‍♀️
```

最终还是选择参考下PPT上的答案👇🏻

```sql
# 不存在这样的课程y，学生95002选修了y，而学生x没有选
# 第一个SC1提供学生，第二个SC2提供95002的全部课程
# 理解了！！！！
select Sno
from SC SC1
where not exists(
   select *
   from SC SC2
   where SC2.Sno='95002' not exists(
	   select *
	   from SC
	   where SC.Sno=SC1.Sno and SC.Cno=SC2.Cno
   )
)
```

> [!error]
> 难顶，需要相当好的直觉

##### 集合查询

> 就是对于查询的结果集进行并(`UNION`)、交(`INTERSECT`)、差(`EXCEPT`)等运算，单位是集合
> 需要注意的是，==MySQL只支持并查询==，其余操作均可以通过关系运算符很方便的实现

该部分内容较为简单，直接看样例即可

```sql
SELECT * FROM userlist
WHERE nation='CHINA'
UNION
SELECT * FROM userlist
WHERE age<=18;

# intersect
SELECT * FROM userlist
WHERE nation='CHINA' and age<=18;

# except
SELECT * FROM userlist
WHERE nation='CHINA' and age>18;

```

#### 数据更新

> Data Modification Language
> 该部分内容比较简单，只对相关内容进行举例即可
> ps:该部分内容过于简单所以直接把它合并到数据查询子标题下了

共有三种数据更新类型👇🏻

- Insert插入一条或多条元组
- Delete删除一条或多条元组
- Update更新现有一条或多条元组中的值

_插入子查询的值_

```sql
create table tmp(
	id int auto_increment,
	age int default(18),
	name varchar(10),
	primary key(id)
);
insert into tmp(age,name)
select Sage,Sname
from stu
where Sname like "%刘%"
```

_修改数据_

```sql
# 基本语法格式 update tb_name set col_name=xxx
# 修改单个元组的值
update Stu
set Sage=22
where Sno='95001'
# 同时修改多个元组的值(将所有学生的年龄增加一岁)
update Stu
set Sage=Sage+1;
# 至于和子查询等等结合的修改语句不再赘述，和查询结合的原理相同
```

_删除数据_

```sql
# 基本语法格式：delete from tb_name where condition
delete from Stu
where Sno='95001'
# 删除所有元组
delete from Stu;
```

### 视图

> What is View? And what is View used for?
> 视图是一个虚拟表，类似于子查询，它本身并不包含数据，只是作为一个`select`语句保存在数据字典中(用来创建视图的表称为基表base table)
> 视图就是一个保存在数据字典的子查询，用户通过视图可以方便的查询到基表的相关数据，而不需要了解基表的数据结构

> [!note] 为什么要使用视图？
>
> 1. 方便性：使用视图的用户完全不需要关心后面对应的表的结构、关联条件和筛选条件，对用户来说已经是过滤好的复合条件的结果集
> 2. 安全性：使用视图的用户只能访问他们被允许查询的结果集，对表的权限管理并不能限制到某个行某个列，但是通过视图就可以简单的实现
> 3. 数据独立：一旦视图的结构确定了，可以屏蔽表结构变化对用户的影响，源表增加列对视图没有影响；源表修改列名，则可以通过修改视图来解决，不会造成对访问者的影响

#### 视图创建

> 创建视图的基本语法如下👇🏻

```sql
create [or replace] [algorithm={undefined|merge|temptable}]
view v_name [(col_list)]
as select_statement
[with [cascade|local] check option]
```

1. `on replace`：替换已有视图
2. `algorithm`：视图选择算法，默认是undefined(由MySQL自动选择要使用的算法)
3. `select_statement`：select语句`select col_name from ... where ...`
4. `with [cascade|local] check option`：视图在更新的时候要保证在视图的选线范围内
   1. cascade为默认值，代表更新视图时，必须满足视图的一致性[^4]
   2. local表示更新视图时，只需要满足该视图定义的一个条件即可

> [!hint] 关于with check option
> 该选项用于保持视图的一致性，也就是对于通过视图对于基表进行的修改，必须要能通过该视图看到基表修改后的结果

```sql
# 未设置check option
create view Born_2002_1 as
select id,Sname,Sage
from test1
where Sage=2002;
# 可以支持插入不相关数据
insert into Born_2002_1(Sname,Sage)
values
('tmp',2003),
('tmp1',2002);
# 设置check option
create view Born_2002_2 as
select id,Sname,Sage
from test1
where Sage=2002
with check option;
# 无法插入：CHECK OPTION failed 'test.born_2002_2'
insert into Born_2002_2(Sname,Sage)
values
('tmp3',2003),
('tmp4',2002);
```

> [!attention]
> 视图其实就是一个虚拟表，所以完全可以把它当做一个正常的表来查询、查看表结构等等
> `select * from v_name`,`desc v_name`,......
> 当然也可以通过`show tables`来查看当前数据库下的视图(因为本质就是表嘛)
> 如果要指定查询视图的话，需要指定comment，`show table status where comment='view'\G`(推荐加上\G指令，直接查出来的表结构惨不忍睹)

视图可以_自定义列名_(如果不自定义的话自动使用select语句中的列名)

```sql
# 自定义列名(注意列名数量必须和select语句中的相匹配)
create view v_name(col1,col2,col3) as
select ...
```

#### 视图修改

> 有两种修改方法，`alter`和`or replace`，建议直接通过`or replace`来进行修改
> ps:主要是alter懒得记了(而且`or replace`相当于直接重新创建了对应视图，更加方便)

```sql
create or replace view Born_2002 as
select ...
```

#### 视图更新

> 不推荐🙅🏻‍♀️通过视图对基表进行更新，下面是MySQL对于视图数据更新的要求

1. select子句中包含`distinct`
2. select子句中包含**组函数**
3. select语句中包含`group by`子句
4. select语句中包含`order by`子句
5. select语句中包含`union` 、`union all`等集合运算符
6. where子句中包含**相关子查询**
7. from子句中包含**多个表**
8. 如果视图中有**计算列**，则不能更新
9. 如果基表中有**某个具有非空约束的列未出现在视图定义中**，则不能做insert操作

### 索引与查询优化

> 暂时搁置

### 用户自定义约束

> 1. Check约束：通过限制输入到列中的值来限制域的完整性
> 2. 触发器(trigger)：Event-Condition-Action，在数据库发生某项更新的时候，触发执行action

#### Check约束

![[MySQL#^d28ee7]]

#### 触发器

> What is trigger?
> 触发器是<mark style="background: #FFB86CA6;">表</mark>相关的数据库对象，只有在满足触发器定义条件的时候触发，并执行触发器中定义的语句集合

![[Pasted image 20230321143925.png]]

> [!attention]
> Cannot associate a trigger with a temporary table or view

触发器的五大特性👇🏻

1. `trigger`主体语句由`begin`开头，`end`结尾
2. 什么条件触发：`Insert`、`Delete`、`Update`
3. 什么时候触发：在增删改前或后
4. 触发频率：_**针对每行执行一次**_
5. 触发器定义在表上(无法对临时表和视图定义trigger)、

> [!note]
> 从触发器的触发频率也可以看出，应该尽量少使用触发器（特别是对于增删改非常频繁的表），因为这会大大降低数据库运行的效率（<mark style="background: #FFB8EBA6;">trigger针对每一行都要执行一次</mark>）
> 即使要使用，begin-end之间的语句效率也应该尽量高

##### delimiter

> 用于人为指定命令结束符，`delimiter |`就指定了`|`作为mysql命令的结束符

这是因为MySQL默认以`;`为命令结束符，这样的话在命令行创建函数、触发器等等语句中包含分号的MySQL语法的话，MySQL就会直接在子句的结尾结束，这时就需要使用`delimiter`事先指定结束符

```sql
delimiter ||
create trigger tg_name
before delete
on work for each row
begin
	insert into time values(now());
	insert into time values(now());
end||
delimiter ;
```

基本定义语句↓

```sql
create trigger trigger_name
trigger_time trigger_event
on tb_name for each row
[trigger_order]
begin
	trigger_body
end
```

- trigger_time:指定了触发器执行的时间(`before|after`)，在事件之前or之后
- trigger_event:指定触发事件(触发条件)
  - insert：插入某一行时触发触发器，可能通过`insert`、load data、replace语句触发
  - update：更改某一行时激活触发器
  - delete：删除某行时激活触发器
- trigger_order：为MySQL5.7后新添加的内容，暂时不考虑

```sql
create trigger tg1
after insert
on tb1 for each row
begin
	update tb1
	set insert_time=now()
	where id=new.id;
end
```

## Homework

1. [[数据库作业_1]]
2. [[数据库作业_2]]
3. [[数据库作业_3]]
4. [[数据库作业_4]]
5. [[数据库作业_5]]

## Exper

1. [[数据库实验_1]]
2. [[数据库实验_2]]

## 学习资料

[MySQL练习汇总](https://zhuanlan.zhihu.com/p/92590262)
[王陵的个人博客](https://www.cnblogs.com/wkfvawl/p/10889002.html)
[青石路的个人博客](https://www.cnblogs.com/youzhibing/p/11385136.html)
[深入解析MySQL视图VIEW](https://www.cnblogs.com/geaozhang/p/6792369.html#chuangjianshitu)
[MySQL触发器trigger的使用](https://www.cnblogs.com/geaozhang/p/6819648.html)

# footnote

[^1]: 当然也可以通过delimiter来自定义结束符号（一般在数据库脚本中使用）

[^2]: MySQL中不支持外连接，不过可以通过union实现同样效果

[^3]: 从离散数学的角度很好解释，已知$\neg,\exists$,其他所有的逻辑谓词也就能顺势推导出来了(就是有点麻烦)

[^4]: 一般视图建议指定此选项，除非你定义的是可更新的简单视图
