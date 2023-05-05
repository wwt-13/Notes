[toc]

# Mac配置Python环境

>   本文将介绍Mac下配置Python环境的方法

## 下载

>   到官网[^Python官网]安装对应版本的JDK，⚠️**目前只有3.9以上版本的Python原生支持m1芯片**，所以2020开始的m1版本macbook只能下载安装3.9以及以上的Python版本
>
>   *<font color="red">Attention:</font>2021版本的MacBook Pro不再自带Python2.7*
>
>   [^Python官网]: https://www.python.org/

下载对应版本的dmg文件，然后直接一路傻瓜式安装即可….

*查看安装好的Python位置/版本*

```shell
which python3
python3 --version
```

## 配置

>   默认安装后，macOS上的pip指令为pip3，所以可以在`.zshrc`配置文件中自定义指令修改为pip
>
>   ```shell
>   alias pip="pip3"
>   ```
>
>   *<font color="orange">Tip:</font>安装的Python命令同样是python3，这点如果想修改的话同理*