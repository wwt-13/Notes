# Lab4

- 学号：20373914
- 姓名：吴文韬
- Lab：4

## Thinking 4.1

- 内核在保存现场的时候是如何避免破坏通用寄存器的？

  使用堆栈空间保存寄存器的值，如下所示

  ```assembly
  .macro SAVE_ALL
  .set noreorder
  .set noat
  	/* 保存栈指针sp到k0中 */
  	move    k0, sp
  .set reorder
  	/* 如果sp<0(最高位=1),则代表发生了“异常重入”，需要跳转到异常处理程序1f */ 
  	bltz    sp, 1f
  	/* 设置sp指针为KSTACKTOP=0x8040 0000,sp指向异常栈顶 */
  	li      sp, KSTACKTOP
  .set noreorder
  1:
  	/* TF_SIZE = 38 * 4 byte
  	 * KSTACKTOP --- 0x80400000
  	 * 40 CP0_EPC
  	 * 39
  	 * 38
  	 * 37
  	 * 36 CP0_CAUSE
  	 * 35 CP0_BADVADDR
  	 * 34 LO
  	 * 33 HI
  	 * 32 CP0_STATUS
  	 * 31 $31
  	 * 30 $30
  	 * 29 sp 保存之前的栈指针
  	 * 28 $28
  	 * 27 $27
  	 * 26 $26
  	 * 25 $25
  	 * 24 $24
  	 * 23 $23
  	 * 22 $22
  	 * 21 $21
  	 * 20 $20
  	 * 19 $19
  	 * 18 $18
  	 * 17 $17
  	 * 16 $16
  	 * 15 $15
  	 * 14 $14
  	 * 13 $13
  	 * 12 $12
  	 * 11 $11
  	 * 10 $10
  	 * 9 $9 
  	 * 8 $8
  	 * 7 $7 $a3
  	 * 6 $6 $a2
  	 * 5 $5 $a1
  	 * 4 $4 $a0
  	 * 3 $3 $v1
  	 * 2 $2 $v0
  	 * 1 $1 $at
  	 * 0 $0  <-- sp(sp指向的就是trapframe结构体的起始位置(NB))
  	 * */
  	subu    sp, sp, TF_SIZE
  	sw      k0, TF_REG29(sp)
  	mfc0    k0, CP0_STATUS
  	sw      k0, TF_STATUS(sp)
  	mfc0    k0, CP0_CAUSE
  	sw      k0, TF_CAUSE(sp)
  	mfc0    k0, CP0_EPC
  	sw      k0, TF_EPC(sp)
  	mfc0    k0, CP0_BADVADDR
  	sw      k0, TF_BADVADDR(sp)
  	mfhi    k0
  	sw      k0, TF_HI(sp)
  	mflo    k0
  	sw      k0, TF_LO(sp)
  	sw      $0, TF_REG0(sp)
  	sw      $1, TF_REG1(sp)
  	sw      $2, TF_REG2(sp)
  	sw      $3, TF_REG3(sp)
  	sw      $4, TF_REG4(sp)
  	sw      $5, TF_REG5(sp)
  	sw      $6, TF_REG6(sp)
  	sw      $7, TF_REG7(sp)
  	sw      $8, TF_REG8(sp)
  	sw      $9, TF_REG9(sp)
  	sw      $10, TF_REG10(sp)
  	sw      $11, TF_REG11(sp)
  	sw      $12, TF_REG12(sp)
  	sw      $13, TF_REG13(sp)
  	sw      $14, TF_REG14(sp)
  	sw      $15, TF_REG15(sp)
  	sw      $16, TF_REG16(sp)
  	sw      $17, TF_REG17(sp)
  	sw      $18, TF_REG18(sp)
  	sw      $19, TF_REG19(sp)
  	sw      $20, TF_REG20(sp)
  	sw      $21, TF_REG21(sp)
  	sw      $22, TF_REG22(sp)
  	sw      $23, TF_REG23(sp)
  	sw      $24, TF_REG24(sp)
  	sw      $25, TF_REG25(sp)
  	sw      $26, TF_REG26(sp)
  	sw      $27, TF_REG27(sp)
  	sw      $28, TF_REG28(sp)
  	sw      $30, TF_REG30(sp)
  	sw      $31, TF_REG31(sp)
  ```

- 系统陷入内核调用后可以直接从当时的 $a0-a3$ 参数寄存器中得到用户调用 msyscall留下的信息吗?

  可以，在`kern/syscall_all.c/do_syscall`函数中，msyscall的前四个参数被保存在了$a0-a3$

- 我们是怎么做到让 sys 开头的函数“认为”我们提供了和用户调用 msyscall 时同样的参数的？

  同上一题，`do_syscall`起到了传递用户保存在`Trapframe`中的参数的作用。

  ```c
  u_int arg1 = tf->regs[5];
  u_int arg2 = tf->regs[6];
  u_int arg3 = tf->regs[7];
  ```

- 内核处理系统调用的过程对 Trapframe 做了哪些更改？这种修改对应的用户态的变化是什么？

  *修改了epc的值*，使其指向下一条指令

  ```c
  tf->cp0_epc += 4;
  ```

## Thinking 4.2

