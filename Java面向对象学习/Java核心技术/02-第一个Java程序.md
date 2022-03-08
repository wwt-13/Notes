[toc]

# 第一个Java程序

> 开发环境搭建完毕，就可以开始开发第一个Java程序了

1. 编写文件`?.java`
2. 编译源文件`javac.exe`(编译器)
3. 得到`?.class`(java字节码文件)
4. java.exe(java解释器)运行字节码文件

```java
//这是一行注释信息
//public class后面代表定义一个类的名称，类是Java当中所有源代码的基本组织单位
public class 文件名{
    //第二行的内容是万年不变的固定方法，代表main方法
    //main方法是程序执行的起点
	public static void main(String[] args){//简写psvm
        //打印输出语句
		System.out.println("Hello World");//简写sout
        /*
        这是多行注释
        */
	}
}
```

**Dos执行方式**

```shell
javac HelloWorld.java # 编译java源文件
java HelloWorld # 结尾不要加class
```

## 代码规范

关键字的特点

1. 全小写
2. 特殊颜色

标识符的要求

1. 不能以数字开头
2. 不能是关键字

标识符的命名规范

1. 包名规范：全小写
1. 类名规范:首字母大写，后面每个单词首字母大写（大驼峰式）
2. 变量名规范:首字母小写，后面每个单词首字母大写（小驼峰式）
3. 方法名规范:同变量名
3. 常量名规范：全大写
3. 尽量把private方法放在类的后面，public放在类前面，因为public是类对外提供的功能

## 关于main函数的理解

> 并不是所有Java文件都具备main函数
>
> 很多类中没有main方法，是因为它们不是**程序的入口**，也就是说程序执行不是从它们开始的，是**由含有main方法的类开始执行**（main方法是程序入口），当程序用的其他的类时会自动编译它，并使用它的属性和方法。

## 数据类型

### 基本数据类型

- 整数
  - byte:字节型，占用一个字节（8位）-128~127
  - short:2字节
  - int:4字节
  - long:8字节，使用需要加后缀L
- 浮点数
  - float:使用需要加后缀F
  - double
- 字符
  - char:2字节，0-65535，所以java中的字符是可以用来表示中文的，但是貌似只能输出单个中文
- 布尔
  - boolean:1字节（同c++中的bool类型）

### 引用数据类型

- 字符串
- 数组
- 类
- 接口
- Lambda

注意：判断引用的是不是同一个对象，直接使用`==`，判断引用对象的内容是否相等，必须要使用`equals()`方法

```java
s1.equals(s2);
```



## 变量

```java
public class Variable{
    public static void main(String[] args){
        int num=10;
        int a=10,b=5,c=6;
        System.out.println(num);//正常使用即可
    }
}
```

注意事项

1. 变量赋值不能超范围
2. **作用域**:变量定义行到所处的**大括号**结束内

## 常量

```java
final double PI=3.14;//PI是一个常量
```

## 数据类型转换

### 隐式类型转换

> 规则:数据范围(不是字节数)==从小到大==
>
> 运算中有不同类型的数据，结果是数据类型大的那个
>
> ```java
> long Num_int=100;
> double Num_double=2.5F;
> float Num_float=100L;
> ```

### 显式类型转换

> byte/short在进行运算的时候，会先提升为int类型，再进行运算，所以得到值的类型都是int
>
> boolean类型不能发生任何数据类型转换

```java
int Num_int=100;
long Num_long=10000;
Num_int=(int)Num_long
```

## 关于编码表

> ASCII:0-127
>
> Unicode(万国码):0-127和ASCII一致，后面为各种语言的字符，甚至包含emoij
>
> `\u####`表示一个Unicode编码的字符

字符表示可以使用`char c='\u4e2d'`来进行表示

## 字符串

```java
public class String_Test{
    public static void main(String[] args){
        String str1="Hello",str2="World";
        System.out.println(str1+' '+str2);//+可以用于连接字符串，而且任何数据类型与String做加法都会变为String类型
        //并且连接优先级自动从前向后
    }
}
```

**多行字符串的表示**：和Python中一致，采用**"""...."""**

注意空值null不等于空字符串""

- `str1.substring(start,end)`:得到[start,end)的字符串

## 数组

> 定义方式和C++中的new方法基本一致
>
> ```java
> int[] array=new int[5];
> var 
> ```
>
> 注意数组大小不可变
>
> 获取数组长度：`array.length`

### 数组遍历

> 数组遍历的两种方式for循环和for each遍历\

