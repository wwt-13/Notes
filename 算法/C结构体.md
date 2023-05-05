# C结构体

>   结构体，就是C语言中用于封装多个基本数据类型的数据类型，C中使用`struct`关键字来声明结构体

## 结构体定义

>   结构体的定义方式有很多，按照自己的定义习惯来定义结构体即可。
>
>   *<font color="green">Ps:</font>结构体的定义位置并没有强制要求，函数内外均可，关键是看你要在什么地方使用* 

1.   只定义结构体，不定义变量

     ```c
     struct Student{
         char name[20];
         int num;
     };
     struct Student student;
     ```

     该方法相当于只定义了结构体的结构，结构体名为`Student`，成员名为`name`和`num`，结构体变量为`student`，结构体的数据类型为`struct Student`而不是`struct`

2.   定义结构体的时候，顺带定义了所需变量

     ```c
     struct Student{
         char name[20];
         int num;
     }stu1,stu2;//可以同时定义多个
     ```

3.   可以匿名定义（只需要使用一次结构体变量的时候可以使用，不是很推荐）

     ```c
     struct{
         char name[20];
         int num;
     }stu;
     ```

4.   typedef定义结构体，方便省力，推荐

     ```c
     typedef struct Student{
         char name[20];
         int num;
     }stu;//此时定义了结构体和结构体别名
     //也可以省略Student(更推荐)
     typedef struct{
         char name[20];
         int num;
     }stu;
     stu stu1;
     stu stu2;
     ```

*对于结构体名和&结构体名的疑惑*

>   似乎直接输出结构体代表的地址值没什么意义，但是又有点意义？
>
>   初步判断目前阶段没意义，应该结构体名指向的内存区域会保存一些和该结构体有关的信息（不太理解，坐等知乎大佬回答）

## 共用体

>   https://www.w3cschool.cn/c/c-unions.html

## 位域

>   https://www.w3cschool.cn/c/c-bit-fields.html

