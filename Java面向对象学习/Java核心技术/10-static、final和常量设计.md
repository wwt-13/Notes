[toc]

# static、final和常量设计

## static

### static变量

- static 静态关键字（代表只有一份）
- Java中的static关键字作用范围
  - 变量
  - 方法
  - 类
  - 匿名方法块

```java
package Static;
public class Potato {
	static int price = 5;//静态成员变量
	String content = "";
	public Potato(int price, String content)
	{
		this.price = price;
		this.content = content;
	}	
	public static void main(String[] a)
	{
		System.out.println(Potato.price); //Potato.content    wrong
		//不能在12行直接输出Potato，因为content不是静态变量，不是依赖于类存在的
		System.out.println("----------------------------------");
		Potato obj1 = new Potato(10,"青椒土豆丝");
		System.out.println(Potato.price);
		System.out.println(obj1.price);
		
		System.out.println("----------------------------------");
		Potato obj2 = new Potato(20,"酸辣土豆丝");
		System.out.println(Potato.price);
		System.out.println(obj2.price);
		
	}
}

```

- 静态成员变量==依赖于类存在==，可以直接通过`类.静态变量名`访问，而非静态变量需要通过实例来进行访问
- 并且内存中有且==仅有一份==静态成员变量，通过实例访问和通过类访问的静态成员变量位于同一个地址

### static方法

- 静态方法同样可以直接通过类名来访问（也可以通过实例访问，但是不推荐）
- 并且非静态方法可以调用静态方法
- 静态方法中只能使用静态变量，并且不能引用非静态方法（不太清楚是什么原因，可能就是一个约定（类内的方法都会初始化的））

```java
package Static;

public class StaticMethodTest {
	int a = 111111;
	static int b = 222222;
	public static void hello()
	{
		System.out.println("000000");
		System.out.println(b);
		//System.out.println(a);  //error, cannot call non-static variables
		//hi()                    //error, cannot call non-static method
	}
	public void hi()
	{
		System.out.println("333333");
		hello();                  //ok, call static methods
		System.out.println(a);    //ok, call non-static variables
		System.out.println(b);    //ok, call static variables
	}
	public static void main(String[] a)
	{
		StaticMethodTest.hello();
		//StaticMethodTest.hi(); //error, 不能使用类名来引用非静态方法
		StaticMethodTest foo = new StaticMethodTest();
		foo.hello();  //warning, but it is ok
		foo.hi();     //right
	}
}

```



### staic修饰类（内部类）

> 使用机会较少，暂时可忽略

### static修饰代码块

> 不建议使用代码块，建议封装到构造函数里面去调用等等

- 只在类第一次被加载时使用（这一点比较特殊，可以注意一下）
- 换句话说，在程序运行期间，这段代码只运行一次
- 执行顺序：static块>匿名块>构造函数

```java
package Static;

class StaticBlock
{
	//staticl block > anonymous block > constructor function	
	static//静态代码块
	{
		System.out.println("22222222222222222222");
	}
	{//匿名代码块
		System.out.println("11111111111111111111");
	}
	public StaticBlock()//构造函数
	{
		System.out.println("33333333333333333333");
	}
	{//匿名代码块
        System.out.println("44444444444444444444");
	}
}
```

```java
package Static;

public class StaticBlockTest {

	public static void main(String[] args) {
		System.out.println("000000000000000");
		// TODO Auto-generated method stub
		StaticBlock obj1 = new StaticBlock();
		StaticBlock obj2 = new StaticBlock();
	}
}
//输出结果
//000000000000000
//22222222222222222222
//11111111111111111111
//44444444444444444444
//33333333333333333333
//11111111111111111111
//44444444444444444444
//33333333333333333333
```

## 单例模式

> static关键字作用与变量时，此变量在内存中只有一个拷贝，由此引申出一个非常经典的设计模式
>
> ==单例模式==

- 单例模式，又名单态模式（Singleton）
- 限定了某一个类在整个程序的运行过程中，只能保留一个实例对象在内存空间（只能==new==一次）
- GoF的23种设计模式（Design Pattern）中很经典的一种，属于创建型模式类型

**关于设计模式**

> 在软件开发过程中，经过验证的，用于解决在特定环境下的、重复出现的、特定问题的解决方案
>
> 1995年三位大佬总结了这23种设计模式

- 单例模式
  - 采用static来共享对象实例
  - 采用private使得构造函数私有化，防止外界new操作

```java
package Singleton;

public class Singleton {
	private static Singleton obj = new Singleton(); //共享同一个对象
	private String content;
	
	private Singleton()  //priva确保只能在类内部调用构造函数
	{
		this.content = "abc";
	}
	
	public String getContent() 	{
		return content;
	}//getter
	public void setContent(String content) {
		this.content = content;
	}//setter	
	
	public static Singleton getInstance()	{
		//静态方法使用静态变量
		//另外可以使用方法内的临时变量，但是不能引用非静态的成员变量
		return obj;
	}
	
	
	public static void main(String[] args) {
		Singleton obj1 = Singleton.getInstance();
		System.out.println(obj1.getContent());  //abc
		
		Singleton obj2 = Singleton.getInstance();
		System.out.println(obj2.getContent());  //abc
		
		obj2.setContent("def");
		System.out.println(obj1.getContent());
		System.out.println(obj2.getContent());
		
		System.out.println(obj1 == obj2); //true, obj1和obj2指向同一个对象
	}

}

```

## final

