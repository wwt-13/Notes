[toc]

# Alfred

>   Mac聚焦搜索增强工具，具备强大的Workflow，**解决了输入输出的痛点，极大的减少了程序之间的切换成本和重复按键成本**，并且界面相比utools更加美观，可以在[macwk](https://macwk.com/)上下载破解版
>
>   *<font color="green">Ps:</font>个人设定快速唤起alfred的快捷键`cmd doubleClick`*

## Why Use Alfred？

>   使用一个简单的小例子来说明，比方说翻译一个单词的意思。

正常步骤

1.   复制单词
2.   打开浏览器/翻译软件
3.   打开Google翻译/到软件首页选择搜索框
4.   粘贴单词，得到查询结果

利用Alfred的Workflow

1.   复制单词
2.   粘贴单词得到结果

<u>甚至Workflow还能设置快捷键使得查询效率更高</u>

![alfred-youdao](http://louiszhai.github.io/docImages/alfred/alfred-youdao.png)

----

## 偏好面板介绍

1.  General（通用，用于设置是否开机启动，及设置唤起快捷键，通常设置为 `cmd+cmd` 即可）
2.  Workflows（工作流）
3.  Appearance（外观，用于设置 alfred 输入窗口的外观、字体、颜色等）
4.  Advanced（高级）
5.  Remote（远程，用于远程管理，这意味着你需要在 App Store 购买一个 Alfred Remote 的app，然后便可以在手机上远程操作 mac）
6.  Powerpack（许可证，购买 powerpack 的用户便可以使用 workflow 功能）
7.  Usage（使用统计）
8.  Help（帮助，提供快速上手文档、使用文档、反馈bug、用户论坛等链接）
9.  Update（更新日志，可查看更新日志及更新到最新版）

Appearance 面板除了设置输入窗口的外观外，还有一些外观相关的设置，在这里可以设置默认展示行数等。

![img](/Users/wwt13/Documents/Notes/assets/alfred-appearance-options.png)

Advanced 面板包含了一些高级设置，如下所示。

![img](/Users/wwt13/Documents/Notes/assets/alfred-advanced.png)

Usage 面板包含了你使用 alfred 的数据统计，如下所示。

![img](/Users/wwt13/Documents/Notes/assets/alfred-usage.png)

*<font color="brown">Quote:</font>以上内容引用自http://louiszhai.github.io/2018/05/31/alfred/#14-%E7%B3%BB%E7%BB%9F%E5%B8%B8%E7%94%A8%E5%91%BD%E4%BB%A4%E5%BF%AB%E6%8D%B7%E6%93%8D%E4%BD%9C*

## What Can Alfred Do？

>   -   默认具备的功能
>       1.  应用搜索、文件或目录搜索、文本内容搜索、标记搜索、快捷网页搜索、书签搜索、通讯录搜索、剪切板搜索、代码片段搜索、密码搜索
>       2.  计算器
>       3.  翻译
>       4.  iTunes管理
>       5.  系统常用命令快捷操作
>       6.  直接唤起指定终端并执行命令
>
>   -   获得powerpack license的alfred具备的workflow功能
>
>       >   目前市面已知的Workflow已经超过500+，[官方Workflow下载](https://www.alfredapp.com/workflows/)

### 应用搜索

>   类似Mac自带聚焦搜索功能，可以列出本地安装的所有相关应用，*支持前缀打开*(回车即可直接打开)
>
>   ![CleanShot 2022-08-07 at 11.09.40](/Users/wwt13/Documents/Notes/assets/CleanShot 2022-08-07 at 11.09.40.png)

### 文件/目录搜索

>   输入 find 或 open 命令，以及待搜索的文件或目录名，列出磁盘中的相关文件（open就是直接打开）
>
>   ![CleanShot 2022-08-07 at 11.09.27](/Users/wwt13/Documents/Notes/assets/CleanShot 2022-08-07 at 11.09.27.png)

### 文本内容搜索

>   输入 in 命令，以及待搜索的文本，列出磁盘中包含该文本的相关文件，可以快速定位文件，相当于*简易的终端 find 命令*
>
>   *<font color="green">Ps:</font>以上的文件以及文件内容搜索都可以在偏好中设置搜索范围*
>
>   ![CleanShot 2022-08-07 at 11.09.11](/Users/wwt13/Documents/Notes/assets/CleanShot 2022-08-07 at 11.09.11.png)

### 标签搜索

>   `tags+标签名`即可针对标签进行搜索，不过只适用于标签很多的情况，一般来说这个功能没啥用

### 快捷网页搜索

>   可以通过alfred快速打开对应网页进行搜索，也可以自定义相关网页搜索指令（*缺点是搜索结果无法直接显示在alfred中*）
>
>   具体使用参考：**alfred preferences 面板— features 栏— web search**
>
>   ![CleanShot 2022-08-07 at 11.33.17](/Users/wwt13/Documents/Notes/assets/CleanShot 2022-08-07 at 11.33.17.png)

### 书签搜索

>   意义不大，有那搜索的时间还不如直接打开浏览器书签查找（不建议开启该功能）
>
>   ![CleanShot 2022-08-07 at 11.37.04](/Users/wwt13/Documents/Notes/assets/CleanShot 2022-08-07 at 11.37.04.png)

### 计算器

>   alfred提供基础的计算功能和复杂计算功能（添加前缀`=`即可触发）
>
>   *默认计算*
>
>   ![CleanShot 2022-08-07 at 11.40.16](/Users/wwt13/Documents/Notes/assets/CleanShot 2022-08-07 at 11.40.16.png)
>
>   **复杂计算**
>
>   ![CleanShot 2022-08-07 at 11.41.01](/Users/wwt13/Documents/Notes/assets/CleanShot 2022-08-07 at 11.41.01.png)

### 词典搜索&代码片段搜索&密码管理&iTunes管理&联系人管理&剪切板搜索

>   这些功能都不建议使用，它们要么鸡肋（对于我而言），要么在Workflow上有更方便的替代。
>
>   alfred自带的词典搜索功能并不是很理想（推荐使用workflow），*建议关闭*。
>
>   ![CleanShot 2022-08-07 at 11.44.36](/Users/wwt13/Documents/Notes/assets/CleanShot 2022-08-07 at 11.44.36.png)
>
>   剪切板搜索，目前已经有了更好用的剪切板工具`Paste`替换，具体使用方法见<a href="./Readme.md">Readme.md</a>
>
>   其余的几个也同上，都不建议启用。

### 系统常用命令快捷键

>   通过 alfred 可以快捷地操作系统锁屏、关机、重启、休眠等十几种指令，非常便捷。对于强迫症用户来说，唤起屏保、休眠、清空垃圾篓、退出应用等指令可能较为常用。
>
>   ![alfred-system](/Users/wwt13/Documents/Notes/assets/alfred-system.png)

### 唤起终端并执行命令

>   通过alfred可以直接*唤起终端窗口，并执行相应指令*（如果只是**稍微使用**一下终端的话可以采用该方法）

![CleanShot 2022-08-07 at 16.12.22](/Users/wwt13/Documents/Notes/assets/CleanShot 2022-08-07 at 16.12.22.png)

![CleanShot 2022-08-07 at 16.17.40](/Users/wwt13/Documents/Notes/assets/CleanShot 2022-08-07 at 16.17.40.gif)

## Snippets

>   又是一个非常实用的功能，类似于“代码片段”汇总的功能，这里你可以自定义或者倒入他人定义好的各种代码模板（[官网Snippet合集](https://www.alfredapp.com/extras/snippets/)），该代码模板采用`prefix+keyword`的形式运作，可以为文字工作者节省下大量工作。

比方说你需要经常输入`Hello,XXX,how do you do?`这句话，就可以设置*prefix*为`tmp`，*keyword*为`hel`，content为你想说的话，那么此时直接输入`tmp+hel`就会自动替换为你想说的话了

<video src="/Users/wwt13/Documents/Notes/assets/CleanShot 2022-08-07 at 15.41.14.mp4"></video>

*<font color="green">Ps:</font>由于目前使用alfred的时间还短，所以还并没有自定义自用的Snippet*

## Workflow

>   ***最为重量级的部分来啦！Alfred中最最牛逼的Workflow***
>
>   *==<font color="purple">Warning:由于还没系统学习过php，所以这块内容只能暂时闲置</font>==*

