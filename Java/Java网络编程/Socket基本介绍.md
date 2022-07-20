# Socket基本介绍

>   1.   套接字（Socket）开发网络应用程序被广泛采用，以至于成为事实上的标准
>   2.   通信的*两端都要有Socket*，这是两台机器之间通信的端点
>   3.   网络通信其实就是Socket之间的通信
>   4.   Socket允许程序把网络连接当成一个流，数据在两个Socket之间通过IO传输
>   5.   一般主动发起通信的应用程序属客户端，等待通信请求的为服务端

![image-20220529193945546](https://wwt13-images-1305051431.cos.ap-beijing.myqcloud.com/img/image-20220529193945546.png)

基于Socket有两种编程方式

1.   *TCP编程*：可靠
2.   *UDP编程*：逻辑简单，不可靠

![image-20220529194541835](https://wwt13-images-1305051431.cos.ap-beijing.myqcloud.com/img/image-20220529194541835.png)