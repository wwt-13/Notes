[toc]

# Linux基础课-6.1 thrift

> 以做一个小项目的方式来讲解thrift，项目地址为acgit。
>
> thrift东西不如git多，但是却是Linux基础中最难懂的知识点，要涉及很多语法、多线程、线程加锁等知识
>
> 具体应用：AcWing网站上的Acshaber的匹配功能，以及评测机的评测功能，都需要用到thrift来实现

## thrift概论

> 写一个应用的时候，一般需要实现各种不同的服务，并且不同的服务会被分配到各种不同的服务器上（类似“微服务”的概念）
>
> thrift被当作一个远程过程调用（RPC）框架来使用，是由Facebook为“大规模跨语言服务开发”而开发的
>
> **什么是RPC**：远程过程调用(Remote Procedure Call,缩写为 RPC)是一个计算机通信协议。该协议允许运行于一台计算机的程序调用另一台计算机的子程序，而程序员无需额外地为这个交互作用编程。 比如 Java RMI(远程方法调用(Remote
> Method Invocation)。能够让在某个java虚拟机上的对象像调用本地对象一样调用另一个java虚拟机中的对象上的方法)。
>
> 例1：游戏匹配系统
>
> 其中游戏系统需要你实现match的client端，匹配系统需要实现game的server端、data的client端，至于数据存储不需要是自己实现
>
> ```mermaid
> flowchart LR
> 游戏系统:AcTerminal-->|add_user|匹配系统:AcTerminal
> 游戏系统:AcTerminal-->|remove_user|匹配系统:AcTerminal-->|save_data|数据存储:Myserver:9090
> ```
>
> 例2：线上oj
>
> ```mermaid
> flowchart LR
> OJ-->评测机-->OJ
> ```
>
> 总结来说：**thrift就是用于实现解耦合框架和微服务框架的，就是为了远程调用不同服务器服务的一个工具**，形象一点，thrift就是上面流程图中的有向边。









