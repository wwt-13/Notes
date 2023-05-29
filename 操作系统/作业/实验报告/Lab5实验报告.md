# Lab5

- 学号：20373914
- 姓名：吴文韬
- Lab：5

## Thinking 5.1

> 如果通过 kseg0 读写设备，那么对于设备的写入会缓存到 Cache 中。这是一种错误的行为，在实际编写代码的时候这么做会引发不可预知的问题。请思考：这么做这会引发什么问题？对于不同种类的设备（如我们提到的串口设备和 IDE 磁盘）的操作会有差异吗？可以从缓存的性质和缓存更新的策略来考虑。

因为内核被放在`kseg0`区域，该区域需要通过cache访问；如果对设备的写入缓存到cache中，就会导致以后想访问内核时却错误访问了写入设备的内容，导致访问错误。

对于不同设备的操作有差异，例如串口设备读写比IDE频繁，发生读写错误的概率更高

## Thinking 5.2

> 查找代码中的相关定义，试回答一个磁盘块中最多能存储多少个文件控制块？一个目录下最多能有多少个文件？我们的文件系统支持的单个文件最大为多大？

文件控制块大小256B，磁盘块4KB，故最多16个控制块

目录4096KB，一个文件控制块256B，故最多`4096KB/256B = 16384`个文件；

十个直接指针指向的磁盘块一共40KB，间接指针最多`1024-10 = 1014 `个，间接指针的磁盘块大小`1014*4KB = 4056KB`,总共`4056KB+40KB = 4096KB`，所以文件系统支持的单个文件最大为4096KB

## Thinking 5.3

> 请思考，在满足磁盘块缓存的设计的前提下，我们实验使用的内核支持的最大磁盘大小是多少？

文件系统服务是一个用户进程，一个进程可以拥有4G 的虚拟内存空间，将DISKMAP 到DISKMAP+DISKMAX 这一段虚存地址空间(0x10000000-0x4ffffff) 作为缓冲区，当磁盘读入内存时，用来映射相关的页。由此可见，为了满足块缓存的设计，我们实验使用的内核支持的最大磁盘大小是`0x40000000 = 1GB`

## Thinking 5.4

> 在本实验中，fs/serv.h、user/include/fs.h 等文件中出现了许多宏定义，试列举你认为较为重要的宏定义，同时进行解释，并描述其主要应用之处。 

```c
// 一些需要理解的宏
#define BY2BLK BY2PG							// 一个块的大小正好是一页4096Byte
#define BIT2BLK (BY2BLK * 8)					// 这里算的是BLK的bit，所以自然是*8
#define BY2FILE 256								// 一个file结构体的大小 256Byte
#define NBLOCK 1024								// 一个disk里面有1024块
#define FILE2BLK (BY2BLK / sizeof(struct File)) // 一个块里面有多少个file结构体
// 需要重点理解的文件控制块结构体
struct File
{
	u_char f_name[MAXNAMELEN]; // filename 件名的最大长度 MAXNAMELEN 值为 128
	u_int f_size;			   // file size in bytes
	u_int f_type;			   // file type为文件类型，有普通文件 (FTYPE_REG) 和文件夹 (FTYPE_DIR) 两种。
	u_int f_direct[NDIRECT];   // f_direct[NDIRECT] 为文件的直接指针，每个文件控制块设有 10 个直接指针，用来记录文件的数据块在磁盘上的位置。
	// 每个磁盘块的大小为 4KB，也就是说，这十个直接指针能够表示最大 40KB 的文件，而当文件的大小大于 40KB 时，就需要用到间接指针。
	u_int f_indirect; // f_indirect指向一个间接磁盘块，用来存储许多指针，这些指针指向文件内容的磁盘块。有点像二重指针？指针指向存储指针的磁盘块，这些指针才真正指向文件内容磁盘块。

	struct File *f_dir; // f_dir指向文件所属的文件目录
	u_char f_pad[BY2FILE - MAXNAMELEN - 4 - 4 - NDIRECT * 4 - 4 - 4];
	// f_pad则是为了让整数个文件结构体占用一个磁盘块，填充结构体中剩下的字节。
};
```

## Thinking 5.5

> 在 Lab4“系统调用与 fork”的实验中我们实现了极为重要的 fork 函数。那么 fork 前后的父子进程是否会共享文件描述符和定位指针呢？请在完成上述练习的基础上编写一个程序进行验证

在磁盘上挂载一个文件lab5_test，具体程序代码见👇🏻

```c
#include "lib.h"
  void umain()
{
    int a = 0;
    int id = 0;
    int fd;
    if((fd = open("/lab5_test",O_RDWR))<0){
        user_panic("open /lab5_test :%d",fd);
    }
    writef("father write fd : %d\n",fd);
    char  buf[30]="I want to write1";
    char buf2[30] = "I want to write2";
    write(fd,buf,30);
    write(fd,buf2,30);
    if((id = fork()) == 0){// son
        char sonbuf[30];
        writef("son read fd : %d\n",fd);
        read(fd,sonbuf,30);
        writef("son read %s\n",sonbuf);
    }
    return ;
}
```

## Thinking 5.6

> 请解释 File, Fd, Filefd 结构体及其各个域的作用。比如各个结构体会在哪些过程中被使用，是否对应磁盘上的物理实体还是单纯的内存数据等。说明形式自定，要求简洁明了，可大致勾勒出文件系统数据结构与物理实体的对应关系与设计框架

```c
// file descriptor
struct Fd
{
    u_int fd_dev_id; // 外设id
    u_int fd_offset; // 读或写的当前位置
    u_int fd_omode;  // 打开方式
};
// file descriptor + file
struct Filefd
{
    struct Fd f_fd;     // 记录了文件描述符
    u_int f_fileid;     // 记录了文件的id
    struct File f_file; // 文件控制块
};

struct Open
{
    struct File *o_file; // 指向了对应的文件控制块
    u_int o_fileid;      // 表示文件id用于在数组opentab中查找对应的Open
    int o_mode;          // 记录文件打开的状态
    struct Filefd *o_ff; // 指向对应的Filefd结构体
};
```



## Thinking 5.7

> 图5.7中有多种不同形式的箭头，请解释这些不同箭头的差别，并思考我们的操作系统是如何实现对应类型的进程间通信的。

- 同步消息：**用黑三角箭头搭配黑实线表示**
- 返回消息，用黑三角箭头搭配黑色虚线表示

用户程序在发出文件系统操作请求时，将请求的内容放在对应的结构体（fsreq）中进行消息的传递，fs_serv 进程收到其他进行的IPC 请求后，IPC 传递的消息包含了请求的类型（定义在include/fs.h中）和其他必要的参数，根据请求的类型执行相应的文件操作（文件的增、删、改、查等），将结果重新通过IPC 反馈给用户程序 

![image-20230523200151494](/Users/wwt13/Documents/Notes/assets/image-20230523200151494.png)

## 实验难点

> 实验中出现了多个结构体和需要理解记忆的宏，还需要了解镜像制作工具、关于设备的系统调用、文件系统服务进程、文件操作库函数等等





