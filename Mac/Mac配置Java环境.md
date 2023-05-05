[toc]

# Mac配置Java环境

>   本文将介绍Mac环境下配置Java环境的

## 下载

>   和Python不同，在Java官网下载JDK版本速度及其感人，还是建议换源或者直接在国内第三方网站[^injdk]下载。
>
>   [^injdk]:https://www.injdk.cn/

分别下载两个LTS版本，*OracleJDK的JDK17*和*Zulu的JDK8*

*<font color="green">Ps:</font>JDK17支持几乎所有Java新特性并且为LTS版本（当然是选Oracle官方的arm64版本），而Zulu的JDK8则是因为市面上的软件大部分还是根据Java8的语法构建的，而各种Java镜像分支又只有Zulu配备了arm64版本的Java8（m1芯片可以原生运行）*

![CleanShot 2022-08-09 at 20.06.18](/Users/wwt13/Documents/Notes/assets/CleanShot 2022-08-09 at 20.06.18.png)

![CleanShot 2022-08-09 at 20.10.43](/Users/wwt13/Documents/Notes/assets/CleanShot 2022-08-09 at 20.10.43.png)

## 配置

>   *<font color="orange">Tip:</font>查看当前电脑安装的所有jdk版本命令——`/usr/libexec/java_home -V`*

