# OSI Model

> Open Systems Interconnection Basic Reference Model
>
> OSI 是一个 reference model,也就是说在开发系统的是后，OSI 只是作为一个参考来进行开发，并不需要 100%的遵守

| Layer                   | Function                                                                                                                                                   | Example                  |
| ----------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------ |
| Application(7)-应用层   | Services that are used with end user applications                                                                                                          | SMTP                     |
| Presentation(6)-表现层  | Formats the data so that it can be viewed by the user Encrypt and decrypt(把数据转换为能与接受者的系统格式兼容并适合传输的格式,还有负责对数据进行加密解密) | JPG,GIF,HTTPS,SSL,TLS    |
| Session(5)-会话层       | Establishes/ends connections between two hosts(负责在数据传输中设置和维护计算机网络中两台计算机之间的通信连接)                                             | NetBIOS,PPIP             |
| Transport(4)-传输层     | Responsible for the transport protocol and error handling                                                                                                  | TCP,UDP                  |
| Network(3)-网络层       | Reads the IP address from the packet(负责路由寻址 ip)                                                                                                      | Routers,Layer 3 Switches |
| Data Link(2)-数据链路层 | Read the MAC address from the data packet                                                                                                                  | Switches                 |
| Physical(1)-物理层      | Send data on to the physical wire                                                                                                                          | Hubs,NICS,Cable          |