```java
int[] arr=new int[]{12,23,123,34};
for(int i=0;i<arr.length;i++){
    System.out.println(arr[i])
}
for(int i:arr){
    System.out.println(i)
}
```

### 数组打印

> Arrays.toString(arr)方法可以快速打印出数组中的内容，多维数组的打印则使用Arrays.deepToString(arr)

```java
package grammer;

import java.util.Arrays;

public class ToString {
    public static void main(String[] args) {
        var array=new int[]{1,2,3,44};
        System.out.println(Arrays.toString(array));
        //输出[1, 2, 3, 44]
    }
}

```

### 数组排序

> 数组操作类`import java.util.Arrays`
> 该类内置操作函数Arrays.sort()
> 注意该操作修改的是数组本身

```java
import java.util.Arrays;
int[] arr={1,3,234,2341,123,3};
Array.sort(arr);
```

### Java命令行

> Java程序的入口是main方法，main方法可以接受一个命令行参数，它是一个String[]数组

```java
public class Test{
    public static void main(String[] args){
        for(String arg:args){
            if("-version".equals(arg)){
                System.out.println("v 1.0");
                break;
            }
        }
    }
}
```

上述程序执行时传递参数`java Test -version`

## Java-IO

### Java输出函数

- 基本输出换行：`System.out.println(...)`
- 基本输出不换行：`System.out.print(...)`
- 格式化输出：`System.out.printf("%.4f",d);//和C中一致`

### Java输入函数

> 和简单的输出函数相比，Java中的输入函数明显要复杂的多
>
> ==输入包==：`import java.util.Scanner`

从控制台读取一个字符串和整数

```java
package grammer;
import java.util.Scanner;

public class Scan{
    public static void main(String[] args){
        Scanner scanner=new Scanner(System.in);//创建Scanner对象并获取标准输入流
        System.out.println("Input your name:");
        String name=scanner.nextLine();//读取一行并输入字符串
        System.out.println("Input your age:");
        int age=scanner.nextInt();
        System.out.printf("My name is %s,and I am %d years old\n",name,age);
    }
}
```

`Scanner scanner=new Scanner(System.in)`:创建Scanner对象并获取标准输入流，System.in代表标准输入，System.out代表标准输出，这一步的主要目的是为了简化代码

## Java流程控制

### Switch

> 这里讲的是从Java14开始支持的==新版Switch语句==

1. 使用`->`
2. 取消了`break`，语法不再具备穿透性
3. 可以直接返回值（也可以通过`yield`返回值）

```java
package grammer;
import java.util.Scanner;
public class Switch {
    public static void main(String[] args) {
        var scanner=new Scanner(System.in);
        String flag=scanner.nextLine();
        int opt=switch(flag){
            case "apple"->1;
            case "banana"->23;
            case "orange","fruits"->12314;//两个可以联合判断
            default->{
                int code=scanner.nextInt();
                yield code*2;
            }//复杂语法采用yield的方式返回值
        };
        System.out.println(opt);
    }
}

```



## 方法

### 方法的定义

> 注意不能嵌套定义（方法内部不能定义方法）

基本格式

```java
public static void 方法名(){
    方法体
}
```

### 方法-可变参数传递

> 以String为例，可变参数的好处就是调用方不需要自己实现构造String[] 且传入参数不定

```Java
class Group{
    private String[] names;
    public void setNames(String... names){
        //注意...是语法
        this.names=names;
    }
}
var g=new Group();
g.setNames("123","123","123sdfsf");
g.setNames("wwt");
g.setNames();//可以传入0个String
```

### 方法重载举例

> 以String类提供的indexOf方法为例（用于查找字串位置）

```Java
int indexOf(int ch);//根据字符查找
int indexOf(String str);//根据字符串查找
int indexOf(int ch,int fromIndex);//指定字符查找的起始位置
int indexOf(String str,int fromIndex);
```

## 继承

### protected

> 继承的特点呢就是子类无法访问夫类的private字段和方法，此时可以定义其为protected，这样子类就可以访问（**protected**使得继承的作用被削弱了）

### super

> super关键字表示父类，就像子类中的this（这个知识点以前还没听说过）

### 阻止继承

> 从Java15开始，允许使用==sealed==修饰class，并通过permits指明能从该class继承的子类名称

```Java
public sealed class Shape permits Rect,Circle,Triangle{
    //Shape只允许permits指明的三个类继承它
}
```

### 关于继承和组合

> 现在我们有两个类，一个类是Book，另外一个类叫Student

