# Lab2-extra 易错点记录+简要分析

> 上机没写出来，今天花了不少时间复盘了一下，这里简单记录下其中比较易错的几个点(后面有代码参考)

## 易错点

1. 注意`swap_init`中为 insert_head，所以最终 list 内的顺序是**反的**

    ```c
    /* 第一次分配结束(指分配16个页面)，pa与va的一一对应如下所示
    0 0x390f000 0x1000000
    1 0x390e000 0x1001000
    2 0x390d000 0x1002000
    ......
    ......
    15 0x3900000 0x100f000
    */
    ```

2. **注意位运算的结合顺序！！**`从右往左`

    ```c
    perm = ((u_long)(*pt) & 0xfff) | PTE_SWP & ~PTE_V;// Wrong
    perm = PTE_SWP | ((u_long)(*pt) & 0xfff) & ~PTE_V;// Right
    ```

3. 在对页表项进行置换标记(_标记所有映射到 ppn 的 va 为“已被置换到外存”_)的时候，其中填写的外存页号最好是其**物理页号**(符合页表性质，当然填虚拟页号也行，就是别忘了`swap`中会多一步转化)

4. 一定要注意`pgdir_walk`和`page_lookup`的使用区别！！(本题中涉及到的点是`page_lookup`会对`ppte`进行**PTE_V**的校验)

## 简要分析

**_来梳理一下各个函数之间的调用关系(以下面的 swap_test_self 为例)_**

```c
static void swap_test_self()
{
	u_long va;
	struct Page *pp;
	struct Page *p = NULL;
	assert(page_alloc(&p) == 0);
	cur_pgdir = (Pde *)page2kva(p);

	for (int i = 0; i < SWAP_NPAGE; i++)
	{
		va = TEST_VA_START + i * BY2PG;
		pp = swap_alloc(cur_pgdir, 0);
		assert(pp != NULL);
		assert(page_insert(cur_pgdir, 0, pp, va, PTE_D) == 0);
		strcpy(kuseg(va), s[i]);
	}

    // 在内存满(指可交换内存满)的情况下，建立va到pa的映射
	va = TEST_VA_START + 16 * BY2PG; // va = 0x1010000
	pp = swap_alloc(cur_pgdir, 0);
	assert(pp != NULL);
	assert(page_insert(cur_pgdir, 0, pp, va, PTE_D) == 0);
	strcpy(kuseg(va), s[16]);

	// pgdir_walk简化版,把注释删了可用于debug
	// Pte *entry=(Pte*)KADDR(PTE_ADDR((*(cur_pgdir+PDX(va)))))+PTX(va);
	// printk("entry=%x ppn=%x sign=%x\n",entry,(u_long)(*entry)>>12,(u_long)(*entry) & 0xfff);

	for (int i = 0; i < 16; i++)
	{
		u_long va = TEST_VA_START + i * BY2PG;
		ensure(strcmp(kuseg(va), s[i]) == 0, "Content[%d] Wrong!", i);
	}
}
```

1. `cur_pgdir = (Pde *)page2kva(p);`创建了页目录

2. `for(int i = 0; i < SWAP_NPAGE; i++){...}`

    - `pp = swap_alloc(cur_pgdir, 0);`分配了一个交换区*0x3900000~0x3910000*中的物理页面与 va 建立映射，由于此时`page_free_swapable_list`还存在空闲的 pages,所以不需要进行置换，直接分配即可
    - `assert(page_insert(cur_pgdir, 0, pp, va, PTE_D) == 0);`建立 pa~va 的映射，此时页表项的符号位为*(\*ppte)&0xfff=0x600=PTE_D|PTE_V*
    - `strcpy(kuseg(va), s[i]);`将 s[i]中的内容拷贝到 va 虚拟地址上，<u>其中`kuseg`这个函数中进行了“换入”操作</u>（刚开始做的时候找了好久愣是没找到换入是在哪调用的）

    如此重复 16 次，刚好将交换区的所有物理页面与 TEST_VA_START 开始的 16 个虚拟页面建立了映射，具体映射如下所示 👇🏻

    | index | pa        | va        |
    | ----- | --------- | --------- |
    | 0     | 0x390f000 | 0x1000000 |
    | 1     | 0x390e000 | 0x1001000 |
    | 2     | 0x390d000 | 0x1002000 |
    | …     | …         | …         |
    | 15    | 0x3900000 | 0x100f000 |

