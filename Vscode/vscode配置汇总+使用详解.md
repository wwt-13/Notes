[toc]

# vscode配置汇总+使用详解

## Intro

> 2020.7.9时，未知原因导致了我的windows电脑上的vscode配置崩溃（并且通过github恢复后又出现了无法下载插件的问题），所以便萌生了使用笔记的形式记录vscode所有配置的想法。
>
> 记录内容包括但不限于*用户配置*、*工作区配置*、*快捷键设置*、*用户代码片段*、==插件==、==settings.json==等。
>
> 该配置内容需要和插件`Settings Sync`配合使用，达成多平台同步的效果并且防止配置丢失

## 杂记

1. 注意要开启自动保存功能

   <img src="/Users/apple/Documents/Notes/assets/image-20220711205101507.png" alt="image-20220711205101507" style="zoom:100%;" />

## 插件

> 简单的插件只介绍基本用途即可，较复杂的插件需要描述具体使用方法

|          插件名          |                             logo                             |                           用途                           |
| :----------------------: | :----------------------------------------------------------: | :------------------------------------------------------: |
|  Chinese（Simplified）   | ![截屏2022-07-11 19.48.59](/Users/wwt13/Documents/Notes/assets/截屏2022-07-11 19.48.59.png) |                           汉化                           |
|       Live Server        | ![image-20220711203202823](/Users/wwt13/Documents/Notes/assets/image-20220711203202823.png) |                     前端网页实时渲染                     |
|   Material Icon Theme    | ![image-20220711205837277](/Users/wwt13/Documents/Notes/assets/image-20220711205837277.png) |                      美化vscode图标                      |
|      Material Theme      | ![image-20220711205919351](/Users/wwt13/Documents/Notes/assets/image-20220711205919351.png) |                      vscode主题插件                      |
| Prettier-Code Formatter  | ![image-20220711224227640](/Users/wwt13/Documents/Notes/assets/image-20220711224227640.png) |                        格式化插件                        |
| Bracket Pair Colorizer 2 | ![image-20220711230923276](/Users/wwt13/Documents/Notes/assets/image-20220711230923276.png) |            括号匹配插件（目前vs code已内置）             |
|     Auto Rename Tag      | ![image-20220711231312663](/Users/wwt13/Documents/Notes/assets/image-20220711231312663.png) |                  自动重命名匹配标签插件                  |
|         CSS Peek         | ![image-20220711231813716](/Users/wwt13/Documents/Notes/assets/image-20220711231813716.png) | css样式预览+样式跳转插件（出现未跳转的话重启vscode即可） |
|      Settings Sync       | ![image-20220711234020248](/Users/wwt13/Documents/Notes/assets/image-20220711234020248.png) |     配置同步插件（对vscode自带的同步不放心所以选择）     |
|     Better Comments      | ![image-20220719100712684](/Users/wwt13/Documents/Notes/assets/image-20220719100712684.png) |                       注释拓展插件                       |
|       Code Runner        | ![image-20220719165956802](/Users/wwt13/Documents/Notes/assets/image-20220719165956802.png) |             用于在vscode上直接执行代码的插件             |

### Prettier

> 下面讲讲Prettier插件需要进行的额外设置
>
> ~~*<font color="red">Attention:</font>7.12下午使用发现出现bug，所以弃用，该用vscode内置格式化插件*~~

1. 设置*文件保存时自动格式化*

   ![image-20220711224825978](/Users/wwt13/Documents/Notes/assets/image-20220711224825978.png)

2. 将Prettier设置为默认格式化插件（需要设置`settings.json`，这里推荐直接修改用户区配置文件）

   ![vscode-Prettier插件配置](/Users/wwt13/Documents/Notes/assets/vscode-Prettier插件配置-7551611.gif)

3. 修改Prettier中的默认制表符

   ![image-20220711230239773](/Users/wwt13/Documents/Notes/assets/image-20220711230239773.png)

### Bracket Pair Colorizer 2

> 目前vscode已内置，只需要在设置处微调即可

![image-20220711231137105](/Users/wwt13/Documents/Notes/assets/image-20220711231137105.png)

### Better Comments

> 暂时有四种使用方式（其余使用支持自定义）
>
> - *代表需要强调的说明内容
> - ！代表不推荐使用的方法
> - ？代表疑问
> - TODO代表该代码将来需要改进的地方