```Java
class Book{
    protected String name;
    public String getName(){...};
    public void setName(String name){...}
}
class Student{
    protected int score;
}
```

经过观察发现，Book类和Student都应该具备name字段，那么能不能让Student类直接继承Book呢

这显然是不切实际的，Student应该继承Person才对

究其原因，是因为Student是Person的一种，他们之间是is关系，Student is Person，而Student并不是Book，而应该是Student has Book；

那么我们应该如何表述has关系呢

很简单，让Student持有一个Book示例即可

```Java
class Student extends Person{
    protected Book book;
    protected int score;
}
```

总结一下就是：**继承是is关系，组合是has关系**



## 抽象类

> 抽象类/方法的作用就是给子类==定义了规范==

尽量引用高层类型，避免引用实际子类型的方式，称之为面向抽象编程。

- 面向抽象编程的本质
  1. 上层代码只定义规范（例如public abstract class Person）
  2. 不需要子类就能实现业务逻辑
  3. 具体的业务逻辑由不同的子类去实现，调用者不需要关心
  4. 实现了低耦合的代码结构

## 接口

> 注意接口**不需要修饰符**，因为所有接口默认都是`public abstract`（当然写了也没事），Java中接口的实现就是为了弥补Java中不存在多类继承的问题，Java只能继承一个类/抽象类，但是可以实现多个接口

### 接口中的default（和基本的default不同）

> 在接口中，可以定义`default`方法，因为实现了接口的类会很多，此时如果给接口新增一个正常的方法，那么你就需要去所有的子类中实现这个方法，否则就会报错，但是呢，如果新增的是default方法，那么<u>子类就不必全部修改，而只需要在需要实现的地方去实现新增方法即可</u>

## 包

> 在了解包之前，我们首先要来看看几个问题
>
> 1. 现实中，如果小明写了一个`Person`类，小红也写了一个`Person`，现在，小白既想用小红的Person，又想用小明的Person，怎么办？
> 2. 如果小军写了一个Arrays类，恰好JDK也自带了一个Arrays类，如何解决类名冲突？
>
> 于是Java定义了一种名字空间，称之为包，用于解决类名冲突等问题

### 包的作用域

> 位于同一个包的类，可以访问包作用域的字段和方法，也就是说，default的范围就等于包的范围（注意因果关系）

### 关于import

1. import导入类的时候需要写类的全名（包名.类名）

2. import的时候使用\*可以把这个包下面的所有class都导入进来（==但是注意不包括子包内的class！！！==），也就是说，“所有java程序都导入java.lang”，这句话实际上说的导入并不包括java.lang的子包
3. 如果存在多个class名称相同，那么只能导入一个，另外一个必须写出完整类名

## 类

> 以下讲讲Java中的两种比较特殊的类

### Inner Class

> 内部类，也就是定义在一个类内部的类
>
> 内部类的特权，可以修改类的private字段

内部类与普通的类最大的不同就是，Inner Class的实例不能单独存在，而必须依附于一个Outer Class的实例

```java
class Outer{
    ...
    class Inner{
        //定义了一个内部类
        ...
    }
}
public class Main{
    public static void main(String[] args){
        Outer outer=new Outer("Nested");
        Outer.Inner inner=outer.new Inner();
    }
}
```



### Anonymous Class

> 匿名类，......（暂时没看太懂，但是可以辨认了）



## 杂

### var关键字

> Java中的var等价于C++中的auto关键字
>
> 但是这个推断有局限性，反正不报错的话就用吧，报错就老老实实的写一遍类型。
>
> 作用：自动推断变量类型

```java
StringBuilder sb=new StringBuilder();
var sb=new String
```

### for each循环

> 和C++中一致，这也是Java的一个小语法糖
>
> ```java
> var array=new int[5];
> //原来为for(int i=0;i<array.length;i++)
> for(int i:array){//增强版for，更加简洁
>  System.out.println(i);
> }
> ```
>
> IDEA中可以直接`alt+insert`进行修改
>
> 优点：方便，能够遍历所有可迭代的数据类型
>
> 缺点：不能指定遍历顺序，也无法获取数组索引

## hashcode

> hashcode方法：获取一个实例的hash值（和指针类似？）

```java
package p2;

public class LinkedHashSetTest {
    private int a;
    private int b;
    public static void main(String[] args) {
        var aInstance=new LinkedHashSetTest();
        var bInstance=new LinkedHashSetTest();
        System.out.println(aInstance.hashCode());
        System.out.println(bInstance.hashCode());
    }
}
```

