---
title:YAML Front Matter
category: how-to
author:wwt-13
tags:[Typora,metadate,tags]
---

[toc]

# Typora使用

> 本文主要记录了以下有关Typora语法（特殊类）、个人使用习惯以及各类快捷键（Mac版）等等的使用。

## Typora语法

>   主要记录平时使用较少的/较为特殊的Typora语法

### YAML Front Matter

>   在YAML Front Matter块中放置的是该markdown文档的元数据，也就是文档的描述数据，并且Front Matter部分必须放置在文章顶部。
>
>   Front Matter块中，可以设置**预定义的变量**，也可以创建自己的自定义变量。
>
>   *<font color="green">Ps:</font>可以去jekyll官网[^YAML Front Matter官网介绍]查看对应的详细介绍，还可以去Typora的中文翻译教程[^Typora中文文档翻译-YAML]查看具体内容*

*基本YAML Front Matter使用*——也可以参考本篇文章的最上方的Front Matter

```markdown
---
layout: post
title: Blogging Like a Hacker
---
```

以下只记录个人认为是用得到的预定义变量，其他的可以去上面的官网链接查看。

|         NAME          |                         DESCRIPTION                          |
| :-------------------: | :----------------------------------------------------------: |
|        *title*        |                         定义文章标题                         |
|        *date*         | 用于确保帖子的正确排序，日期格式`YYYY-MM-DD HH:MM:SS +/-TTTT` |
| *category/categories* |                       用于制定帖子类别                       |
|        *tags*         |                          和类别类似                          |

[^YAML Front Matter官网介绍]: https://jekyllrb.com/docs/front-matter/
[^Typora中文文档翻译-YAML]:https://support.typora.io/YAML/

### 任务列表

>   常用与罗列某些任务是否完成，语法较复杂
>
>   *<font color="orange">Tip:</font>建议设计任务列表的笔记使用Noto代替*

```markdown
- [ ] a task list item
- [ ] list syntax required
- [ ] normal **formatting**, @mentions, #1234 refs
- [ ] incomplete
- [x] completed
```

### 脚注

>    脚注为文章的正文注释/注解，标明被引用于正文或注解的数据源
>
>   *<font color="green">Ps:</font>脚注和尾注的区别在于脚注一般位于页面的底部，可以作为**文档某处内容的注释**;尾注一般位于文档的末尾，**列出引文的出处**等*

```markdown
You can create footnotes like this[^footnote].

[^footnote]: Here is the *text* of the **footnote**.
```

You can create footnotes like this[^footnote].

[^footnote]: Here is the *text* of the **footnote**.

此时当你吧鼠标移动到标注上方就能看到具体脚注的内容

### 跳转

>   分为`md`文件内部跳转和`md`文件之间跳转

-   内部跳转

    1.   设置*跳转标签*

         <span id="test">测试跳转</span>

    2.   设置**跳转按钮**

         <a href="#test">跳转按钮</a>

    然后按住`cmd`点击跳转按钮即可跳转到标签处

-   文件跳转

    >   文件之间的跳转和`html`文件之间的跳转类似，`<a>`标签指明对应跳转文件的*相对路径*or*绝对路径*即可

    <a href="/Users/wwt13/Documents/Notes/Typora/Readme.md">Readme.md</a>

### 嵌入式内容

>   这部分需要对网页和前端方面有个详细的了解才能自己创建，下面放一个国外大佬做的示例演示。

<iframe height='265' scrolling='no' title='Fancy Animated SVG Menu' src='http://codepen.io/jeangontijo/embed/OxVywj/?height=265&theme-id=0&default-tab=css,result&embed-version=2' frameborder='no' allowtransparency='true' allowfullscreen='true' style='width: 100%;'></iframe>

## 通用快捷键

>   Typora通用未修改的快捷键，上手就能用

|      NAME      |     VALUE      | MEMORY |
| :------------: | :------------: | :----: |
| $\LaTeX$公式块 | `option+cmd+b` | block  |
|     代码块     | `option+cmd+c` |  code  |
|      表格      | `option+cmd+t` | table  |

## 个人使用习惯

### 个人设定Snippets

> 由于Typora在1.3.7版本的时候依旧没有支持*代码片段（Snippet）*这类的功能，所以只能自己配合mac的**快捷输入码**一起使用。
>
> *<font color="orange">Tip:</font>可以直接通过左下角的🪩打开表情包选择窗口*

| Prefix |                    Body                    |                 Description                 |
| :----: | :----------------------------------------: | :-----------------------------------------: |
|  atn   |   *<font color="red">Attention:</font>*    |                ‼️重点强调内容                |
|   ps   |      *<font color="green">Ps:</font>*      |    顺带提一提的内容（重要程度不算太高）     |
|  tip   |     *<font color="orange">Tip:</font>*     |                   📖小知识                   |
|   a    |              <a href=""></a>               | 🔗快速链接（因为链接使用的频率很高所以添加） |
|  warn  | *==<font color="purple">Warning:</font>==* |           ⚠️未完成内容或者相关警告           |

### 个人设定快捷键

>   以下为个人修改的Typora快捷键键位绑定
>
>   修改原则：简单操作采用`cmd`作前缀，复杂操作采用`cmd+option`做前缀
>
>   *<font color="green">Ps:</font>配合CheatSheet和CustomShortCuts使用*

|      NAME       |      VALUE      |    MEMORY     |
| :-------------: | :-------------: | :-----------: |
| 展开/隐藏侧边栏 | `option+cmd+l`  |     list      |
|      脚注       | `opeiton+cmd+f` |     foot      |
|     删除线      |     `cmd+d`     |    delete     |
|    ~~高亮~~     |   ~~`cmd+h`~~   | ~~highlight~~ |

### 配合其他软件

1.   <a href="/Users/wwt13/Documents/Notes/效率软件使用/CleanShot X.md">CleanShot X截图软件</a>
2.   <a href="/Users/wwt13/Documents/Notes/效率软件使用/Alfred.md">Alfred聚焦搜索软件</a>
3.   

## 杂

> 一些比较杂乱的规范性的东西，因为不知道如何分类所以统一归类到**杂**里面