![better-comments](https://github.com/aaron-bond/better-comments/raw/HEAD/images/better-comments.PNG)

### Code Runner

> 使用教程见<a href="./vscode配置c&c++运行环境.md">vscode配置c&c++运行环境</a>

## 用户代码片段

> ~~不知为何，我的html文件始终无法使用`!`来快速生成模版文件（可能是Mac版的vscode有bug？），所以必须配置个人拥护代码片段。~~
>
> **上述bug在vscode的最近更新中已经修复**
>
> ![image-20220712151801629](/Users/wwt13/Documents/Notes/assets/image-20220712151801629.png)

### HTML

>   虽然Emmet的bug已经修复了，但是html的模板代码还是暂时保存了下来。

```json
{
    // Place your snippets for html here. Each snippet is defined under a snippet name and has a prefix, body and
    // description. The prefix is what is used to trigger the snippet and the body will be expanded and inserted. Possible variables are:
    // $1, $2 for tab stops, $0 for the final cursor position, and ${1:label}, ${2:another} for placeholders. Placeholders with the
    // same ids are connected.
    // Example:
    // "Print to console": {
    // 	"prefix": "log",
    // 	"body": [
    // 		"console.log('$1');",
    // 		"$2"
    // 	],
    // 	"description": "Log output to console"
    // }
    "html template": {
        "prefix": "index",
        "body": [
            "<!DOCTYPE html>",
            "<html lang=\"en\">",
            "\t<head>",
            "\t\t<meta charset=\"utf-8\" />",
            "\t\t<meta name=\"viewpoint\" content=\"width=device-width, initial-scale=1\" />",
            "\t\t<meta name=\"robots\" content=\"index,follow\" />",
            "\t\t<meta name=\"description\" content=\"\" />",
            "\t\t<meta name=\"author\" content=\"wwt-13\">",
            "\t\t<title></title>",
            "\t</head>",
            "\t<body></body>",
            "</html>"
        ],
        "description": "html模版代码"
    }
}
```



## 快捷键

|        功能         |           快捷键           |                           效果演示                           |
| :-----------------: | :------------------------: | :----------------------------------------------------------: |
|       块注释        |       `cmd+option+/`       |                              -                               |
|       行注释        |          `cmd+/`           |                              -                               |
| 折叠/释放所有块注释 |       `cmd+k cmd+l`        | ![CleanShot 2022-09-09 at 14.27.07](/Users/wwt13/Documents/Notes/assets/CleanShot 2022-09-09 at 14.27.07.gif) |
|                     |                            |                                                              |
|      打开终端       |        `control+~`         |                              -                               |
|    打开设置界面     |          `cmd+,`           |                              -                               |
|      搜索设置       |       `cmd+shift+p`        |                              -                               |
|                     |                            |                                                              |
|       删除行        |       `cmd+shift+k`        |                              -                               |
|       移动行        |        `option+↑/↓`        | ![CleanShot 2022-09-09 at 14.29.50](/Users/wwt13/Documents/Notes/assets/CleanShot 2022-09-09 at 14.29.50.gif) |
|      另起一行       |        `cmd+enter`         | ![vscode另起一行](/Users/wwt13/Documents/Notes/assets/vscode另起一行.gif) |
|  向下复制一行代码   |      `shift+option+↓`      | ![vscode向下复制行](/Users/wwt13/Documents/Notes/assets/vscode向下复制行.gif) |
|                     |                            |                                                              |
|  向后选择相同代码   |          `cmd+d`           | ![vscode向后选择相同代码](/Users/wwt13/Documents/Notes/assets/vscode向后选择相同代码.gif) |
|     全选匹配项      |       `cmd+shift+l`        | ![vscode全选匹配项](/Users/wwt13/Documents/Notes/assets/vscode全选匹配项.gif) |
|                     |                            |                                                              |
|      移动光标       |       `cmd+option+↓`       | ![vscode移动光标](/Users/wwt13/Documents/Notes/assets/vscode移动光标.gif) |
|                     |                            |                                                              |
|   长代码自动换行    |         `option+z`         | ![vscode长代码自动换行](/Users/wwt13/Documents/Notes/assets/vscode长代码自动换行.gif) |
|                     |                            |                                                              |
|    生成随机文字     | `lorem(+数字：生成字符数)` | ![vscode生成随机文本](/Users/wwt13/Documents/Notes/assets/vscode生成随机文本.gif) |

## Terminal Settings

> vscode终端配置（暂时不使用zsh）

## Emmet



### Settings Sync

> ==配置同步插件==，及其重要‼️

具体配置过程见教程吧

## settings.json

