[toc]

## Thinking

### 3.1

> 请结合 MOS 中的页目录自映射应用解释代码中 e->env_pgdir[PDX(UVPT)]=PADDR(e->env_pgdir) | PTE_V 的含义

`UVPT`的含义为 User Virtual Page Table，因此这一段需要映射到他的进程在`pgdir`中的页目录地址。所以我们在将这一段空间的虚拟地址转化为物理地址时可以很快找到对应的页目录。

根据自映射计算公式：

⻚表基地址 $PT_{base}$

⻚目录基地址 $PD_{base} = PT_{base} + (PT_{base} >> 10)$

自映射⻚目录项 $PDE_{selfmap} = PT_{base} + (PT_{base} &gt;&gt; 10) + (PT_{base} &gt;&gt; 20) = PD_{base} + (PT_{base} &gt;&gt; 20)$

对应到具体代码：

`UVPT` 是页表基地址虚拟地址 $PT_{base}$。

`PDX(UVPT)` 取到了虚拟地址的一级页表偏移量，即取到了 `UVPT` 的高 10 位，即 `UVPT >> 22`。

`e->env_pgdir` 是该进程页目录的内核虚拟地址 $PD_{base}$。

`e->env_pgdir[PDX(UVPT)]` 把数组改成指针为 `*(e->env_pgdir + PDX(UVPT) * 4)`，带入宏定义为 `*(e->env_pgdir + (UVPT >> 22) * 4)`，即为 `*(e->env_pgdir + (UVPT >> 20)`。

`e->env_pgdir[PDX(UVPT)]` 就是 $PD_{base} + (PT_{base} &gt;&gt; 20)$，按照自映射，需要在这个位置保存页目录项，所以要填上该进程页目录的物理地址，即 `e->env_cr3`。

### 3.2

> elf_load_seg 以函数指针的形式，接受外部自定义的回调函数 map_page。请你找到与之相关的 data 这一参数在此处的来源，并思考它的作用。没有这个参数可不可以？为什么？

- data是对应进程的env

- 因为`elf_load_seg`的作用是*将src开始的长度为len字节的内容拷贝到va开始的地址空间上,并建立了内存到va的地址映射(env进程下，地址空间=env->env_asid)*

  所以必须要指定映射建立到的地址空间，而这些信息就保存在env结构体中

### 3.3

> 结合 elf_load_seg 的参数和实现，考虑该函数需要处理哪些页面加载的情况。 

*BY2PG --- offset --- va*

1. 内存未对齐：va到下一个BY2PG的页面部分
2. 内存对齐：va+BY2PG-offset到va+BY2PG-offset+RoundDown(binsize)部分
3. 内存未对齐：va+BY2PG-offset+RoundDown(binsize)到va+BY2PG-offset+binsize部分
4. .bss部分：va+BY2PG-offset+binsize到va+BY2PG-offset+sgsize部分

### 3.4

> 你认为这里的 env_tf.cp0_epc 存储的是物理地址还是虚拟地址? 

个人认为应该是虚拟地址(但是放物理地址有什么区别呢？)

~~在和chatgpt进行了一番沟通后，终于理解了~~

如果存放的是物理地址，那么系统在调度进程A的时候，CPU会直接跳转到env_tf.cp0_epc中的物理地址处执行

但是由于交换技术的应用(内核会将暂时不用的程序和数据移动到辅存中)，此时该物理地址处的进程A代码段可能还未从外存调入

此时直接访问到的物理地址内容就是未知内容，所以**必须在env_tf.cp0_epc中存储虚拟地址**



### 3.5

> 试找出上述 5 个异常处理函数的具体实现位置。

1. handle_int：实现位于*kern/genex.S*

   ```assembly
   NESTED(handle_int, TF_SIZE, zero)
   	mfc0    t0, CP0_CAUSE
   	mfc0    t2, CP0_STATUS
   	and     t0, t2
   	andi    t1, t0, STATUS_IM4
   	bnez    t1, timer_irq
   	// TODO: handle other irqs
   timer_irq:
   	sw      zero, (KSEG1 | DEV_RTC_ADDRESS | DEV_RTC_INTERRUPT_ACK)
   	li      a0, 0
   	j       schedule
   END(handle_int)
   ```

2. handle_mod：同上

   ```assembly
   #if !defined(LAB) || LAB >= 4
   BUILD_HANDLER mod do_tlb_mod
   BUILD_HANDLER sys do_syscall
   #endif
   ```

3. handle_tlb：实现位于`kern/tlb_asm.S`

4. handle_sys：同handle_mod

### 3.6

> 阅读 init.c、kclock.S、env_asm.S 和 genex.S 这几个文件，并尝试说出enable_irq 和 timer_irq 中每行汇编代码的作用

```assembly
// 开启中断
LEAF(enable_irq)
	li      t0, (STATUS_CU0 | STATUS_IM4 | STATUS_IEc)
	// 将CU0|IM4|IEc位置1,用户模式+允许4号中断+开启中断
	mtc0    t0, CP0_STATUS
	// 返回caller
	jr      ra
END(enable_irq)
LEAF(kclock_init)
	li      t0, 200 // the timer interrupt frequency in Hz
	/* Exercise 3.11: Your code here. */
	// 0x15000000 + 0x0100 该地址是GXemul映射实时钟的位置
	// 写入多少代表时间中断的频率，写入200表示1分钟中断200次，写入0代表关闭中断
	sw      t0, (KSEG1 | DEV_RTC_ADDRESS | DEV_RTC_HZ)
	// 返回caller
	jr      ra
END(kclock_init)
```

### 3.7

> 阅读相关代码，思考操作系统是怎么根据时钟中断切换进程的

在我们的操作系统中，设置了一个进程就绪队列，并且给每一个进程添加了一个时间片，这个时间片起到计时的作用，一旦时间片的时间走完，则代表该进程需要执行时钟中断操作，则再将这个进程移动到就绪队列的尾端，并复原其时间片，再让就绪队列最首端的进程执行相应的时间片段，按照这种规律实现循环往复，从而做到根据时钟周期切换进程

## 实验难点

> 难点在于对于schedule函数的理解+对于Lab2中页表自映射的理解实现，还有一些汇编代码的阅读

