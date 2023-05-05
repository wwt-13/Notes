

[toc]

# Mac终端配置

> 记录自己的Mac终端配置，之后更换Mac电脑是就不需要再从头开始配置一遍了。

## 配置命令行高亮

> 执行如下三条指令即可（安装zsh插件）
>
> ```shell
> git clone https://github.com/zsh-users/zsh-syntax-highlighting.git 
> echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
> source .zshrc
> ```

## 配置code命令

> 在Mac上配置终端使用`code`打开vscode
>
> *<font color="orange">Tip:</font>需要预先安装vscode*

1. `cmd+shift+p`打开vscode搜索框
2. 输入shell，选择“在Path安装code命令”
3. 安装成功

![CleanShot 2022-08-09 at 10.14.37](/Users/wwt13/Documents/Notes/assets/CleanShot 2022-08-09 at 10.14.37.gif)

## 配置代理

> 与浏览器不同，**mac** 的终端默认并没有开启代理模式，也就是说即使我们电脑安装了 **SS**/**V2ray** 等代理客户端，在终端中也是无法科学上网的。下面通过样例演示如何对终端配置网络代理。
>
> *<font color="green">Ps:</font>本人使用的代理软件是==ClashX==*

### 确认代理状态

> 首先可以使用`curl`命令查看终端目前的IP状态（可以看到目前终端使用的还是国内的IP地址）
>
> ```shell
> curl ipinfo.io
> ```

![image-20220719161730009](/Users/wwt13/Documents/Notes/assets/image-20220719161730009.png)

### 配置

1. 确定代理客户端的端口号

    ![image-20220719160742141](/Users/wwt13/Documents/Notes/assets/image-20220719160742141.png)

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

    ![image-20220719161945676](/Users/wwt13/Documents/Notes/assets/image-20220719161945676.png)

## 配置.vimrc

>   配置命令行文本编辑器vim的使用
>
>   *<font color="green">Ps:</font>比较简单，直接复制粘贴配置文件即可*
>
>   *<font color="red">Attention:</font>.vimrc中的注释符号比较特殊，是”*

```shell
" 设置行号
set nu
" 设置鼠标使用
set mouse=a
" 突出显示当前行
set cursorline
" 设置语法高亮
syntax on
" 设置tab缩进+对齐
set tabstop=4
set shiftwidth=4
set autoindent
" 设置高亮匹配
set hlsearch
" 设置括号匹配
set showmatch
" 设置括号自动补齐
inoremap ' ''<ESC>i
inoremap " ""<ESC>i
inoremap ( ()<ESC>i
inoremap [ []<ESC>i
inoremap < <><ESC>i
inoremap { {<CR>}<ESC>o
```

## 配置.tmux.conf

>   Mac终端没有预先安装tmux，所以想要安装tmux需要预先安装homebrew，并通过homebrew来进行tmux的安装。
>
>   *<font color="orange">Tip:</font>homebrew的安装方式具体见<a href="./Mac-homebrew安装使用.md">Mac-homebrew安装使用</a>*

```shell
# 设置tmux下使用鼠标
set -g mouse on
```

### tmux下的复制问题

>   ==macOS系统下需要使用按住fn+`cmd+c`可以进行选择复制。==
>
>   *<font color="green">Ps:</font>这个技巧找了很多地方都没找到，没想到最后还是在csdn上发现的——https://blog.csdn.net/weixin_39591916/article/details/111625160* 

