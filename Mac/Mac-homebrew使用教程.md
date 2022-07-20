# Mac-homebrew使用教程

> 开个坑，学习学习Mac上最强的应用程序套件下载工具——homebrew

## 基础命令介绍

![image-20220719165054045](/Users/apple/Documents/Notes/assets/image-20220719165054045.png)

## 问题解决

> 记录使用homebrew过程中出现的各种问题的解决方案

### Error: Command failed with exit 128: git

> brew -v 查看会有两个提示，提示用户设置 `homebrew-cask` 和 `homebrew-core` 的文件路径为设置为safe.directory， 即使用如下命名进行设置即可
>
> *<font color="green">Ps:</font>貌似是因为homebrew的软件版本都是通过git来管理的，但是不设置为`safe.directory`的话git无法识别该目录（？不是特别清楚）*

```shell
git config --global --add safe.directory /usr/local/Homebrew/Library/Taps/homebrew/homebrew-core
git config --global --add safe.directory /usr/local/Homebrew/Library/Taps/homebrew/homebrew-cask
```

### Error: No such file or directory @ rb_sysopen

> ![image-20220720154445313](/Users/apple/Documents/Notes/assets/image-20220720154445313.png)
>
> 该问题的产生一般是软件下载的某个依赖包下载不成功，这里*直接单独下载依赖包再重新安装软件即可*
>
> ```shell
> brew install ca-certificates
> brew install tmux
> ```

