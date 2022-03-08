[toc]

# Java-面向对象思想

> 对象=属性+方法
>
> 对象的规范=属性定义+方法定义

- 面向对象编程语言始祖Smalltalk

- 当前最主要:C++\Java
- 面向对象语言思想
  - 识认性
  - 类别性
  - 多态性
  - 继承性

## 面向对象思想

**子类必须通过父类的方法，才能访问父类的私有变量**

类与对象特性举例

![](https://gitee.com/ababa-317/image/raw/master/images/20220203100322.png)

感受一下继承和IDEA的文件结构

文件结构

![](https://gitee.com/ababa-317/image/raw/master/images/20220203101243.png)

**Father**

```java
package p1;

public class Father {
    private int money = 100;
    long mouble = (long) 1e10;

    public void hello() {
        System.out.println("hello");
    }

    public void outputMoney() {
        System.out.println(money);
    }
}
```

**Son**

```java
package p1;

public class Son extends Father {
    public void hi() {
        System.out.println("hi~~~~~~~");
    }

    public static void main(String[] args) {
        Son s = new Son();
        System.out.ptln(s.mouble);
        s.hello();
        s.outputMoney();
        s.hi();
    }
}
```

## 类和对象

> 最简单的类和对象

```java
class A{}
A obj =new A()
```

- obj可一看作是内存中一个对象(包含若干数据)的句柄

- 在C/C++中，obj称为指针，在Java中称为**Reference**

- 对象(整个)赋值时Reference赋值，而基本类型是直接值拷贝

  也就是说对象赋值可以等价与指针拷贝而已，指向的内存空间是相同的

- 产生一个对象，A obj=new A();

  99%的情况都是使用new关键字，还有1%是用克隆和反射生成的

- **函数内的局部变量**:编译器不会给默认值，需要初始化后才能使用；

- **类的成员变量**:编译器会给默认值，可以直接使用

- new出对象后，内部属性值默认为

  - short=0，int=0，long=0L
  - byte=0
  - boolean=false
  - char='\u0000'
  - float=0.0f
  - double=0.0(d)

  
