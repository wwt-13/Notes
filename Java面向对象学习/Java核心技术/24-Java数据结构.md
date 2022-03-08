[toc]

# Java数据结构

> 首先声明，这里的数据结构是类似于C++中STL里的通用型数据结构

## 数组

> 非常简单，略

规则多维数组

```java
int[][] a=new int[2][3];
```

不规则多维数组

```java
int[][] b=new int[3][];
b[0]=new int[3];
b[1]=new int[4];
b[2]=new int[5];
```

## JCF介绍

> C++的STL，Java的JCF

- 容器：能够存放数据的空间结构
- 容器结构：为表示和操作容器而规定的一种标准体系结构
  - 对外的接口：容器中所能存放的抽象数据类型
  - 接口的实现：可复用的数据类型
  - 算法：对数据的查找和排序
- 容器框架优点：提高数据的存取效率，避免程序员重复劳动
- JCF主要的数据结构实现类
  - 列表：List，ArrayList，LinkedList
  - 集合：Set，HashSet，TreeSet，LinkedHashSet
  - 映射：Map，HashMap，TreeMap，LinkedHashMap
- JCF主要的算法类
  - Arrays：对数组进行查找和排序
  - Collections：对Collection及其子类进行排序和查找操作

## 列表List

- List中允许重复元素

- List主要实现
  - ArrayList：用处最广泛
    - 以数组实现的列表，不支持同步（不同线程、不同用户端获取的这个集合对象是不同的）、不安全
    - 利用索引可以快速访问
    - 不适合指定位置的插入删除操作
    - 适合变动不大，主要用于查询的数据
    - 和Java数组相比，最大的优点就是可以**动态调整**
    - ArrayList在元素填满数组的是时候会自动扩容50%
  - LinkedList
    - 以双向链表实现的列表，不支持同步
    - 可以被当作堆栈、队列和双端队列进行操作
    - 顺序访问高效，随机访问性能较差，中间插入和删除高效
    - 适用于经常变化的数据
  
  > 总结：ArrayList适用于查询的（静态的）数据，而LinkedList适用于需要大量增删的数据
  
  ---
  
  - Vector（同步）
    - 和ArrayList类似，可变数组实现的列表
    - Vector是同步的，适合在多线程下使用
    - 原先不属于JCF框架，属于Java最早的数据结构，性能较差，从JDK1.2开始，被重写后纳入JCF
    - 官方文档建议：非同步情况下，优先使用ArrayList
  
  

## 集合Set

- 集合Set

  - 确定性：对任意对象都能判断其是否属于某一集合
  - 互异性（注意是==内容互异==，内存地址不同但是内容相同也不行）
  - 无序性：集合内的顺序无关（无顺序可言）

- Java中的集合接口Set

  - HashSet（基于散列函数的集合，无序，不支持同步）

    - 基于HashMap实现的，可以容纳null元素
    - Set s=Collections.synchronizedSet(new HashSet(...))：通过此语句可以使得其同步
    - add：添加一个元素
    - clear：清除整个HashSet
    - contains：判定是否包含一个元素
    - remove：删除一个元素
    - retainAll：计算两个集合的交集

  - TreeSet（基于树结构的集合，可排序，不支持同步）

    - 基于TreeMap实现，==不可以容纳null元素==
    - 根据compareTo方法或指定Comparator排序

  - LinkedHashSet（基于散列函数和双向链表的集合，可排序的，不支持同步）

    - 继承HashSet，也是基于HashMap实现的，可以容纳null元素
    - 和HashSet最大的区别就是：通过双向链表维护插入的顺序，也就是说顺序保留

    不支持同步的数据结构可以在串行程序内正常使用