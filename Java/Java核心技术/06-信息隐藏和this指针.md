[toc]

# 信息隐藏和this指针

- 面向对象有一个法则:信息隐藏

  - 类的成员属性，是私有的private
  - 类的方法属性是公有的public，**通过方法来修改成员属性的值**

  举个例子:朋友再熟悉，也不会到他的抽屉里直接拿东西，而是通过他的公开接口来访问、修改东西（好哇，生动嗷）

- 类成员是私有的

- get和set方法是公有的，统称为getter和setter

- 外接对类成员的操作只能通过get和set方法

- 可以通过Java IDE快速生成

  光标置于类大括号内，快捷键`alt+insert`，选择生成getter和settter即可

  <img src="https://wwt13-images-1305051431.cos.ap-beijing.myqcloud.com/img/20220226225736.png" style="zoom:50%;" />

- this负责指向本类中的成员变量（与C++同理）

- this负责指向本类中的成员方法

  `this.add(5,3);//调用本类中的add方法，this可忽略`

- this可以代替本类的构造函数

  `this(5);//调用本类的一个形参的构造函数`

# Java访问控制符private、public、protected详解

