### Java泛型（Generics）

>   **泛型，顾名思义，就是泛化的参数类型**
>
>   泛型的意义在于实现了适用于多种数据类型的相同代码（实现了*代码复用*）

#### Why we need Generics?

<u>这里可以举一个自定义的ArrayList类来理解实现泛型的必要性</u>

```java
public class ArrayList{
    private Object[] array;
    private int size;
    public void add(Object e) {...}
    public void remove(int index) {...}
    public Object get(int index) {...}
}
```

如果用上述`ArrayList`存储`String`类型，会有这么几个缺点

-   如果要获取到String类型，需要强制类型转型`(String)...`
-   代码冗长
-   如果存放了不同类型的话，更加容易出现误转型的情况

```java
ArrayList list=new ArrayList();
list.add('Hello');//向上转型很方便(隐式)
String first=(String)list.a=get(0);//向下需要强转
```

愚蠢的解决方法，为所有class单独编写对应的ArrayList来解决可能出现的误转型情况

==明智的解决方法，使用泛型，将ArrayList变成一种模板`ArrayList<T>`==

#### 泛型的基本使用

>   非常简单，就是指ArrayList等Java数据结构中的泛型使用，所以这里只列举一个简单的例子

```java
private static <T extends Number> add(T a,T b){
    return a+b;
}
```

#### 自定义泛型

>   编写泛型类比普通类要复杂。通常来说，泛型类一般用在集合类中，例如`ArrayList<T>`，我们很少需要编写泛型类

比方说可以编写一个C++中的`Pair`

```java
public class Pair<T>{//T符号随意指定，但是一般采用T
    private T first;//外部T指定内部类型
    private T last;
    public Pair(T first,T last){
        this.first=first;
        this.last=last;
    }
    public T getFirst() {
        return first;
    }
    public T getLast() {
        return last;
    }
}
```

但是对于静态方法，必须使用不同的符号与非静态方法进行区分（*动动脑筋思考下就能理解：静态方法在调用的时候还未指定全局T，所以必须单独指定一个类型K*）

所以对`Pair`添加静态的`create()`方法如下

```java
public class Pair<T>{
    private T first;
    private T last;
    public Pair(T first,T last){
        this.first=first;
        this.last=last;
    }
    public T getFirst() {
        return first;
    }
    public T getLast() {
        return last;
    }
    public static Pair<K> create(K first, K last) {
        return new Pair<K>(first, last);
    }
}
```

*关于泛型方法的定义格式*(不完全遵守也没太大关系，这里只是提供一个标准的规范)

```java
public <T> T getObject(Class<T> c) throws InstantiationException,IllegalAccessException{
    T t=c.newInstance();
    return t;
}
//1.<T>用于声明此方法持有一个类型T，等价于声明该方法为泛型方法
//2.T用于指明该方法的返回类型为T
//3.Class<T>用于指明泛型T的具体类型
```

*为啥要单独定义一个c来创建对象呢？*

>   因为泛型中的类型是在==使用时==指定的，所以创建对象的时候，我们并不知道所创建对象的具体类型是啥，也不知道该对象的构造方法，因此就没有办法去直接`new`一个对象，所以此时需要利用到Java中的反射机制，通过`c.newInstance()`去创建一个对象

如果要使用多个泛型类型也非常简单

```java
public class Pair<T, K> {
    private T first;
    private K last;
    public Pair(T first, K last) {
        this.first = first;
        this.last = last;
    }
    public T getFirst() { ... }
    public K getLast() { ... }
}
```

#### Java实现泛型的基本原理

>   泛型是一种类似”模板代码“的技术，不同语言的泛型实现方式不一定相同。
>
>   Java语言的泛型实现方式是==擦拭法==（Type Erasure）
>
>   所谓擦拭法是指，*虚拟机对泛型其实一无所知，所有的工作都是编译器做的*

例如，我们编写了一个泛型类`Pair<T>`，以下是编译器看到的代码

```java
public class Pair<T> {
    private T first;
    private T last;
    public Pair(T first, T last) {
        this.first = first;
        this.last = last;
    }
    public T getFirst() {
        return first;
    }
    public T getLast() {
        return last;
    }
}
```

