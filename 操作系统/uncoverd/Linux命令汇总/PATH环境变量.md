[toc]

# PATH环境变量

> *什么是PATH环境变量？*
>
> 从命令行想要运行一个程序的时候，待运行的程序往往不是在当前目录。
>
> `PATH环境变量`的意义就是用于保存可以用于搜索的目录路径，如果如果待运行的程序不在当前目录，操作系统便可以去依次搜索`PATH变量`变量中记录的目录，如果在这些目录中找到待运行的程序，操作系统便可以运行。

## 修改PATH变量

>   可以通过linux下的export命令设置或者显示环境变量。
>
>   *<font color="green">Ps:</font>可以通过`echo $PATH`来查看目前设置的所有环境变量*
>
>   *<font color="orange">Tip:</font>建议和`sed`指令结合来优化输出方式*
>
>   ```shell
>   echo $PATH | sed 's/:/\n/g'
>   # 将:分隔符替换为换行符
>   ```

 *建议修改方式（Mac下修改.zshrc）*

![CleanShot 2022-08-10 at 15.53.30](/Users/wwt13/Documents/Notes/assets/CleanShot 2022-08-10 at 15.53.30.png)

1.   设置变量
2.   通过export指令将变量导入为环境变量
3.   最后修改PATH环境变量

*<font color="red">Attention:</font>以上修改形式因为是在用户目录下的.zshrc修改的，所以终端配置文件（各种环境变量设置啥的）会在每次打开终端时生效*

