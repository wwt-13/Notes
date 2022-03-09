# 命令行

> 现在位于D:/tmp/cn/com/test下有一个Man.java文件
>
> 内容如下
>
> ```java
> package cn.com.test;
> public class Man{
>     public static void main(String[] args){
>         System.out.println("This is Man.java");
>   }
> }
> ```
>
> 运行
>
> ```shell
> javac d:/tmp/cn/com/test/Man.java
> ```

## classpath命令结构

- java -classpath .;d:/tmp cn.com.test.Man
- 第一部分：java，执行命令，是java.exe的缩写
- 第二部分：-classpath固定参数格式，可以简写为-cp
- 第三部分：**路径集合**，以`;`隔开，如上分别是当前路径和d:/tmp路径，根据子路径去子路径下查找后面所需的主执行类，且前优先级大于后优先级（一旦前面找到，后面就不再寻找）
- 第四部分：主执行类的全称（含包名）

## 编译和运行规则

- 编译一个类，需要java文件的全路径，包括扩展名

- 运行一个类，需要写类名全称（非文件路径），无需写扩展名

- 编译类的时候，需要给出这个类所依赖的类（迭代性）的所在路径

- 运行类的时候，需要给出这个类，以及被依赖类的路径总和

- classpath参数可以包含jar包，如果路径内由空格，请将classpath参数整体加双引号（jar包会临时解压，不需要整体也可以）

  ```shell
  java -cp .;c:/test.jar;c:/temp;"c:/a bc" cn.com.test.Man
  ```

具体运行举例

|            类名（全称）             | 文件名 |    文件全路径    |                编译指令                |             运行指令             |
| :---------------------------------: | :----: | :--------------: | :------------------------------------: | :------------------------------: |
|                A.B.C                | C.java | d:/m1/A/B/C.java |      `javac -cp d:/m1 A.B.C.java`      |      `java -cp d:/m1 A.B.C`      |
|        D.E.F（引用了A.B.C）         | F.java | d:/m2/D/E/F.java |      `javac -cp d:/m1 D.E.F.java`      |   `java -cp d:/m1;d:/m2 D.E.F`   |
| G.H（引用了D.E.F，间接引用了A.B.C） | H.java |  d:/m3/G/H.java  | `javac -cp d:/m1;d:/m2;d:/m3 G.H.java` | `java -cp d:/m2;d:/m2;d:/m3 G.H` |

实践之后，基本理解了classpath的使用方式

### 关于核心类库

> 核心类库java会默认引入，根本不需要额外引入
