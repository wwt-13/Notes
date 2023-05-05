[toc]

# Xcode详解

>   部分参考于：https://medium.com/hackernoon/introduction-to-xcode-9-94205e83a985

![Map of Xcode 12 - 01](/Users/wwt13/Documents/Notes/assets/Map of Xcode 12 - 01.jpg)



## Status Bar

![CleanShot 2022-09-20 at 14.40.31](/Users/wwt13/Documents/Notes/assets/CleanShot 2022-09-20 at 14.40.31-3656131.png)

1.   打开/合上侧边栏
2.   构建/运行项目
3.   显示的是一些*git仓库*的信息，包括项目名称、项目当前版本所在分支等等
4.   项目名称
5.   *代表构建该项目运行的模拟器设备种类*
6.   显示项目构建过程中的一些信息
7.   *从库中新建一个对象*

## Navigation Pane

|     单词     |         释义          |      |
| :----------: | :-------------------: | :--: |
|    `pane`    |       *n.* 窗格       |      |
| `navigation` |       *n.* 导航       |      |
|  `delegate`  | *n.* 代表, 代表团成员 |      |

### Project Navigator

>   项目导航面板，用于显示*项目的各种源文件*
>
>   your file manager. Whatever you need to do with your files it's done here. This navigator enables you to add, remove, edit or group files. Always keep this tab in focus.

![CleanShot 2022-09-20 at 14.50.40](/Users/wwt13/Documents/Notes/assets/CleanShot 2022-09-20 at 14.50.40.png)

1.   项目说明文档
2.   可以理解为IOS app的入口（不是很理解）
3.   窗口管理？（不清楚）
4.   应用程序内部结构的基础，管理用户界面以及界面与底层数据的交互（也是不太清楚）
5.   ***App UI设计界面***
6.   项目所用图像资源集合
7.   ***App启动UI设计界面***
8.   提供应用在运行期间的一些配置（每个项目Xcode都会自动创建，非常重要，不可删除）

### Source Control Navigator

>   版本控制面板，里面是关于git的内容
>
>   A super-useful navigator meant for source control. It has an integrated support for GitHub accounts, which enables you to manage your repositories directly from your sidebar, and push changes to the cloud without having to use other tools. This is only available from Xcode 9.

### Symbol Navigator

>   This navigator will enable you to quickly jump to a specific method or a property definition**.** Instead of going through your files to find the method you are looking for, just click on the file you need and then click the desired method or property definition. Useful for files that contain lots of lines of code. You can display the symbols in a hierarchical or flat list.

### Find Navigator

>   Something that I use quite often. This makes a global search for the given text and returns results that are matching. You can also include various filters in the search.



### Issue Navigator

>   It's a place that keeps all the errors and warnings that appeared as a result of your coding. Errors are shown with a red color, while warnings are yellow. It will provide you with a detailed log of what is going on. You can display Buildtime or Runtime issues.



### Test Navigator

>   Is used for running the written test cases. This navigator is a shortcut for your [XCTest's](https://developer.apple.com/documentation/xctest).

### Debug Navigator

>   Whenever the app crashes, this tab gets automatically opened. It will provide you with exact lines where the app has stopped and provide you with a reason in the console. Also, you can find useful information about your app's Memory, CPU, Disk and Network consumption.

### Breakpoint Navigator

>   Another tab that I use a lot for debugging**.** From here, you can easily set breakpoints and monitor their activities. I really love how clean this feature is.

### Report Navigator

>   Control your continuous integration from here. You should create a bot, and it will provide you access to a detailed information about your bots and the integrations performed on the server.
>
>   *<font color="green">Ps:</font>不太理解*

 

## Document Outline

## Debug Pane

## Code Editor

## Inspector Pane

### File Inspector

>   显示文件的一些细节和设定
>
>   this inspector provides basic details and settings about the selected file. It's divided into three main sections.

#### Identity and Type

![CleanShot 2022-09-22 at 08.55.22](/Users/wwt13/Documents/Notes/assets/CleanShot 2022-09-22 at 08.55.22.png)

1.   文件名
2.   文件类型
3.   文件位置（相对位置）
4.   文件绝对路径

#### Interface Builder Document

![CleanShot 2022-09-22 at 09.09.16](/Users/wwt13/Documents/Notes/assets/CleanShot 2022-09-22 at 09.09.16.png)



1.   设置工程可用的ios版本
2.   全局颜色？

#### Target Membership

>   指该文件属于哪个工程

![CleanShot 2022-09-22 at 08.57.34](/Users/wwt13/Documents/Notes/assets/CleanShot 2022-09-22 at 08.57.34.png)

#### Text Settings

>   文件文本设置，非常少用，默认不会改动

![CleanShot 2022-09-22 at 08.57.41](/Users/wwt13/Documents/Notes/assets/CleanShot 2022-09-22 at 08.57.41.png)

### History Inspector

>   和git管理类似

### Quick Inspector

>   用于快速查阅Swift、Xcode等官方文档，非常实用

![CleanShot 2022-09-22 at 09.06.17](/Users/wwt13/Documents/Notes/assets/CleanShot 2022-09-22 at 09.06.17.png)

### Identity Inspector

>   controls the identity of the UIViewController. By identity we understand, assigning a custom class, providing a storyboard ID so you can access the view controller via code, and `User Defined Runtime Attributes` where you can add various styling properties, instead of adding them via code (example: `layer.cornerRadius`).
>
>   *<font color="green">Ps:</font>还不太理解*

### Attribute Inspector

>    this inspector is used for adjusting the properties of the selected object. Each object contains its own set of properties. For example, the `UILabel`contains settings like adjusting text, text color, font, background color etc. You can also add your own properties, by using `@IBInspectable`.

![CleanShot 2022-09-22 at 09.23.53](/Users/wwt13/Documents/Notes/assets/CleanShot 2022-09-22 at 09.23.53.png)

1.   用于说明对象内部的内容如何填充对象
1.   语义？？
1.   标签？
1.   配合？？
1.   透明度
1.   背景
1.   色彩
1.   ？？
1.   ？？

### Size Inspector

>   I think the name explains it all. Anything related to the sizing of the object can be found here. Despite the x, y, width and height values you can find the Auto Layout constraints, or Autoresizing if you aren't using Auto Layout.



## Project Settings

