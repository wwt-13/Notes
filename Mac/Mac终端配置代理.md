[toc]

# Mac终端配置代理

> 与浏览器不同，**mac** 的终端默认并没有开启代理模式，也就是说即使我们电脑安装了 **SS**/**V2ray** 等代理客户端，在终端中也是无法科学上网的。下面通过样例演示如何对终端配置网络代理。

## 确认代理状态

> 可以使用`curl`命令查看终端目前的IP状态（可以看到目前终端使用的还是国内的IP地址）
>
> ```shell
> curl ipinfo.io
> ```

![image-20220719161730009](/Users/apple/Documents/Notes/assets/image-20220719161730009.png)

## 配置

1. 确定代理客户端的端口号

   ![image-20220719160742141](/Users/apple/Documents/Notes/assets/image-20220719160742141.png)

2. 配置代理（需要根据mac OS的版本进行区分，这里的教程适用于macOS Catalina版以上的mac系统）

   > 从 **macOS Catalina** 版开始，**Mac** 将使用 **zsh** 作为默认的 **Shell** 终端。

   ```shell
   # 1.打开zsh配置文件
   vim ~/.zhsrc
   # 2.添加自定义终端快捷指令
   alias proxy='export all_proxy=socks5://127.0.0.1:7890'
   alias unproxy='unset all_proxy'
   # 3.执行指令使配置文件生效
   source ~/.zshrc
   ```

   查看终端当前IP地址可以发现，指令已生效

   ![image-20220719161945676](/Users/apple/Documents/Notes/assets/image-20220719161945676.png)