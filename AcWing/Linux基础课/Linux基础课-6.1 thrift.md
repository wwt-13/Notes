

[toc]

# Linux基础课-6.1 thrift

> 以做一个小项目的方式来讲解thrift，项目地址为acgit。
>
> thrift东西不如git多，但是却是Linux基础中**最难懂**的知识点，要涉及很多语言、多线程、线程加锁等知识
>
> 具体应用：AcWing网站上的Acshaber的匹配功能，以及评测机的评测功能，都需要用到thrift来实现

## thrift概论

> 写一个应用的时候，一般需要实现各种不同的服务，并且<u>不同的服务会被分配到各种不同的服务器上</u>（类似“微服务”的概念）
>
> ```mermaid
> flowchart LR
> 服务器1:游戏界面-->|调用后台的一个函数,将玩家信息传输给匹配系统|服务器2:游戏中的匹配系统
> 服务器1:游戏界面-->|调用后台的一个函数,将玩家信息从匹配系统删除|服务器2:游戏中的匹配系统-->服务器3:数据服务器
> ```
>
> 要实现上述的操作，就需要服务器1要向服务器2**远程调用**add_user和remove_user两个函数，至于thrift的功能，可以理解为==上面图中的连线==（当然这三个服务也可以部署在同一个服务器上）
>
> thrift被当作一个远程过程调用（RPC）框架来使用，是由Facebook为“大规模跨语言服务开发”而开发的
>
> **什么是RPC**：远程过程调用(Remote Procedure Call,缩写为 RPC)是一个计算机通信协议。该协议允许运行于一台计算机的程序调用另一台计算机的子程序，而程序员无需额外地为这个交互作用编程。 比如 Java RMI(远程方法调用(Remote
> Method Invocation)。能够让在某个java虚拟机上的对象像调用本地对象一样调用另一个java虚拟机中的对象上的方法)。
>
> 例1：游戏匹配系统
>
> 其中游戏系统需要你实现match的client端，匹配系统需要实现game的server端、data的client端，至于数据存储不需要是自己实现（示例在上面）
>
> 例2：线上oj
>
> ```mermaid
> flowchart LR
> OJ-->评测机-->OJ
> ```
>
> 总结来说：**thrift就是用于实现解耦合框架和微服务框架的，就是为了远程调用不同服务器服务的一个工具**，形象一点，thrift就是上面流程图中的有向边。

## thrift项目基本结构

> 数据存储方面已经实现好了，直接调用接口就行（这里都是MyServer，打成不一样是因为流程图显示不全）
>
> ```mermaid
> flowchart LR
> AcTerminal:游戏界面-->|add_user|MyServer1:游戏中的匹配系统-->|save_data|服务器3:数据服务器
> AcTerminal:游戏界面-->|remove_user|MyServer2:游戏中的匹配系统
> -->|save_data|服务器3:数据服务器
> ```
>
> 任务：
>
> 1. 实现游戏节点（match_client）、匹配节点（match_server，save_client）
> 2. 数据存储直接文件夹表示，就不使用sql了

## 基本配置

1. 创建三个文件夹
   - match_system
   - game
   - interface：用于存放各种接口



