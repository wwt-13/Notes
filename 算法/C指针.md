[toc]

# C指针

>   作为C/C++等低级编程语言最重要的概念之一，有必要单独用一篇文章详细的介绍一下指针

## 概念理解

>   对于指针学习而言，概念上的准确理解和把握是非常关键的[^参考网址]

### sizeof

>   直接给出`sizeof`在msdn上的**准确定义**，“The sizeof keyword gives the amount of storage, in bytes, associated with a variable or a type (including aggregate types). This keyword returns a value of type size_t.”，`sizeof`的作用是得到*变量*、*类型*、*聚合类型*的==存储字节大小==，并返回自己大小
>
>   *<font color="green">Ps:</font>由于知识所限，本文并不对sizeof的底层逻辑做过多的探讨*
>
>   *<font color="orange">Tip:</font>其实sizeof是通过宏定义实现的，sizeof的运算在预编译阶段就已完成✅*

*可以参考以下运行结果进行思考*

![CleanShot 2022-09-14 at 16.36.15](/Users/wwt13/Documents/Notes/assets/CleanShot 2022-09-14 at 16.36.15.gif)

### 地址

>   地址，就是内存地址，指的是*某块数据在内存中所处的位置*，地址是常量，和数字、字符类似，属于“值”。

### 指针

>   指针是c语言中用于存储地址常量定义的变量，我们通过`&`符号取得对应变量的地址常量，再定义指针变量来保存地址常量，如下示例。
>
>   *<font color="green">Ps:</font>对于取址运算符&，其得到的结果就是一个指针，指针的类型是取址变量+\** 
>
>   ```c
>   int a=100;
>   int *p=&a;
>   ```

#### 指针类型理解

>   要理解指针的各种类型，首先要充分理解之前文章中提及的C符号优先级的问题[^优先级]
>
>   *<font color="orange">Tip:</font>后缀运算符()[]优先级高于一元运算符\*，并且运算符结合顺序从左到右*

```c
int p;//这是一个普通的整型变量
int *p;//从p开始，先和*结合，说明p是一个指针，再和int结合，说明p指向的内容是int类型的变量
int p[3];//从p开始，先和[]结合，说明p是一个数组，再和int结合，说明数组中保存的类型是int
int *p[3];//从p开始，先和[]结合，说明p是一个数组，再和*结合，说明p中存放的是指针，再和int结合，说明指针指向的内容是int类型的变量
int (*p)[3];//从p开始，先和*结合，说明p是一个指针，再和[]结合，说明p指向的是一个数组，再和int结合，说明指向的数组是int类型的
int **p;//从p开始，首先和*结合，说明p是指针，再和*结合，说明p指向的类型是指针，再和int结合，说明p指向的指针指向的类型是int类型
int p(int);//从p开始，首先和()结合，说明p是一个函数，再和括号内的int结合，说明函数的参数是int类型，再和int结合，说明函数的返回值是int类型
int (*)p(int);//从p开始，首先和*结合，说明p是一个指针，再和()结合，说明p指针指向的是一个函数，再和()内的int结合，说明p指针指向的函数需要一个int类型的参数，再和int结合，说明函数返回的是int类型
int *(*p(int))[3];//从p开始，首先和()结合，说明p是一个函数，再和(int)结合，说明p函数需要传入一个int类型的参数，再和*结合，说明p函数的返回值是一个指针，再和[]结合，说明返回的指针指向的是一个数组，再和*结合，说明数组里存放的是指针，再和int结合，说明数组里存放的指针指向的是int类型的变量，所以p是一个返回指向一个指针数组的参数为int的指针函数
至此，对于c指针的定义规则已经完全理解透彻了
```

*<font color="orange">Tip:</font>函数指针就是指向函数的指针，指针函数则是返回值为指针的函数，数组指针和指针数组同理*

#### 关于多重指针的误区

>   用一个小例题来理解一下多重指针容易出现理解错误的点。

*阅读以下这段程序，并判断分别会输出什么内容？*

