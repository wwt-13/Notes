# Makefile

## Why Learn Makefile？

- Linux下C/C++编程makefile应用广泛
- 编译移植开源项目，大部分开源项目都基于makefile，学会写makefile才能调试编译过程中的各种问题
- 手写makefile过于繁琐，自动生成的makefile又不容易配置，所以需要学习如何**构建自动化makefile**，以后每写一个项目只需要includemakefile头文件即可
- 学习makefile可以理解

```shell
# Main makefile
#
# Copyright (C) 2007 Beihang University
# Written by Zhu Like ( zlike@cse.buaa.edu.cn )
#

drivers_dir	  := drivers
boot_dir	  := boot
init_dir	  := init
lib_dir		  := lib
tools_dir	  := tools
test_dir	  := 
# 上面定义了各种文件夹名称
vmlinux_elf	  := gxemul/vmlinux
# 上面这个是最终需要生成的elf文件路径
link_script   := $(tools_dir)/scse0_3.lds #链接用的脚本

modules		  := boot drivers init lib
objects		  := $(boot_dir)/start.o			  \
				 $(init_dir)/main.o			  \
				 $(init_dir)/init.o			  \
			   	 $(drivers_dir)/gxconsole/console.o \
				 $(lib_dir)/*.o				  \
# 定义了一些变量
# 定义了需要生成的各种文件

.PHONY: all $(modules) clean # 无视时间约束

all: $(modules) vmlinux # 我们的“最终目标”

vmlinux: $(modules)
	$(LD) -o $(vmlinux_elf) -N -T $(link_script) $(objects)

##注意,这里调用了一个叫做$(LD)的程序

$(modules): 
	$(MAKE) --directory=$@

#进入各个子文件夹进行make

clean: 
	for d in $(modules);	\
		do					\
			$(MAKE) --directory=$$d clean; \
		done; \
	rm -rf *.o *~ $(vmlinux_elf)

include include.mk # 引用include.mk文件
```

```shell
# Common includes in Makefile
#
# Copyright (C) 2007 Beihang University
# Written By Zhu Like ( zlike@cse.buaa.edu.cn )


CROSS_COMPILE := /OSLAB/compiler/usr/bin/mips_4KC-ld
CC  := $(CROSS_COMPILE)gcc # 交叉编译
CFLAGS  := -O -G 0 -mno-abicalls -fno-builtin -Wa,-xgot -Wall -fPIC -Werror
LD  := $(CROSS_COMPILE)ld # 定义LD变量
```

