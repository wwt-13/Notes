[toc]

# vscode配置汇总

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
|  Chinese（Simplified）   | ![截屏2022-07-11 19.48.59](/Users/apple/Documents/Notes/assets/截屏2022-07-11 19.48.59.png) |                           汉化                           |
|       Live Server        | ![image-20220711203202823](/Users/apple/Documents/Notes/assets/image-20220711203202823.png) |                     前端网页实时渲染                     |
|   Material Icon Theme    | ![image-20220711205837277](/Users/apple/Documents/Notes/assets/image-20220711205837277.png) |                      美化vscode图标                      |
|      Material Theme      | ![image-20220711205919351](/Users/apple/Documents/Notes/assets/image-20220711205919351.png) |                      vscode主题插件                      |
| Prettier-Code Formatter  | ![image-20220711224227640](/Users/apple/Documents/Notes/assets/image-20220711224227640.png) |                        格式化插件                        |
| Bracket Pair Colorizer 2 | ![image-20220711230923276](/Users/apple/Documents/Notes/assets/image-20220711230923276.png) |            括号匹配插件（目前vs code已内置）             |
|     Auto Rename Tag      | ![image-20220711231312663](/Users/apple/Documents/Notes/assets/image-20220711231312663.png) |                  自动重命名匹配标签插件                  |
|         CSS Peek         | ![image-20220711231813716](/Users/apple/Documents/Notes/assets/image-20220711231813716.png) | css样式预览+样式跳转插件（出现未跳转的话重启vscode即可） |
|      Settings Sync       | ![image-20220711234020248](/Users/apple/Documents/Notes/assets/image-20220711234020248.png) |     配置同步插件（对vscode自带的同步不放心所以选择）     |
|     Better Comments      | ![image-20220719100712684](/Users/apple/Documents/Notes/assets/image-20220719100712684.png) |                       注释拓展插件                       |
|       Code Runner        | ![image-20220719165956802](/Users/apple/Documents/Notes/assets/image-20220719165956802.png) |             用于在vscode上直接执行代码的插件             |

### Prettier

> 下面讲讲Prettier插件需要进行的额外设置
>
> ~~*<font color="red">Attention:</font>7.12下午使用发现出现bug，所以弃用，该用vscode内置格式化插件*~~

1. 设置*文件保存时自动格式化*

   ![image-20220711224825978](/Users/apple/Documents/Notes/assets/image-20220711224825978.png)

2. 将Prettier设置为默认格式化插件（需要设置`settings.json`，这里推荐直接修改用户区配置文件）

   ![vscode-Prettier插件配置](/Users/apple/Documents/Notes/assets/vscode-Prettier插件配置-7551611.gif)

3. 修改Prettier中的默认制表符

   ![image-20220711230239773](/Users/apple/Documents/Notes/assets/image-20220711230239773.png)

### Bracket Pair Colorizer 2

> 目前vscode已内置，只需要在设置处微调即可

![image-20220711231137105](/Users/apple/Documents/Notes/assets/image-20220711231137105.png)

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

> 不知为何，我的html文件始终无法使用`!`来快速生成模版文件，所以必须配置个人拥护代码片段。
>
> ![image-20220712151801629](/Users/apple/Documents/Notes/assets/image-20220712151801629.png)

### HTML

```json
"html template": {
    "prefix": "index",
    "body": [
        "<!DOCTYPE html>",
        "<html lang=\"en\">",
        "\t<head>",
        "\t\t<meta charset=\"utf-8\" />",
        "\t\t<meta name=\"viewpoint\" content=\"width=device-width, initial-scale=1\" />",
        "\t\t<title></title>",
        "\t</head>",
        "\t<body></body>",
        "</html>"
    ],
    "description": "html模版代码"
}
```



## 快捷键

|  功能  |     快捷键     |
| :----: | :------------: |
| 块注释 | `cmd+option+/` |
| 行注释 |    `cmd+/`     |
|        |                |

## Terminal Settings

> vscode终端配置（暂时不使用zsh）



### Settings Sync

> ==配置同步插件==，及其重要‼️

具体配置过程见教程吧

## settings.json