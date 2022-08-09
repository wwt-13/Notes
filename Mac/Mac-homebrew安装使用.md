# Mac-homebrew使用教程

> 开个坑，学习学习Mac上最强的应用程序套件下载工具——homebrew
>
> Homebrew 是macOS 的套件管理工具，是高效下载软件的一种方法，相当于Linux 下的 yum 、 apt-get 神器，用于下载存在依赖关系的软件包。 通俗地说，Homebrew 是类似于Mac App Store 的一个软件商店。
>
> *<font color="red">Attention:</font>一般来说，homebrew用于安装非图形软件，当然也可以使用「homebrew cask」来专门安装非图形软件*
>
> *<font color="green">Ps:</font>Homebrew 会将软件包安装到独立目录，并将其文件软链接至 /usr/local。说起来好像有点难懂，简单说就是，Homebrew 会将安装的软件包统一进行管理，不必担心其存储位置等，安装好之后用就对了。*

## homebrew安装

```shell
# 安装指令如下
# intel mac
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
# m1 mac
arch -x86_64 ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install)" < /dev/null 2> /dev/null
```

出现问题：`curl: (7) Failed to connect to raw.githubusercontent.com port 443 after 2264 ms: Connection refused`

Google后发现是mac终端默认不会默认开启代理模式的问题，所以需要修改终端配置文件使终端开启代理模式——<a href="../Mac/Mac终端配置代理.md">Mac终端配置代理</a>

开启代理模式后再次执行上述指令

再次出现问题：`curl: (35) LibreSSL SSL_connect: SSL_ERROR_SYSCALL in connection to raw.githubusercontent.com:443 `

淦，新版mac OS系统提升了系统安全性，直接*禁用了远程脚本*。。。。

**解决方案**

- 从浏览器手动下载远程脚本到本地，再执行.（过于繁琐😅）

- 切换为国内镜像源（也不理解为啥国内就不会被禁用？）

    ```shell
    /bin/zsh -c "$(curl -fsSL https://gitee.com/cunkai/HomebrewCN/raw/master/Homebrew.sh)"
    ```

![image-20220719164238172](/Users/wwt13/Documents/Notes/assets/image-20220719164238172.png)

## 问题解决

> 记录使用homebrew过程中出现的各种问题的解决方案

### Error: Command failed with exit 128: git

> brew -v 查看会有两个提示，提示用户设置 `homebrew-cask` 和 `homebrew-core` 的文件路径为设置为safe.directory， 即使用如下命名进行设置即可（具体指令根据`brew -v`显示的为准）
>
> *<font color="green">Ps:</font>貌似是因为homebrew的软件版本都是通过git来管理的，但是不设置为`safe.directory`的话git无法识别该目录（？不是特别清楚）*

```shell
git config --global --add safe.directory /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core
git config --global --add safe.directory /usr/local/Homebrew/Library/Taps/homebrew/homebrew-cask
```

### Error: No such file or directory @ rb_sysopen

> ![image-20220720154445313](/Users/wwt13/Documents/Notes/assets/image-20220720154445313.png)
>
> 该问题的产生一般是软件下载的某个依赖包下载不成功，这里*直接单独下载依赖包再重新安装软件即可*
>
> ```shell
> brew install ca-certificates
> brew install tmux
> ```

## 基础命令介绍

|        NAME        |         VALUE         |
| :----------------: | :-------------------: |
|      安装软件      |  `brew install name`  |
|      卸载软件      | `brew uninstall name` |
|    查看软件信息    |   `brew info name`    |
| 查看已经安装的软件 |      `brew list`      |
|                    |                       |
|                    |                       |
