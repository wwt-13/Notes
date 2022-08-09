[toc]

# vscode配置c&c++运行环境

> 今天下午不想学前端，就来折腾一下vscode，也算是为了考研做做准备
>
> *<font color="green">Ps:</font>该教程是为了mac端写的*

## Download Homebrew

> 具体见<a href="/Users/wwt13/Documents/Notes/Mac/Mac-homebrew安装使用.md">Mac-homebrew安装使用</a>

## Download MinGW

> 安装好homebrew后，执行`brew install mingw-w64`即可

![image-20220719165727735](/Users/wwt13/Documents/Notes/assets/image-20220719165727735.png)

## Vscode Extension-Code Runner

> 要想在vscode上运行c&c++文件，需要安装插件Code Runner

安装好就能执行cpp文件了

## 执行

> 安装好上述所有插件、工具等后，就可以尝试执行cpp文件了

![image-20220719171209131](/Users/wwt13/Documents/Notes/assets/image-20220719171209131.png)

上图可以发现，执行问题已经解决，但是还存在一些问题。

- 二进制文件的生成：希望*有一个独立的文件夹来作为这些二进制文件的生成目录*
- 调试问题：还需要解决vscode上的c&c++文件调试问题
- 输入问题：目前输出控制台*显示为只读，无法输入*

### 无法输入问题解决

> 更改vscode用户设定`run in terminal`即可

![vscode-输入问题解决](/Users/wwt13/Documents/Notes/assets/vscode-输入问题解决.gif)

## ==配置调试、语法提示==

> 详细思路可见[官网教程](https://code.visualstudio.com/docs/cpp/config-clang-mac#_prerequisites)
>
> *<font color="green">Ps:</font>发现还是要多看看官网，少看网上各种删减版的乱七八糟的教程，官网的总是最权威、详细的*

首先需要在工作区创建`.vscode`文件夹，并在`.vscode`文件夹中创建三个文件

- `tasks.json`:compiler build settings（*编译器设置*）
- `launch.json`:debugger settings（*调试设置*）
- `c_cpp_properties.json`:compiler path and IntelliSense settings（*编译路径和代码智能提示*）

### 配置tasks.json

1. 随便创建一个`hello.cpp`文件

   ```cpp
   #include<iostream>
   int main(){
       cout<<"hello,vscode"<<endl;
       return 0;
   }
   ```

2. 选择**生成和调试活动文件**并运行，该操作会自动在`.vscode`文件夹下生成`tasks.json`文件![image-20220719195410075](/Users/wwt13/Documents/Notes/assets/image-20220719195410075.png)

   ```json
   //该文件大概长这样
   {
       "tasks": [
           {
               "type": "cppbuild",
               "label": "C/C++: clang++ 生成活动文件",
               "command": "/usr/bin/clang++",
               "args": [
                   "-fdiagnostics-color=always",
                   "-g",
                   "${file}",
                   "-o",
                   "${fileDirname}/${fileBasenameNoExtension}"
               ],
               "options": {
                   "cwd": "${fileDirname}"
               },
               "problemMatcher": [
                   "$gcc"
               ],
               "group": "build",
               "detail": "调试器生成的任务。"
           }
       ],
       "version": "2.0.0"
   }
   ```

3. 修改`tasks.json`文件

   > 详细语法讲解见<a href="./tasks.json详解.md">tasks.json详解</a>

   ```json
   {
       "version": "2.0.0",
       "tasks": [
           {
               "type": "cppbuild",
               "label": "C/C++: clang++ 生成活动文件",
               "command": "/usr/bin/clang++",
               "args": [
                   "-std=c++17",
                   "-stdlib=libc++",
                   "-g",
                   "${file}",
                   "-o",
                   "${fileDirname}/Binary/${fileBasenameNoExtension}"
               ],
               "options": {
                   "cwd": "${fileDirname}"
               },
               "problemMatcher": ["$gcc"],
               "group": {
                   "kind": "build",
                   "isDefault": true
               },
               "detail": "编译器: /usr/bin/clang++"
           }
       ]
   }
   ```

   