```c
#include<stdio.h>
int main(){
    char str[20]="You are a pig";
    char *p=str;
    char **pp=&p;
    printf("%c\n",**pp);
    printf("%c\n",**(pp+1));
    printf("%c\n",*(*pp+1));
}
```

无法输出，因为`printf("%c\n",**(pp+1));`中的`**(pp+1)`是完全没有意义的，pp是一个指向指针的指针，让pp+1，等价于pp指针+1得到pp2，pp2指向什么？指向没有意义的二进制数，因为该内存区域没有放置对于的*char\**指针

#### 关于结构体对齐

>   在C语言中，结构体一般会按照某种规则去进行字节对齐，比方说32位系统下的该段代码会得到结构体大小为`16字节`，并且`double c`的地址在结构体+8的位置，这就是进行了地址对齐的结果。
>
>   ```c
>   #include<stdio.h>
>   typedef struct{
>       char a;
>       char b;
>       double c;
>   }stu;
>   int main(){
>       stu s1;
>       printf("%d %d\n",sizeof(stu),sizeof(s1));
>       printf("%d %d\n",sizeof(double),sizeof(char));
>       printf("%d %d %d %d\n",&s1,&s1.a,&s1.b,&s1.c);
>       return 0;
>   }
>   //s1:0,s1.a:0,s1.b:1,s1.c:8
>   ```
>
>   *<font color="green">Ps:</font>结构体的.运算符优先级极高，高于取址运算符*   

***那么为什么要进行地址对齐呢？***

首先要理解，CPU在进行内存数据读取的时候是要看数据总线的位数的，如果是32位，那么一次就读取4个字节的内容，那么如果上面的结构体没有进行数据对齐，一次数据读取读4个字节，那么第一次会读取ab和c的高8位数据，这样的话你怎么让cpu怎么数据处理？

*<font color="green">Ps:</font>对于手动设置数据对齐的部分，现在可以不用考虑* 

地址对齐，也是==**不能直接通过指针偏移访问结构体成员**==的原因，因为你很可能会访问到结构体地址对齐造成的填充字节里

### 数组名

>   数组名和&数组名==数值一样==，代表的都是存放数组这块内存的首地址，它们的区别在于==类型==
>
>   *以`int arr[10]`为例*
>
>   -   `arr`表示的是数组首个元素的地址，类型为*int \**，偏移量为4字节
>   -   `&arr`表示的是整个数组的地址，类型为*int (\*)[10]*，偏移量为40字节
>
>   *<font color="green">Ps:</font>并且数组名代表的指针式常量指针，是不可修改的，无法进行++操作* 
>
>   *<font color="red">Attention:</font>sizeof(数组名)和sizeof(数组名指针)的不同应该是sizeof在预编译阶段进行处理的原因*
>
>   *<font color="red">Attention:</font>对于数组名，无论接收参数的类型是什么，传递后一律变为指针，* 

***程序演示结果如下***

![CleanShot 2022-09-15 at 10.45.30](/Users/wwt13/Documents/Notes/assets/CleanShot 2022-09-15 at 10.45.30.gif)

***函数传参同理***

```c
#include<stdio.h>
int test1(int *p){
    printf("%d %d\n",p,p+1);
    return 2;
}
int test2(int (*p)[10]){
    printf("%d %d\n",p,p+1);
    return 2;
}
int test3(int p[10]){
    printf("%d %d\n",p,p+1);
    return 2;
}
int main(){
    int arr[10];
    int *p1=arr;
    int (*p2)[10]=&arr;
    printf("%d %d\n",p1,p2);
    printf("%d %d\n",p1+1,p2+1);
    printf("%d %d %d\n",test1(arr),test2(&arr),test3(arr));
    return 0;
}//可运行无报错
1876948320 1876948320
1876948324 1876948360
1876948320 1876948324
1876948320 1876948360
1876948320 1876948324
2 2 2
```



# Footnote

[^参考网址]:https://codeantenna.com/a/xq9k78hL5R

[^优先级]:<a href="./C语法汇总.md">语法汇总</a>
