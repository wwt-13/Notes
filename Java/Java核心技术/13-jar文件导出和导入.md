[toc]



# jar文件导出和导入

> 可以帮助解决将很多class文件打包到其他机器运行的问题

## jar文件

> 本质上和C++文件的DLL文件极其类似

- jar文件，是Java所特有的一种文件格式，用于可执行程序文件的传播
- jar文件实际上是一组class文件的压缩包
- 项目引入一个.jar文件，就可以使用.jar文件中的所有类（.class文件），而无需类的源码（.java文件）

**jar文件的优势**

- jar文件可以包括多个class，比多层目录更加简洁实用
- jar文件经过压缩后只有一个文件，在网络下载和传播方面，更具有优势
- jar文件只包括class，而没有包含java文件，在**保护源文件知识版权**方面，能够起到更好的作用
- 将多个class文件压缩成jar文件（只有一个文件），可以规定给一个版本号，更容易进行版本控制

<u>关于java知识产权的保护</u>

> jar文件还不够安全，因为存在着从.class文件到.java文件的反编译器，但是针对的也存在混淆.class文件的混淆器

但是导出jar包对于IDEA来说不是很友好貌似.......
