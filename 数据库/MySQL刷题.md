# MySQL刷题

## 填坑

<a href="#覆盖索引">覆盖索引</a>

## 非技术快速入门

### SQL4——查询结果限制返回行数

>   需要使用`limit`子句用于强制限制`select`语句返回的记录数
>
>   LIMIT 接受一个或两个数字参数，参数必须是一个整数常量。
>
>   如果只给定一个参数，*它表示返回最大的记录行数目*
>
>   如果给定两个参数，**第一个参数指定第一个返回记录行的偏移量**，**第二个参数指定返回记录行的最大数目**

例子1：检索记录行前10行

```mysql
select * from tb_name limit 10;
# 但是下面这种效率更高
# 0相当于执行了查找的坐标,所以mysql只需要从此处开始取出10条记录即可
# 而原来的情况则是mysql首先将数据按照10个10个区分出来,再取出第一个数据
select * from tb_name limit 0,10;
```

例子2：检索记录行6-10

```mysql
select * from tb_name limit 5,5;
```

例子3：检索表记录行11-last

```mysql
select * from tb_name limit 11,-1;
```

`offset`子句的作用完全可以包含在`limit`子句中，所以这里不再赘述

### SQL6——查找学校是北大的学生信息

>   <span name="覆盖索引">覆盖索引的使用，之后再来填坑</span>

### SQL15——查看学校名称中含北京的用户

>   ==主要是对模糊匹配的一些补充==
>
>   *四种通配符*
>
>   1.   `_`匹配任意一个字符
>   2.   `%`匹配任意多个字符
>   3.   `[]`匹配[]中的任意一个字符，如果匹配的字符是连续的，可以使用`-`连接（类比regex）
>   4.   `[^]`反向匹配其中的任意一个字符
>
>   $Tips:$模糊匹配会引起全表扫描，速度很慢，是*数据库优化技术中‘SQL语句优化’的方向*

### SQL16——查找GPA最高值

>   常见聚合函数复习
>
>   1.   `count([distinct] col_name) or count(*)`统计元组、列值个数
>   2.   `sum(col_name)`计算列值总和
>   3.   `avg(col_name)`计算列值平均值
>   4.   `max/min(col_name)`计算最大/最小值
>
>   上述函数中除`count(*)`外，其他函数在计算过程中均忽略NULL值

### SQL17——计算男生人数以及平均GPA

>   保留n位小数，使用round函数
>
>   使用实例
>
>   ```mysql
>   round(num,n);
>   ```

### SQL18——分组计算练习题

>   *补充之前学习分组拉下的小漏洞*
>
>   mysql支持多重分组
>
>   ```mysql
>   select gender,university,count(*) as user_num,avg(active_days_within_30),avg(question_cnt)
>   from user_profile
>   group by gender,university;
>   ```

### SQL19——分组过滤练习题

>   同样是补充一下之前的小漏洞
>
>   `having`中可以直接引用`select`中定义的重命名
>
>   ```mysql
>   select university,avg(question_cnt) as avg_question_cnt,avg(answer_cnt) as avg_answer_cnt
>   from user_profile
>   group by university
>   having avg_question_cnt<5 or avg_answer_cnt<20;
>   ```

## SQL必知必会

## SQL进阶挑战

## SQL大厂面试真题

