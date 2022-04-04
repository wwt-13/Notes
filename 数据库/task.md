# task

## Q1

> department表和staff表的创建

department:

```mysql
create table department(Dno int unsigned auto_increment,Dname varchar(20) not null,Dfloor int unsigned,primary key(Dno));
```

staff:

```mysql
create table staff(Sno int unsigned auto_increment,Sname varchar(20) not null,Sdno int unsigned not null,Salary int unsigned,check(Salary>=2000),Sabsense int unsigned default 0,Sborn date,Smarry boolean default 0,primary key(Sno),foreign key (Sdno) references department(Dno));
```

## Q2

![image-20220330180435794](https://gitee.com/ababa-317/image/raw/master/images/image-20220330180435794.png)

![image-20220330181131007](https://gitee.com/ababa-317/image/raw/master/images/image-20220330181131007.png)

![image-20220330181224784](https://gitee.com/ababa-317/image/raw/master/images/image-20220330181224784.png)

![image-20220330181423598](https://gitee.com/ababa-317/image/raw/master/images/image-20220330181423598.png)

## Q3

```mysql
select Salary,Sabsense from staff;
```

![image-20220330181716450](https://gitee.com/ababa-317/image/raw/master/images/image-20220330181716450.png)

## Q4

```mysql
select count(*) from staff;
```

![image-20220330181921401](https://gitee.com/ababa-317/image/raw/master/images/image-20220330181921401.png)

## Q5

```mysql
select avg(Salary) from staff
```

![image-20220330182053983](https://gitee.com/ababa-317/image/raw/master/images/image-20220330182053983.png)

## Q6

```mysql
select max(Salary),min(Salary) from staff;
```

![image-20220330182149024](https://gitee.com/ababa-317/image/raw/master/images/image-20220330182149024.png)

## Q7

```mysql
select Sname from staff where Sabsense>3;
```

![image-20220330182242550](https://gitee.com/ababa-317/image/raw/master/images/image-20220330182242550.png)

## Q8

```mysql
select Dno,max(sa),Dfloor from(select d.Dno,avg(s.Salary) sa,d.Dfloor from staff s join department d on d.Dno=s.Sdno group by d.Dno)test;
```

![image-20220330191648822](https://gitee.com/ababa-317/image/raw/master/images/image-20220330191648822.png)

## Q9

```mysql
select distinct ucase(Sname) from staff;
```

![image-20220330182424493](https://gitee.com/ababa-317/image/raw/master/images/image-20220330182424493.png)

## Q10

```mysql
select date_format(Sborn,'%Y/%m/%d'),date_format(Sborn,'%Y%m%d') from staff;
```

![image-20220330182719561](https://gitee.com/ababa-317/image/raw/master/images/image-20220330182719561.png)

## Q11

```mysql
select mid(Sname,7,) from staff where Sname='David Test';
```

![image-20220330183530054](https://gitee.com/ababa-317/image/raw/master/images/image-20220330183530054.png)

```mysql
select mid(Sname,7,10) from staff where Sname='David Test';
```

![image-20220330183541299](https://gitee.com/ababa-317/image/raw/master/images/image-20220330183541299.png)

## Q12

```mysql
select datediff(a.Sborn,b.Sborn) from staff as a,staff as b where a.Sname='David' and b.Sname='Test';
```

![image-20220330184215231](https://gitee.com/ababa-317/image/raw/master/images/image-20220330184215231.png)

## Q13

```mysql
select * from staff as a where datediff(a.Sborn,'2000-01-01')>0;
```

![image-20220330184801076](https://gitee.com/ababa-317/image/raw/master/images/image-20220330184801076.png)

