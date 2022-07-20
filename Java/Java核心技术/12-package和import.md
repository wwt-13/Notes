# package和import

> 本章内容解决Java程序分布式放置和调用的问题

- 之前写的程序，所有的Java类都是放置在同一个目录下的，因此，类之间的相互调用无需显式声明

  但这会带来很多问题

  - 同一个目录下，类的名称不能相同
  - 文件过多，不易查找

- Java支持多目录放置Java文件，并且通过package/import/classpath/jar等机制配合使用，可以支持跨目录放置和调用Java类

## package

- package包，和C++中的namespace类似

- 在Java文件的第一句给出包的名称

  ```java
  package cn.edu.buaa;
  public class Test{
      public static int a=100;
  }//public说明可以在类外调用，static说明内存中仅有一份
  ```

- 类全称=包名+类名

- 引用类的时候，必须使用全名称；程序正文中可以写短名称

- 包名尽量唯一，所以包名常用域名来做包名（并且逆序）

```java
package p1.p3;
import p1.p2.Test;
//也可以采用import p1.p2.*，直接导入所有文件（当然此目录下不能有文件夹,应该说文件夹下的文件无法递归导入）
public class PackageTest {
    public static void main(String[] args) {
        System.out.println(Test.a);
        System.out.println(new Test().a);//申请临时使用的匿名对象
    }
}
```

## import

- import必须全部放在package后面，类定义前面
- import可以使用\*，但是不推荐（不能递归包含且可能报错）
- 程序需要引用多个同名类时，只能import一个，其余需要通过全名直接导入
