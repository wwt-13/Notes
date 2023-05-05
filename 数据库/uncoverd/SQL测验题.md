# SQL测验题

> **四大数据表**
>
> Student(<u>Sno</u>,Sname,Sage,Ssex,Sclass)
>
> Course(<u>Cno</u>,Cname,Cpre,Credit)
>
> CS(<u>Sno</u>,<u>Cno</u>,Tno,Grade)
>
> Teacher(<u>Tno</u>,Tname)

## 测验题1

1. 检索年龄大于20岁的男生的学号和姓名。

   ```mysql
   select Sno,Sname
   from Student
   where Sage>20 and
   Ssex='M';
   ```

2. 检索选修了姓刘的老师所教授的课程的女学生的姓名。

   ```mysql
   select Sname
   from Student natural join CS natural join Teacher
   where Ssex='F' and Tname like '刘%';
   ```

3. 检索李想同学不学的课程的课程号和课程名。

   ```mysql
   select Cno,Cname
   from Course
   where Cno not in (
   	select Cno
       from CS
       where Sno in(
       	select Sno
           from Student
           where Sname='李想'
       )
   );
   ```

4. 检索至少选修了两门课程的学生的学号。

   ```mysql
   select Cno
   from CS cs1 inner join CS cs2
   on cs1.Sno=cs2.Sno
   where cs1.Cno!=cs2.Cno;
   ```

5. 求刘老师所教授课程的每门课的平均成绩。

   ```mysql
   select Cno,avg(Grade)
   from CS natural join Teacher
   where Tname = '刘老师'
   group by Cno;
   ```

6. 假设不存在重修的情况，请统计每门课的选修人数(选课人数超过两人的课程才统计)。要求显示课程号和人数，查询结果按人数降序排列，若人数相同，按课程号升序排列。

   ```mysql
   select Cno,count(*)
   from CS
   group by Cno
   having count(*)>2
   order by desc count(*),asc Cno;
   ```

7. 求年龄大于所有女生年龄的男生的姓名和年龄。

   ```mysql
   select Sname,Sage
   from Student
   where Sage > all(
   	select Sage
       from Student
       where Ssex='F'
   ) and Ssex='M';
   ```

8. 假定不存在重修的情况，求选修了所有课程的学生的学号姓名。(可以不用相关子查询做)

   >  选修了所有课程等价于选出学生，不存在他没选修的课程

   ```mysql
   select Sno,Sname
   from Student
   where not exists(
   	select *
       from Cource
       where not exists(
       	select *
           from CS
           where CS.Cno=Course.Cno and CS.Sno=Student.Sno
       )
   );
   ```

9. 查询重修次数在2次以上的学生学号，课程号，重修次数

   ```mysql
   select *
   from (
   	select Sno,count(Grade is null)
   	from CS
   	group by Sno
   	having count(Grade is null)>2
   )as S1 natural join(
   	select Sno,Cno
   	from CS
   	where Grade is null
   )as S2;
   ```

10. 查询重修学生人数最多的课程号，课程名，教师姓名

    ```mysql
    select Cno,Cname,Teacher
    from CS natural join Teacher
    group by Cno
    having Grade is null and count(*)=(
    	select max(count(*))
        from CS
        group by Cno
        having Grade is null
    );
    ```

## 测验题2

1. 查找李力的所有不及格的课程名称和成绩，按成绩降序排列

   ```mysql
   select Cname,Grade
   from Student natural join CS natural join Course
   where Grade<60 and Sname='李立'
   order by desc Grade;
   ```

2. 列出每门课的学分，选修的学生人数，及学生成绩的平均分

   ```mysql
   select *
   from (
   	select Cno,Credit
       from Course # 可以保证不重复
   ) natural join (
       select Cno,count(*)
       from CS
       group by Cno
   ) natural join (
   	select Cno,avg(Grade)
       from CS
       group by Cno
   );
   ```

3. 选出所修课程总学分在10分以下的学生（注：不及格的课程没有学分）。

   ```mysql
   select Sno,sum(Credit)
   from (
   	select *
       from CS
       where Grade>=60
   )
   group by Sno
   having sum(Credit<10);
   ```

4. 选出选课门数最多的学生学号及选课数量

   ```mysql
   select Sno,count(*)
   from CS
   group by Sno
   having count(*)=(
   	select max(count(*))
       from CS
       group by Sno
   );
   ```

5. 列出每门课的最高分及获得该分数的学生

   ```mysql
   select Sno,Grade
   from(
   	select Cno,max(Grade) Grade 
   	from CS
   	group by Cno
   ) as tmp natural join CS
   ```

6. 选出物理课得分比所有男学生的物理课平均分高的学生姓名

   ```mysql
   select Sname
   from Student natural join CS natural join Course
   where Cname='物理' and Grade>(
   	select avg(Grade)
   	from CS natural join Course
   	group by Cname
   	having Cname='物理课'
   );
   ```

7. 选出修习过物理课的直接先修课的学生

   ```mysql
   select Sno
   from CS
   where Cno in(
   	select Cpre
   	from Course
   	where Cname='物理'
   );
   ```

8. 选出有两门以上先修课的课程（包括直接先修课、间接先修课）(用课程表)

   ```mysql
   select c1.Cname
   from Course c1 inner join Course c2
   on c1.Cpre!=c2.Cno
   ```



