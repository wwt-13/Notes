# java访问权限

- 四种访问权限
  - public：公开的，所有类都能访问
  - protected：同一个包中、不同包==子类==内均能访问（注意是子类，不同包的父类也不行）
  - default（通常忽略不写）：同一个包内访问
  - private：私有的，只能在本类访问，外部访问只能调用getter函数

- 可访问性：public>protected>default>private

- 使用范围

  - 四种都可以用来修饰**成员变量**，**成员方法**，**构造函数**
  - default和public可以用来修饰类

  文件结构

  <img src="https://wwt13-images-1305051431.cos.ap-beijing.myqcloud.com/img/20220303163426.png" style="zoom:50%;" />

```java
package p2;
import p3.C;
import p3.D;// 不导入的话,只能访问public方法和public变量

public class RightTest1 extends D{
    public static void main(String[] args) {
        A testA=new A();
        B testB=new B();
        C testC=new C();
        RightTest1 x=new RightTest1();
        System.out.println(testA.defaultA);
        System.out.println(testA.publicC);
        System.out.println(testB.protectedA);
        System.out.println(testA.getPrivateB());//私有成员属性需要通过getter方法访问
        System.out.println(testC.getDefaultA());//包外的default成员变量同样需要使用getter方法导入
        System.out.println(x.protectedA);
    }
}
```

- 一般推荐
  - 成员变量private
  - 成员方法public

PLUS：
- static用来修饰内存只有一份
- final用于修饰不可修改（不可继承）

子类访问权限必须大于父类

“儿子从父亲那儿继承一个东西，不能把那个东西变成自己的，不让自己的父亲再用。那肯定是不合理的嘛。”

## 嵌套类

> 由于Java支持嵌套类，如果一个类的内部还定义了嵌套类，那么，嵌套类具有访问private的权限
