[toc]

# OS前置知识

## 计算机组成原理

### MIPS汇编语言

> 所学MIPS CPU版本——MIPS32

#### 指令类型

<img src="https://wwt13-images-1305051431.cos.ap-beijing.myqcloud.com/img/20220228130553.png" style="zoom:50%;" />



#### 关于指令的寻址方式

- R型指令

  寄存器直接寻址：`add $1 $2 $3`

- I型指令

  - 立即数寻址：`addi $1 $2 3`

  - 基址寻址：`sw $1 4($2)`等一系列内存操作指令

    <img src="https://wwt13-images-1305051431.cos.ap-beijing.myqcloud.com/img/20220228134640.png" style="zoom:50%;" />

  - 相对寻址：`beq $1 $2 label`

    <img src="C:\Users\86188\AppData\Roaming\Typora\typora-user-images\image-20220228140025799.png" alt="image-20220228140025799" style="zoom:50%;" />

- J型指令

  伪直接寻址：`J address`

  <img src="C:\Users\86188\AppData\Roaming\Typora\typora-user-images\image-20220228140144770.png" alt="image-20220228140144770" style="zoom:50%;" />

#### 寄存器种类

- MIPS下共有32个通用寄存器\$0-\$31、32个浮点数运算寄存器f0-f31、乘法除法寄存器\$lo和\$hi
- 栈的走向，从高地址走向低地址

#### 关于指令流水

> 5个指令流水阶段约定
>
> 1. IF：从存储器中取出一条指令并暂时存入指令部件的缓存区
> 2. ID：译码和从寄存器堆中读取寄存器数据
> 3. EX：执行阶段（ALU）
> 4. MEM：操作内存阶段
> 5. WB：将数据写回寄存器
>
> ![](https://wwt13-images-1305051431.cos.ap-beijing.myqcloud.com/img/20220228142017.png)

##### 流水冒险问题

- 结构冒险：

  > 资源竞争，要使用的部件正在忙（同⼀部件在不同阶段中被不同的指令同时使用）。例如，若系统只有⼀个存储器部件，就会带来结构冒险问题

- 数据冒险：

  > 指令执行所需的数据暂时不可用而造成的指令执行的停顿。数据冒险一般发生在相近指令访问⼀个存储单元或寄存器时。后序指令需要等待前序指令执行完毕 

- 控制冒险：

  > 也称为分支冒险（branch hazard），必须根据前⼀条指令的执行结果 才能确定下⼀条真正要执行的指令，此时流水线中取得的可能不是真正要执行的指令

### C语言程序设计、编译与运行

> ![](https://wwt13-images-1305051431.cos.ap-beijing.myqcloud.com/img/f85f8ebec64ee440ed4929546592d3f.png)
>
> ![img](https://coekjan.github.io/img/CP-Src2Exe.svg)
>
> ==总体步骤介绍==
>
> ```mermaid
> flowchart LR
> Hello1.c-->|预处理|Hello1.i-->|编译|Hello1.s-->|汇编|Hello1.o
> 同样的步骤-->Hello2.o
> 同样的步骤-->Hello3.o
> Hello1.o -->链接
> Hello2.o -->链接
> Hello3.o -->链接
> 链接-->可执行文件
> ```

### 编译

> 就是把程序员所写的高级语言代码转化为对应的==目标文件==的过程（目标文件非可执行文件）

#### 预处理

- 删除所有的注释信息
- 删除了所有的#define并插入宏定义
- 插入所有的#include文件的内容到源文件的对应位置，并且该include过程是递归执行的
- 。。。。。。

```shell
gcc -E hello.c -o hello.i # 将hello.c程序预编译并且将预编译的结果输出到hello.i
```

#### 编译

>  编译就是对预处理之后的文件进行词法分析、语法分析、语义分析并优化后生成相应的汇编文件。我们使用如下命令来编译预处理之后的文件

```shell
gcc -S hello.i -o hello.s
```

#### 汇编

> 汇编的目的是将汇编代码转化为机器指令，并生成目标文件，目标文件的结构与可执行文件是已知的，它们之间只存在一些细微的差别

```shell
gcc -c hello.s -o hello.o
```

### 链接

> 所谓链接，就是指一个目标文件，可能会依赖其他目标文件，而将它们“串”起来的过程，就是链接
>
> 所谓链接，就是指一个目标文件，可能会依赖其他目标文件，而将它们“串”起来的过程，就是链接