- 思考 envid2env 函数: 为什么 envid2env 中需要判断 e->env_id!= envid的情况？如果没有这步判断会发生什么情况？

  *确保找到的是目标进程的PCB*，如果不加以判断，可能会返回错误的PCB指针，比如可能存在恶意用户通过修改PCB环境ID来访问内核漏洞的情况

## Thinking 4.3

- 思考下面的问题，并对这个问题谈谈你的理解：请回顾 kern/env.c 文件中 mkenvid() 函数的实现，该函数不会返回 0，请结合系统调用和 IPC 部分的实现与envid2env() 函数的行为进行解释。 

  每次计算出来的结果都至少会左移一位，因此不可能等于 0，因此，给定一个有效的 envs 数组和一个有效的 Env 结构体指针，mkenvid 函数总是会返回一个非零且合法的环境 ID

## Thinking 4.4

关于 fork 函数的两个返回值，下面说法正确的是：

- fork 在父进程中被调用两次，产生两个返回值
- fork 在两个进程中分别被调用一次，产生两个不同的返回值
- **fork 只在父进程中被调用了一次，在两个进程中各产生一个返回值**
- fork 只在子进程中被调用了一次，在两个进程中各产生一个返回值

## Thinking 4.5

- 我们并不应该对所有的用户空间页都使用 duppage 进行映射。那么究竟哪些用户空间页应该映射，哪些不应该呢？请结合 kern/env.c 中 env_init 函数进行的页面映射、include/mmu.h 里的内存布局图以及本章的后续描述进行思考
  - *UTOP*以上的用户空间对于用户进程来说不可改变；系统空间对于每个进程来说是相同且不可改变的，因此UTOP以上空间不用进行保护
  - *UXSTACKTOP - BY2PG*到*UXSTACKTOP*的空间是用户进程的异常栈，若进行写时复制保护可能陷入死循环，因此不能被保护
  - *USTACKTOP*到*USTACKTOP + BY2PG*的空间在空间分布图上是**Invalid memory**，用不到所以无需保护
  - 去除上述这些，需要保护的是在0与USTACKTOP之间且在父进程中有效的页面。

## Thinking 4.6

在遍历地址空间存取页表项时你需要使用到 vpd 和 vpt 这两个指针，请参考 user/include/lib.h 中的相关定义，思考并回答这几个问题：

```c
// virtual page table获取自映射页表基地址
#define vpt ((volatile Pte *)UVPT)
// virtual page directory获取自映射页目录基地址
#define vpd ((volatile Pde *)(UVPT + (PDX(UVPT) << PGSHIFT)))
```

- vpt 和 vpd 的作用是什么？怎样使用它们？

  见上面👆🏻的定义，通过`vpt[VPN]`即可访问虚拟页面对应的二级页表项，通过`vpd[VPN >> 10]`即可访问虚拟页面对应的一级页表项

- 从实现的角度谈一下为什么进程能够通过这种方式来存取自身的页表？

  因为建立了*自映射机制*，如下所示👇🏻

  ```c
  // 建立了页目录自映射,将一级页表、二级页表映射到了虚拟地址UVPT开始的4MB空间
  e->env_pgdir[PDX(UVPT)] = PADDR(e->env_pgdir) | PTE_V;
  ```

- 它们是如何体现自映射设计的？

  可以直接通过`vpt`和`vpd`对一级页表项、二级页表项进行访问，而不需要`page_walk`等复杂的函数操作

- 进程能够通过这种方式来修改自己的页表项吗？

  不行，用户进程无权限使用内核宏

## Thinking 4.7

在 do_tlb_mod 函数中，你可能注意到了一个向异常处理栈复制 Trapframe运行现场的过程，请思考并回答这几个问题:

- 这里实现了一个支持类似于“异常重入”的机制，而在什么时候会出现这种“异常重入”

  ```c
  #if !defined(LAB) || LAB >= 4
  BUILD_HANDLER mod do_tlb_mod
  #endif
  ```

- 内核为什么需要将异常的现场 Trapframe 复制到用户空间？

  如指导书所说："**MOS操作系统按照微内核的设计理念， 尽可能地将功能实现在用户空间中，其中也包括了页写入异常的处理，因此主要的处理过程是在用户态下完成的**"

  如果之前内核没有把现场的TrapFrame复制到异常处理栈，那么在这里也无法跳转到真正的异常处理函数（因为用户态无权访问）

## Thinking 4.8

在用户态处理页写入异常，相比于在内核态处理有什么优势？ 

这里应用了微内核的设计理念，具有微内核的优势即具有可扩展性，灵活性，同时具有可靠性与安全性，能够易于进行移植

## Thinking 4.9

- 为什么需要将 syscall_set_tlb_mod_entry 的调用放置在 syscall_exofork 之前？

  因为在`syscall_exofork`过程中也可能产生异常，总之，异常处理函数的指定应该越早越好。

- 如果放置在写时复制保护机制完成之后会有怎样的效果？

  写时复制时就会产生异常，但此时没有对应的异常处理机制，所以直接`panic`程序中断

## 实验难点

1. 系统调用的流程理解
2. fork函数机制的理解，尤其是写时复制机制的理解