Java使用擦拭法实现泛型

-   编译器把类型`<T>`视为`Object`
-   编译器根据`<T>`实现安全的强制转型

虚拟机在执行的时候，根本不知道泛型，它执行的代码都是经过编译器处理的内容

```java
Pair p = new Pair("Hello", "world");
String first = (String) p.getFirst();
String last = (String) p.getLast();
```

所以，Java的泛型是由编译器在编译时实行的，~~编译器内部永远把所有类型`T`视为`Object`处理~~（这里不准确，应该是**无限定的类型变量（也就是直接`<T>`）**会被视为原始类型`Object`处理，而**限定类型变量**则会利用第一个边界的类型变量替换，限定类型在后面会提到），但是，在需要转型的时候，编译器会根据`T`的类型自动为我们实行安全地强制转型

==传入的参数保持原本类型，所以产生冲突时会进行强制类型转换==

---

**原始类型**：就是擦除去了泛型信息，最后在字节码中的类型变量的真正类型，无论何时定义一个泛型，相应的原始类型都会被自动提供，类型变量擦除，并使用其**限定类型**（*无限定的变量用Object*）替换

---

了解了Java泛型的实现方式——擦拭法，我们就知道了Java泛型的**局限**

1.   **T无法是基本类型**，因为其无法向上转化为Object（Object类型无法持有基本类型）

2.   ==无法取得泛型的具体class==（也就是说，T为不同类型，但是获得到的class都是相同的）

     这同时也导致了无法判断带泛型的类型

     ```java
     Pair<Integer> p = new Pair<>(123, 456);
     // Compile error:
     if (p instanceof Pair<String>) {
     }
     ```

3.   无法实例化`T`类型

     下面的代码处于泛型类中

     ```java
     first=new T();
     last=new T();
     ```

     运行时（泛型擦除后）

     ```java
     first=new Object();
     last=new Object();
     ```

     这个理论上没啥问题，但是其实你的真正意图是想要创建`new Integer()`的，这与我们的本意不符，所以编译器会报错（“无法实例化”）

     如果想要在泛型类中实例化`T`类型的话，必须借助额外的`Class<T>`参数

     ```java
     public class Pair<T>{
         private T first;
         private T last;
         public Pair(Class<T> tmp){
             first=tmp.newInstance();
             last=tmp.newInstance();//利用反射的机制来进行实例化(虽然目前还没学反射)
         }
     }
     //并且使用的时候也需要传入Class<T>
     Pair<String> pair=new Pair<String>(String.class);
     ```

     ==总之建议就是不要在泛型类中进行`T`类型的初始化==

4.   不恰当的重写方法（这个其实应该不算局限但是凑数也放上来的）

     下面这段代码，会出现无法通过编译的情况

     ```java
     public class Pair<T> {
         public boolean equals(T t) {
             return this == t;
         }
     }
     ```

     此时定义的`equals(T t)`实际上会被擦拭为`equals(Object t)`，而该方式是继承于类`Object`的（`Object.equals(Object)`），这就导致了方法的覆写，而编译器会阻止实际上会变成覆写的泛型方法定义

     解决方法：*重命名冲突方法即可*

#### extends通配符

已知`Pair<Integer>`不是`Pair<Number>`的子类

现有如下代码

```java
public class Pair<T>{
    private T first;
    private T last;
    public Pair(T first,T last){
        this.first=first;
        this.last=last;
    }
    ......
}
public class PairHelper {
    static int add(Pair<Number> p) {
        Number first = p.getFirst();
        Number last = p.getLast();
        return first.intValue() + last.intValue();
    }
}
int sum=PairHelper.add(new Pair<Number>(1,2);//得到结果3
```

其实上面实际传入的是`new Pair<Number>(Integer,Integer)`

但是如果直接使用`new Pair<Integer>(2,3)`会报错，因为不允许`Pair<Integer>()不是Pair<Number>`的子类

这是就需要利用通配符`extends`（上界通配符）来进行通用匹配

将上面的代码修改如下

```java
public class PairHelper {
    static int add(Pair<? extends Number> p) {
        Number first = p.getFirst();
        Number last = p.getLast();
        return first.intValue() + last.intValue();
    }
}
```

