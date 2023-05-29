# Lab6

- 学号：20373914
- 姓名：吴文韬
- Lab：6

## Thinking 6.1

> 示例代码中，父进程操作管道的写端，子进程操作管道的读端。如果现在想让父进程作为“读者”，代码应当如何修改？

把原来fd[]数组的0、1互换即可,read,write操作互换即可

```c
#include <stdlib.h>

#include <unistd.h>

int fildes[2];

/* buf size is 100 */

char buf[100];

int status;

int main()
{

    status = pipe(fildes);

    if (status == -1)
    {

        /* an error occurred */

        printf("error\n");
    }

    switch (fork())
    {

    case -1: /* Handle error */

        break;

    case 0: /* Child - reads from pipe */

        close(fildes[0]); /* Read end is unused */

        write(fildes[1], "Hello world\n", 12); /* Write data on pipe */

        printf("child-process Write:%s", buf); /* Print the data */

        close(fildes[1]); /* Finished with pipe */

        exit(EXIT_SUCCESS);

    default: /* Parent - writes to pipe */

        close(fildes[1]); /* Write end is unused */

        read(fildes[0], buf, 100); /* Read data from pipe */

        close(fildes[0]); /* Child will see EOF */

        exit(EXIT_SUCCESS);
    }
}
```

## Thinking 6.2

> 上面这种不同步修改 pp_ref 而导致的进程竞争问题在 user/lib/fd.c 中 的 dup 函数中也存在。请结合代码模仿上述情景，分析一下我们的 dup 函数中为什么会出现预想之外的情况？

假设父子进程，有一对管道`p[2]`，其中父进程关闭`p[0]`完毕，准备测试`ispipeclosed(p[1])`。子进程`dup(p[1])`刚dup完毕fd，还没开始dup Pipe结构体。

此时`p[1]`引用数为3，`p[0]`引用数为1，Pipe结构体所在页因为被map到父进程的`p[0]`和子进程的`p[0]`、`p[1]`的fdData处，引用数也为3，此时pageref(wfd) = pageref(pipe)父进程的`ispipeclosed(p[1])`就会被误判为true。

## Thinking 6.3

> 阅读上述材料并思考：为什么系统调用一定是原子操作呢？如果你觉得不是所有的系统调用都是原子操作，请给出反例。希望能结合相关代码进行分析说明。

 所有的系统调用都是原子操作。用户进程执行syscall后到操作系统完成操作返回的过程中，不会有其他程序执行。系统调用开始时，操作系统就会关闭中断（syscall.S中的CLI指令）。因此系统调用不会被打断。对于`sys_ipc_recv`，应理解为设置进程进入recv状态，这个设置过程不会被打断，因而也是原子操作

## Thinking 6.4

> 仔细阅读上面这段话，并思考下列问题
>
> - 按照上述说法控制 **pipe_close** 中 fd 和 pipe unmap 的顺序，是否可以解决上述场景的进程竞争问题？给出你的分析过程。
> - 我们只分析了 close 时的情形，在 fd.c 中有一个 dup 函数，用于复制文件内容。试想，如果要复制的是一个管道，那么是否会出现与 close 类似的问题？请模仿上述材料写写你的理解

1. 可以，因为原情况出现的原因是：a, b二值, $a > b$当先减少a再减少b时，就可能会出现$a == b$的中间态。改变顺序后b先减少 $a > b > b$ 不会出现这种状态
2. dup是类似的，只不过情况变成了先增加b再增加a，改变顺序之后先增加a再增加b，也就不会有这种情况发生

## Thinking 6.5

> 思考以下三个问题。
>
> - 认真回看 Lab5 文件系统相关代码，弄清打开文件的过程。
> - 回顾 Lab1 与 Lab3，思考如何读取并加载 ELF 文件
> - 在 Lab1 中我们介绍了 data text bss 段及它们的含义，data 段存放初始化过的全局变量，bss 段存放未初始化的全局变量。关于 memsize 和 filesize ，我们在 Note1.3.4中也解释了它们的含义与特点。关于 Note 1.3.4，注意其中关于“bss 段并不在文件中占数据”表述的含义。回顾 Lab3 并思考：elf_load_seg() 和 load_icode_mapper()函数是如何确保加载 ELF 文件时，bss 段数据被正确加载进虚拟内存空间。bss 段 在 ELF 中并不占空间，但 ELF 加载进内存后，bss 段的数据占据了空间，并且初始值都是 0。请回顾 elf_load_seg() 和 load_icode_mapper() 的实现，思考这一点是如何实现的？
>
> 下面给出一些对于上述问题的提示，以便大家更好地把握加载内核进程和加载用户进程的区别与联系，类比完成 spawn 函数
>
> 关于第一个问题，在 Lab3 中我们创建进程，并且通过 ENV_CREATE(...) 在内核态加载了初始进程，而我们的 spawn 函数则是通过和文件系统交互，取得文件描述块，进而找到 ELF 在“硬盘”中的位置，进而读取。
>
> 关于第二个问题，各位已经在 Lab3 中填写了 load_icode 函数，实现了 ELF 可执行文件中读取数据并加载到内存空间，其中通过调用 elf_load_seg 函数来加载各个程序段。在 Lab3 中我们要填写 load_icode_mapper 回调函数，在内核态下加载 ELF 数据到内存空间；相应地，在 Lab6 中 spawn 函数也需要在用户态下使用系统调用为 ELF 数据分配空间。 



## Thinking 6.6

> 通过阅读代码空白段的注释我们知道，将文件复制给标准输入或输出，需要我们将其 dup 到 0 或 1 号文件描述符 (fd)。那么问题来了：在哪步，0 和 1 被“安排”为标准输入和标准输出？请分析代码执行流程，给出答案。

```c
if ((r = opencons()) != 0) {
    user_panic("opencons: %d", r);
}
// stdout
if ((r = dup(0, 1)) < 0) {
    user_panic("dup: %d", r);
}
```

## Thinking 6.7

> 在 shell 中执行的命令分为内置命令和外部命令。在执行内置命令时 shell 不需要 fork 一个子 shell，如 Linux 系统中的 cd 命令。在执行外部命令时 shell 需要 fork一个子 shell，然后子 shell 去执行这条命令。
>
> 据此判断，在 MOS 中我们用到的 shell 命令是内置命令还是外部命令？请思考为什么Linux 的 cd 命令是内部命令而不是外部命令？

MOS中用到的shell命令是外部命令

在 Linux 中，cd 命令为内置命令而不是外部命令，这是为了避免在子进程中改变父进程的工作目录，造成不必要的麻烦。如果将 cd 命令实现为外部命令，则在执行 cd 命令时会在子进程中改变子进程的工作目录，而不会影响父进程的工作目录。这样就需要特殊的处理方式才能将子进程中的工作目录传递给父进程，或者通过其他手段实现和父进程共享工作目录

## Thinking 6.8

> 在你的 shell 中输入命令 ls.b | cat.b > motd。 
>
> - 请问你可以在你的 shell 中观察到几次 spawn ？分别对应哪个进程？
> - 请问你可以在你的 shell 中观察到几次进程销毁？分别对应哪个进程？