3. 此时在交换区物理页面均被分配的情况下，再次尝试建立某块 pa 到 va 的映射，这时就需要用到内存交换的技术

    1. `va = TEST_VA_START + 16 * BY2PG;` 此时 **va = 0x1010000**

    2. `pp = swap_alloc(cur_pgdir, 0);`，下面贴出`swap_alloc`的关键代码

        ```c
        if (LIST_EMPTY(&page_free_swapable_list))
        {
            da = disk_alloc();
            p = swap_strategy();
            swap_clean(pgdir, asid, PPN(page2pa(p)), (u_long)(PADDR(da)) / BY2PG);
            memcpy(da, page2kva(p), BY2PG);
            LIST_INSERT_HEAD(&page_free_swapable_list, p, pp_link);
        }
        ```

        - `da = disk_alloc();`分配一个未使用的外存页面，返回*外存页面的虚拟地址*

        - `p = swap_strategy();`选择被置换页面的策略，这里可以**偷个懒，每次都直接选择第一个页作为置换页**(因为评测时并不考虑置换算法的效率问题)，并且这样还方便了 debug

            也就是说此时 va 对应的 pa 就是*0x3900000*，因此根据之前的映射关系 👆🏻 可得被置换出去的页面原先对应的 va 就是*post_va=0x100f000*

            ```c
            struct Page *swap_strategy() // 偷懒直接分配首个页面,方便debug
            {
            	return pa2page(SWAP_PAGE_BASE);
            }
            ```

        - `swap_clean(pgdir, asid, PPN(page2pa(p)), (u_long)(PADDR(da)) / BY2PG);`这里用到的就是 Lab2-exam 中实现的`page_perm_stat`函数了，目的是*标记所有映射到 ppn 的 va 为“已被置换到外存”*，这里贴一下关键代码以供参考

            此时的页表项的符号位为`0x408`

            ```c
            if (PPN(*pt) == ppn)
            {
                // 反向运算获取va
                va = (u_long)(p - pgdir) << 22 | (u_long)(pt - pgtable) << 12;
                // 原始(u_long)(*pte)&0xfff=0x600,为PTE_D|PTE_V,合理
                // 被位运算给狠狠的坑了一把,一定要注意从右往左的结合顺序哼哼哼啊啊啊啊
                perm = PTE_SWP | ((u_long)(*pt) & 0xfff) & ~PTE_V;
                *pt = (dpn << 12) | perm;
                tlb_invalidate(asid, va);
                continue;
            }
            ```

        - `memcpy(da, page2kva(p), BY2PG);`拷贝被置换的物理页面内容到外存

        - `LIST_INSERT_HEAD(&page_free_swapable_list, p, pp_link);`将 p 页面重新变为*可置换的*（注意是*可置换的*而不是*未映射的*）

    3. `assert(page_insert(cur_pgdir, 0, pp, va, PTE_D) == 0);`建立 pa 到 va 的映射，此时的二级页表中，post_va 和 va 对应的*页表项*如下所示 👇🏻(二者在在二级页表上正好相邻)

        | ENTRY             | PPN(31-12)                                                          | SIGN(11-0) |
        | ----------------- | ------------------------------------------------------------------- | ---------- |
        | post_va=0x100f000 | pysical addres of `swap_disk`=??(记不清楚了,反正是内核栈上的一个值) | 0x408      |
        | cur_va=0x1010000  | pysical address of pp=0x39000                                       | 0x600      |

    4. `strcpy(kuseg(va), s[16]);`将 s[i]中的内容拷贝到虚拟地址 va 上(va=0x1010000)

        kuseg 函数内调用了`swap_lookup()`函数，**实现了将外存内容换入内存中**

        ```c
        static inline void *kuseg(u_long va)
        {
        	Pte pte = swap_lookup(cur_pgdir, 0, va);
            // 该部分省略不看
        	return (void *)va;
        }
        ```

        最后看一下`swap_lookup()`中的`swap()`函数

        ```c
        Pte swap_lookup(Pde *pgdir, u_int asid, u_long va)
        {
        	if (is_swapped(pgdir, va))
        	{
        		// printk("该虚拟地址%x对应的物理页面已被置换到外存上\n", va);
        		swap(pgdir, asid, va);
        	}
        	Pte *ppte;
        	page_lookup(pgdir, va, &ppte);
        	return ppte == NULL ? 0 : *ppte;
        }
        ```

        第一步调用`is_swapped(pgdir,va)`判断，va 对应的物理页面是否“已被置换到外存”，如果是的话，调用`swap`函数将 va 对应的物理页面换入，否则直接`page_lookup`获取页表项返回

        _如果将这里的 pgdir_walk 换成 page_lookup 会又什么问题？_(**思考上面给出的页表项 sign 和 page_lookup 的实现代码**)

        ```c
        // 还是直接看代码orz
        static void swap(Pde *pgdir, u_int asid, u_long va)
        {
        	Pte *ppte;
        	u_char *da;
        	u_long perm;
            // 分配一个物理页面用于换入
        	struct Page *p = swap_alloc(pgdir, asid);
        	// 查找va对应的二级页表项(注意page_lookup和pgdir_walk的区别)
        	pgdir_walk(pgdir, va, 0, &ppte);
        	// 获取外存页面对应的虚拟地址
        	da = KADDR(PTE_ADDR(*ppte));
        	// 拷贝内容到p上
        	memcpy((u_char *)(page2kva(p)), da, BY2PG);
        	// 释放外存内容
        	disk_free(da);
        	// 最后更新页表项即可
        	perm = ~PTE_SWP & ((u_long)(*ppte) & 0xfff) | PTE_V;
        	*ppte = PTE_ADDR((u_long)(page2pa(p))) | perm;
        	tlb_invalidate(pgdir, va);
        }
        ```

其实从整体上来看，Lab2-extra 的实现思路其实并不复杂，主要考察的还是对于 Lab2 中用到的宏、函数是否足够熟悉（但是感觉上机那点时间要理清确实来不及，主要是没有课下 vscode 辣么方面好用的函数跳转 🥲）