`Pair<? extends Number>`代表可以接受所有Number的子类以及Number本身

这种使用`<? extends Number>`的泛型定义称之为==上界通配符==（Upper Bounds Wildcards），即把泛型类型`T`的上界限定在`Number`而不是默认的`Object`

##### extends通配符的作用

>   ==限制类型权限为只读==（该作用暂时还没完全理解）

```java
class Pair<T> extends Object {
    private T first;
    private T last;
    public T getFirst() {
        return first;
    }
    public void setFirst(T first) {
        this.first = first;
    }
    public T getLast() {
        return last;
    }
    public void setLast(T last) {
        this.last = last;
    }
}
public class test{
    static void tempTest(Pair<? extends Number> tmp) {
        //tmp.setFirst(new Double(3));
        System.out.println(tmp.getFirst());
    }
}
```

如上，利用`? extends Number`的限制，使得tmp类变为只读，除了可以传入`null`（为什么具备该功效，需要了解了`super`通配符之后才能理解）

==“只读效果”是如何实现的？==

>   编译时，对于`tempTest`方法，因为`<? extends Number>`无法确定参数的泛型类型（可能为Number也可能为其子类），所以会出现编译异常的问题，而直接写作`Number`的话限定了传入类型，所以无法实现只读的效果
>
>   ![image-20220702105943454](https://wwt13-images-1305051431.cos.ap-beijing.myqcloud.com/img/image-20220702105943454.png)

#### super通配符

>   前面讲了如何接受子类型，但是如果想要接受父类型的话怎么办呢？
>
>   此时就需要使用`super`通配符

```java
void set(Pair<? super Integer> p,Integer first,Integer last){
    p.setFirst(first);
    p.setLast(last);
}
//该方法能够正常编译
```

同上，该通配符使得对应函数变为==“只写”==（可以输出，但是你无法使用变量来获取）

```java
void get(Pair<? super Integer> p){
    System.out.println(p.getFirst());//可以输出
    //Integer t=p.getFirst();无法通过编译
}
```

唯一可以接收`getFirst()`方法返回值的是`Object`类型（因为它是所有类型的父类，所有类型都可以向上转型为`Object`）

#### extends&super分析

>   二者的区别
>
>   -   `<? extends T>`允许调用读方法`T get()`获取`T`的引用，但不允许调用写方法`set(T)`传入`T`的引用（传入`null`除外）；
>
>   -   `<? super T>`允许调用写方法`set(T)`传入`T`的引用，但不允许调用读方法`T get()`获取`T`的引用（获取`Object`除外）

记住以上结论以后，可以来看一下Java标准库中的`Collections`类定义的`copy()`方法

```java
public class Collections {
    // 把src的每个元素复制到dest中:
    // static后面的T和将参数中的T修改为K的作用一致
    public static <T> void copy(List<? super T> dest, List<? extends T> src) {
        // 作用是将src中的每个元素一次存放到dest中
        // 可以看出,对于元素来源src,我们可以安全的获取类型T的引用,而对于元素目的地dest,我们可以安全的传入类型T的引用
        for (int i=0; i<src.size(); i++) {
            T t = src.get(i);
            dest.add(t);
        }
    }
}
```

##### PECS原则

>   何时使用`extends`，何时使用`super`？为了便于记忆，我们可以用PECS原则：$Producer\ Extends\ Consumer\ Super$
>
>   如果需要返回`T`，它是生产者（Producer），要使用`extends`通配符；如果需要写入`T`，它是消费者（Consumer），要使用`super`通配符

#### 无限定通配符<?>

1.   因为`<?>`通配符既没有`extends`，也没有`super`，因此：

     -   不允许调用`set(T)`方法并传入引用（`null`除外）；
     -   不允许调用`T get()`方法并获取`T`引用（只能获取`Object`引用）

     换句话说，既不能读，也不能写，那只能做一些`null`判断

2.   `<?>`通配符有一个独特的特点，就是：`Pair<?>`是所有`Pair<T>`的超类

记住这两点即可，其实无限定通配符在平时很少会使用