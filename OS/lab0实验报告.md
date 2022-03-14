[toc]

# lab0实验报告

## Thinking 0.1

- ***在/home/20xxxxxx/learnGit目录下创建一个名为README.txt的文件。这时使用 git status > Untracked.txt*** 

  ![](https://gitee.com/ababa-317/image/raw/master/images/20220314133108.png)

  此时显示`nothing added to commit but untracked files present`

  表示仓库下有文件被创建，但是还未被跟踪，此时可以使用git add指令将新创建的文件添加到暂存区中

- ***在 README.txt 文件中随便写点什么，然后使用刚刚学到的 add 命令，再使用 git status > Stage.txt 。***

  ![](https://gitee.com/ababa-317/image/raw/master/images/20220314133358.png)

  此时显示`changes to be committed`，代表暂存区中有修改等待被提交，此时可以使用`git rm --cached <file>`来撤销暂存区中的文件（注意该指令不会回退工作区的内容，如果要将工作区的内容同时回退可以使用指令`git restore --staged filename`）

- ***之后使用上面学到的 Git 提交有关的知识把 README.txt 提交，并在提交说明里写入自己的学号。***

  没啥好说的，简单的git提交

- ***使用 cat Untracked.txt 和 cat Stage.txt，对比一下两次的结果，体会一下README.txt 两次所处位置的不同。***

  一次位于工作区，一次提交到了暂存区

- ***修改 README.txt 文件，再使用 git status > Modified.txt 。***

- ***使用 cat Modified.txt ，观察它和第一次 add 之前的 status 一样吗，思考一 下为什么？ (对于Thinking 0.1，只有这一小问需要写到课后的实验报告中)***

  ![](https://gitee.com/ababa-317/image/raw/master/images/20220314133959.png)

  很明显不一样，因为此时工作区中的文件和暂存区中不一致，所以会显示modified，此时git给出了两种选择，一种是使用git add，将修改后的文件提交到暂存区，第二种是使用git resotre撤销工作区的修改（实际上是使用暂存区中的文件覆盖工作区中的内容，如果暂存区中不存在该文件，则使用版本区文件覆盖工作区文件。）

## Thinking 0.2

- ***仔细看看这张图，思考一下箭头中的 add the file、stage the file 和 commit 分别对应的是 Git 里的哪些命令呢？***

  add the file：git add filename

  stage the file：git add filename（很迷惑？？）

  commit：git commit filename

## Thinking 0.3

- ***深夜，小明在做操作系统实验。困意一阵阵袭来，小明睡倒在了键盘上。等到小明早上醒来的时候，他惊恐地发现，他把一个重要的代码文件printf.c删除掉了。苦恼的小明向你求助，你该怎样帮他把代码文件恢复呢？***

  1. git restore printf.c

  2. git reflog 查看往期版本

     git reset --hard <版本号> 回退到printf.c存在的版本好

  3. 如果代码文件没有add也没有commit，那就只能**寄希望于该文件的进程还存在**

     下面以`deletefile.txt`为例

     ```shell
     rm deletefile.txt -f
     ls # 此时目录下以及不存在了test.txt文件
     ```

     使用lsof指令查看文件进程

     ```shell
     lsof | grep deletefile.txt
     ```

     如果运气好的话可以看见被删除文件的进程如下

     ```shell
     [root@docking ~]# lsof | grep deletefile
     cat       21796          root    1w      REG              253,1        63     138860 /root/deletefile.txt (deleted)
     ```

     在自己的电脑上试了一下，发现进程直接被删了，所以这种方法可以恢复文件的**概率很小**

     ![image-20220314140017661](C:\Users\86188\AppData\Roaming\Typora\typora-user-images\image-20220314140017661.png)

     此时可以使用`cp /proc/pid/fd/1 指定目录/文件名`进行恢复

- ***正在小明苦恼的时候，小红主动请缨帮小明解决问题。小红很爽快地在键盘上敲下了git rm printf.c，这下事情更复杂了，现在你又该如何处理才能弥补小红的过错呢？***

  见上面的分析，就不再写一遍了emmmmm

- ***处理完代码文件，你正打算去找小明说他的文件已经恢复了，但突然发现小明的仓库里有一个叫Tucao.txt，你好奇地打开一看，发现是吐槽操作系统实验的，且该文件已经被添加到暂存区了，面对这样的情况，你该如何设置才能使Tucao.txt在不从工作区删除的情况下不会被git commit指令提交到版本库？***

  使用`git restore --staged filename`或者`git rm --cached filename`都可以实现上述操作

## Thinking 0.4

- ***找到我们在/home/20xxxxxx/learnGit下刚刚创建的README.txt，没有的话就新建一个。***
- ***在文件里加入Testing 1，add，commit，提交说明写 1。***
- ***模仿上述做法，把1分别改为 2 和 3，再提交两次。***
- ***使用 git log命令查看一下提交日志，看是否已经有三次提交了？记下提交说明为 3 的哈希值[\*1\*](https://os.buaa.edu.cn/courses/course-v1:BUAA+B3I062270+2022_SPRING/courseware/153317b39af949f8b9df1c555d922732/cee76ce058174e4e8e1889e6bd7a233b/?child=first#fn1)。***
- ***开动时光机！使用 git reset --hard HEAD`^` ，现在再使用git log，看看什么没了？***
- ***找到提交说明为1的哈希值，使用 git reset --hard <Hash-code> ，再使用git log，看看什么没了？***
- ***现在我们已经回到过去了，为了再次回到未来，使用 git reset --hard <Hash-code> ，再使用git log，我胡汉三又回来了！***
- ***这一部分在课后的思考题中简单写一写你的理解即可，毕竟能够进行版本的恢复是使用git很重要的一个原因。***

> 这里直接放出我之前学习Linux时记录的git笔记+版本回滚的流程示意图
>
> ```mermaid
> flowchart TB
> moudle1.0--upgrade-->moudle2.0
> moudle1.0--run-->B{Accept!}
> moudle2.0--run-->A{Error!}
> A-.-git-.->moudle1.0
> ```

1. `git reset --hard HEAD^`或者`git reset --hard HEAD~`：将版本库向上回滚一个版本，但是注意不会将版本的内容删除（可以理解为只是指针的移动），此时工作区被修改

   - `git reset --hard HEAD^^`：向上回滚两次，以此类推

   - `git reset --hard HEAD~100`：往上回滚100个版本

   - `git reset --hard 版本号`：可以回退到任意版本，版本号可以通过`git reflog`查看

     ![](https://gitee.com/ababa-317/image/raw/master/images/20220308001247.png)

2. `git reflog`：查看HEAD指针的**移动历史**（包括被回滚的版本）

## Thinking 0.5

**思考下面四个描述，你觉得哪些正确，哪些错误，请给出你参考的资料或实验证据。**

1. ***克隆时所有分支均被克隆，但只有HEAD指向的分支被检出。***

   正确

2. ***克隆出的工作区中执行 git log、git status、git checkout、git commit等操作不会去访问远程版本库。***

   正确

3. ***克隆时只有远程版本库HEAD指向的分支被克隆。***

   错误

4. ***克隆后工作区的默认分支处于master分支。***

   正确

> 以上所有例子均已[project_test](https://git.acwing.com/a_little_buaaer/project_test)为例（我在gitLab上创建的远程仓库）
>
> ![](https://gitee.com/ababa-317/image/raw/master/images/20220314141338.png)
>
> 此时可见远程仓库处有**三个分支**

----

**实验开始**

首先在本地分别创建dev文件夹和master文件夹，**分别用于clone远程仓库HEAD位于dev和master的情况**

1. clone master分支位于的仓库

   ![](https://gitee.com/ababa-317/image/raw/master/images/20220314143756.png)

   使用git branch查看当前的所有分支，就目前为止的情况来看，貌似克隆master对应的分支（之后该结论被推翻）
   
2. 使用git checkout dev

   ![](https://gitee.com/ababa-317/image/raw/master/images/20220314144110.png)

   发现仓库创建了一个dev分支，并且该分支下的内容和远程分支dev中的完全一致，但是此时还不能证明远程分支是在第一次clone的时候被clone的，有没有可能是checkout dev的时候从云端传输的呢？这些问题还需要进一步验证。
   
3. 重做操作1，并且断网后进行操作2

   ![](https://gitee.com/ababa-317/image/raw/master/images/20220314144646.png)

   发现和操作2的现象完全一致！！！

   至此，可以验证**问题1**、**问题2**、**问题4**均正确，**问题3**错误

## Thinking 0.6

```shell
执行如下命令,并查看结果
	echo first
	echo second > output.txt
	echo third > output.txt
	echo forth >> output.txt
```

> 重定向的应用，>代表覆盖重定向，会将指令的stdout重定向到后方文件，>>代表末尾添加重定向，和>的区别就和C中写文件的w和wa相同

## Thinking 0.7

使用你知道的方法（包括重定向）创建下图内容的文件（文件命名为test），将创建该文件的命令序列保存在command文件中，并将test文件作为批处理文件运行，将运行结果输出至result文件中。给出command文件和result文件的内容，并对最后的结果进行解释说明（可以从test文件的内容入手）. 具体实现的过程中思考下列问题: echo echo Shell Start 与 echo `echo Shell Start'效果是否有区别; echo echo \$c>file1 与 echo `echo \$c>file1'效果是否有区别.

有区别，此处同样放上之前学shell命令记得笔记

**关于单引号和双引号的区别**

- 单引号中的内容会**原样输出**，**不会执行**，**不会取变量**
- 双引号中的内容会==执行==，可以==取变量==

