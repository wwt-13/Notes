## 题干

> lab0工作区的csc/code/fibo.c成功更换字段后(bash modify.sh fibo.c char int)，现已有csc/Makefile和csc/code/Makefile，补全**两个Makefile文件**，要求**在csc目录**下通过指令make可在csc/code文件夹中生成fibo.o、main.o，**在csc文件夹中**生成可执行文件fibo，再输入指令make clean后只删除两个.o文件。[注意：不能修改fibo.h和main.c文件中的内容，提交的文件中fibo.c必须是修改后正确的fibo.c，可执行文件fibo作用是从stdin输入一个整数n，可以输出斐波那契数列前n项，每一项之间用空格分开。比如n=5，输出1 1 2 3 5]

## 需要注意的点

> 这道题很明显可以通过一个Makefile文件完成，但是却偏偏要求补全两个Makefile文件，说明这道题的目的实际上是让**外层的Makefile去调用内层的Makefile**（orz这个其实我也是问助教问出来的）

1. 需要使用外层Makefile调用内层Makefile

   外层Makefile：首先`cd ./code`，再调用内层make指令（这里需要注意Makefile指令的特性，每条指令执行完后会默认回退到当前目录，<u>建议采用`&&`同时执行这两条指令</u>）

   ```shell
   fibo:
   	cd ./code
   	make fibo # 此时已经默认回退到了当前目录下,所以会出现`command make not found`
   ```

   内层Makefile：就是个正常的Makefile文件

2. 编译的时候别忘了调用include文件夹下的`fibo.h`

3. 输出可执行文件的时候要记得输出到外层的`src`文件夹下

4. 评测指令的时候只会在`csc`目录下执行`make fibo`这条指令

Plus：其余题目的题干应该不会出现歧义（至少我做的时候没发现）

