

[toc]

# Mac终端配置

> 记录自己的Mac终端配置，之后更换Mac电脑是就不需要再从头开始配置一遍了。

## Mac终端配置命令行高亮

> 执行如下三条指令即可
>
> ```shell
> git clone https://github.com/zsh-users/zsh-syntax-highlighting.git 
> echo "source ${(q-)PWD}/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" >> ${ZDOTDIR:-$HOME}/.zshrc
> source .zshrc
> ```

## Mac终端配置code

> 在Mac上配置终端使用`code`打开vscode

1. `cmd+shift+p`打开vscode搜索框
2. 输入shell，选择“在Path安装code命令”
3. 安装成功