- Java中的final关键字同样可以用来修饰
  - 类
  - 方法
  - 字段
- final修饰的类，不能被继承!!!!
- ==因此，如果在想明确禁止该方法在子类中被覆盖的情况下才会将方法设置为final的==。
- 父类中如果又final修饰的方法，那么子类中不能重写这个方法
- final的变量，不能再次赋值
  - 对于<u>基本类型的变量</u>，不能修改其值
  - 如果是<u>对象实例</u>，那么不能修改其指针指向，但是==可以修改指针指向的内容==

## 常量设计

- Java中不存在constant关键字
  - 不能修改：final
  - 不会修改/只要一份：static
  - 方便访问：public
- Java中的常量关键字：public static final
- 建议常量名字全大写
- 特殊的常量，接口中定义的变量，默认都是常量（当然接口中一般只定义方法），这也是因为接口使用频繁，一般不修改

```java
package Constant;

public class Constants {
    public final static double PI_NUMBER=3.14;

    public static void main(String[] args) {
        System.out.println(Constants.PI_NUMBER);
    }
}
```

### 常量池

- Java为很多基本类型的包装类/字符串都建立常量池

- 注意所有基本类型的包装类都是不变类，同时，包装类之间的比较也要使用**equals()**来进行比较。

- 常量池：相同的值只存储一份，==节省内存，共享访问==

- 基本类型的包装类
  - ==Boolean、Byte、Short、Integer、Long、Character==、Float、Double
  - Boolean：true、false
  - Byte：-128-127，Character：0-127
  - Short，Int，Long：-128-127
  - Float，Double：没有缓存（常量池）
  
- 基本类型的包装类和字符串有两种创建方式
  - 常量式赋值创建，放在栈内存中（将会被常量化）
    - `Integer a=10;//自动装箱`
    - String b="abc";
  - new对象进行创建，放在堆内存中（==不会被常量话==）
    - Integer a=new Integer(10);
    - String b=new String("abc");
  
- **关于包装类的实例化问题**

  - 方法1：`Integer n=new Integer(100);`总是创建新的实例，占用内存（堆上不存在常量池）
  - 方法2：`Integer n=Integer.valueOf(100);`**属于静态工厂方法，它将尽可能的返回缓存的实例以节省内存**

  创建新对象时，优先选用静态工厂方法而不是new操作符。

**自动装箱与自动拆箱**

- 自动装箱：Integer a=10;//基本类型自动转换为包装类（包装了一下）
- 自动拆箱：基本类型和包装类进行比较，包装类自动拆箱（拆掉了包装）成为基础类型再进行比较，并且包装类之间的运算也会自动拆箱

```java
package Constant;

public class BoxClassTest {
	public static void main(String[] args)
	{
		int i1 = 10;
		Integer i2 = 10;                // 自动装箱
		System.out.println(i1 == i2);   //true
		// 自动拆箱  基本类型和包装类进行比较，包装类自动拆箱
		
		Integer i3 = new Integer(10);
		System.out.println(i1 == i3);  //true
		// 自动拆箱  基本类型和包装类进行比较，包装类自动拆箱
		
		System.out.println(i2 == i3); //false
		// 两个对象比较，比较其地址。 
		// i2是常量，放在栈内存常量池中，i3是new出对象，放在堆内存中
		
		Integer i4 = new Integer(5);
		Integer i5 = new Integer(5);
		System.out.println(i1 == (i4+i5));   //true
		System.out.println(i2 == (i4+i5));   //true
		System.out.println(i3 == (i4+i5));   //true
		// i4+i5 操作将会使得i4,i5自动拆箱为基本类型并运算得到10. 
		// 基础类型10和对象比较, 将会使对象自动拆箱，做基本类型比较
		
		Integer i6 = i4 + i5;  // +操作使得i4,i5自动拆箱，得到10，因此i6 == i2.
		System.out.println(i1 == i6);  //true
		System.out.println(i2 == i6);  //true
		System.out.println(i3 == i6);  //false
	}	
}

```

```java
package Constant;

public class StringNewTest {
	public static void main(String[] args) {
		String s0 = "abcdef";
		String s1 = "abc";
		String s2 = "abc";//常量式赋值，位于常量池中
		String s3 = new String("abc");
		String s4 = new String("abc");//堆内存中两个不同的地址
		System.out.println(s1 == s2); //true 常量池
		System.out.println(s1 == s3); //false 一个栈内存，一个堆内存
		System.out.println(s3 == s4); //false 两个都是堆内存
		System.out.println("=========================");
		
		String s5 = s1 + "def";    //涉及到变量，故编译器不优化（只有'a'+'b'+'c'这种才会进行优化），string貌似没有自动zhuang'x
		String s6 = "abc" + "def"; //都是常量 编译器会自动优化成abcdef
		String s7 = "abc" + new String ("def");//涉及到new对象，编译器不优化
		System.out.println(s5 == s6); //false
		System.out.println(s5 == s7); //false
		System.out.println(s6 == s7); //false
		System.out.println(s0 == s6); //true 
		System.out.println("=========================");

		
		String s8 = s3 + "def";//涉及到new对象，编译器不优化
		String s9 = s4 + "def";//涉及到new对象，编译器不优化
		String s10 = s3 + new String("def");//涉及到new对象，编译器不优化
		System.out.println(s8 == s9); //false
		System.out.println(s8 == s10); //false
		System.out.println(s9 == s10); //false
	}
}
```

