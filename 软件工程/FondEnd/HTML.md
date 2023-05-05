[toc]

# HTML

> 全称为**H**yper **T**ext **M**arkup **L**anguage(超文本标记语言)，是一种用于专门描述网页`结构`的语言，目前最新的版本为*HTML5*

以下是一个基本的html文件，用于阐述HTML语法的基本结构👇🏻

```html
<!DOCTYPE html>
<html lang="en">
    /* section1 */
    <head>
        <meta charset="utf-8" />
        <meta name="author" content="wwt13" />
        <link rel="icon" href="./alfred.jpg" />
        <style>
            /* Your css code. */
        </style>
        <noscript>抱歉，您的浏览器不支持 JavaScript!</noscript>
        <base target="_blank" />
        <title>网页标题</title>
    </head>
    /* section2 */
    <body>
        <h1 id="myheader">标题1</h1>
        <a href="#myheader">跳转到标题1</a>
    </body>
</html>
```

<em><font color='red'>ps:</font></em>光从上面这一个文件，也可以看出HTML语法有多么繁杂了orz

整个html源代码，大体上可以分为两大部分和各部分中的子部分，下面对它们做一个笼统的介绍

1. `<head></head>`该部分是**Web浏览器用于正确渲染html文件的信息来源**
   - `<meta></meta>`：描述页面元数据，定义了页面编码、网页作者、网页描述等等内容
   - `<link></link>`：用于定义当前文档与外部资源的关系，常用于链接外部CSS样式表/JS文件、指定站点图标等等
   - `<script></script>`：用于定义内嵌的CSS/JS
2. `<body></body>`该部分是**HTML文件的主体内容**，其中各式各样的标签定义了网页的基本结构



## 标签

> HTML使用一系列的标签（tag）来描述网页的结构和内容，掌握理解了标签，就掌握了HTML一半的内容
>
> <em><font color="red">ps:</font></em>该部分内容极其繁杂，建议先掌握常用的标签使用，后续<u>用到其他标签的时候再单独学习</u>

### 标签结构

> 这里MDN[^1]上已经阐述的非常简洁明了了，我就不造轮子了

![HTML 元素](/Users/wwt13/Documents/Notes/assets/grumpy-cat-small.png)

1. **开始标签**（Opening tag）：包含元素的名称（本例为 p），被大于号、小于号所包围。表示元素从这里开始或者开始起作用 —— 在本例中即段落由此开始。

2. **结束标签**（Closing tag）：与开始标签相似，只是其在元素名之前包含了一个斜杠。这表示着元素的结尾

3. **内容**（Content）：元素的内容，本例中就是所输入的文本本身(有些元素的内容为空，比如`<img>`元素，这是因为它们不需要通过内容来产生效果)

4. **元素**（Element）：开始标签、结束标签与内容相结合，便是一个完整的元素
   可以将多个元素互相嵌套，但是嵌套顺序必须正确👇🏻

   ```html
   /* correct */
   <p>My cat is <strong>very</strong> grumpy.</p>
   /* wrong */
   <p>My cat is <strong>very grumpy.</p></strong>
   ```

   

![HTML 属性](/Users/wwt13/Documents/Notes/assets/grumpy-cat-attribute-small.png)

5. **属性**（Attribute）：属性包含了关于元素的一些额外信息，这些信息本身不应显现在内容中(所有的attribute都应该使用引号包含，这是为了<u>文档的规范性</u>)

### HTML元素-常用

#### h1~h6

> **h1~h6**元素用于指定内容的标题和子标题，共6个级别(可以直接参考<u>Typora的六级标题</u>)

```html
<h1>主标题</h1>
<h2>顶层标题</h2>
<h3>子标题</h3>
<h4>次子标题</h4>
/* 一般而言你，4级标题就够用了 */
```

#### p

> **p**元素用于指定段落，也就是常规文本内容

```html
<p>这是一个段落</p>
```

<p>This is a paragraph.</p>

#### list

> 用于有序或无序的组织你的网页内容，分为有序列表*ol*(ordered list)和无序列表*ul*(unordered list)
>
> *列表之间可以互相嵌套*

```html
<ol>
  <li>technologists</li>
  <li>thinkers</li>
  <li>builders</li>
</ol>
<ul>
  <li>technologists</li>
  <li>thinkers</li>
  <li>builders</li>
</ul>
```

<ol>
  <li>technologists</li>
  <li>thinkers</li>
  <li>builders</li>
</ol>
<ul>
  <li>technologists</li>
  <li>thinkers</li>
  <li>builders</li>
</ul>

> # list的type属性
>
> 通过指定type属性，可以设置显示的编号为不同类型(该属性仅适用于<u>有序列表</u>`ol`，无序列表已废弃type属性)
>
> - **a** 表示小写英文字母编号
> - **A** 表示大写英文字母编号
> - **i** 表示小写罗马数字编号
> - **I** 表示大写罗马数字编号
> - **1** 表示数字编号（默认）
>
> <ol type='i'>
>   <li>technologists</li>
>   <li>thinkers</li>
>   <li>builders</li>
> </ol>

#### a[^4]

> 链接，又叫锚元素(*anchor*)，可以通过它的href属性创建通向**其他网页**、文件、**同一页面内的位置**、**电子邮件地址**或**任何其他URL的超链接**，元素内容应该指明该链接的意图，比如某链接的href为*http://www.baidu.com*,那么其内容应该被声明为"百度"、"Baidu"等等

```html
<a href="https://www.baidu.com">百度百科</a>
```

<a href="https://www.baidu.com">百度百科</a>

- `href`就是链接指向的地址
- `target`用于指定在何处显示连接的资源
  1. **_self**：默认，直接在当前窗口打开
  1. **_blank**：到一个新窗口打开
- `title`为超链接声明额外的信息，就像img标签的alt属性一样，只不过该信息是在鼠标悬停在链接上是显示的<a href="#" title="额外信息">title测试</a>

> # 链接到本页的某个部分
>
> 要做到这一点，你必须首先给要链接到的元素分配一个id属性，然后为了链接到那个特定的id，要将它放在URL的末尾，并在前面包含井号`#`
>
> ```html
> <h2 id="test">This is H2</h2>
> <a href="#test">跳转到二级标题</a>
> ```
>
> <a href="#footnote">跳转到本页的脚注部分</a>

#### img[^3]

> **img**元素用于将一张图像嵌入文档，它是空元素的一种

img元素的常见属性如下:arrow_down:

- `src`包含了嵌入图片的路径，可以是*相对路径/绝对路径/网络路径*

- `alt`包含了对于图像的文本描述，这并不是强制性的，但是对于无障碍[^2]而言，它是必须的——屏幕阅读器会将这些描述读给需要使用阅读器的使用者听，让他们知道图像的含义。并且如果由于某种原因无法加载图像，普通浏览器也会在页面上显示 `alt` 属性中的备用文本：例如，*网络错误*、*内容被屏蔽*或*链接过期*

```html
<img src="https://images.unsplash.com/photo-1533738363-b7f9aef128ce?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80" alt="Cool Cat!" height="400px">
```

It will be displayed as below.

<img src="https://images.unsplash.com/photo-1533738363-b7f9aef128ce?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1470&q=80" alt="Cool Cat!" height="400px">



> ## 关于`img`元素在*Typora*内的显示问题
>
> 如果你预先学习过**行内元素**、**块状元素**这方面的内容，可能会对为什么img明明是行内元素却在Typora内独占一行:arrow_double_up:表示不解
>
> 这是因为Typora内部css文件隐式定义了**md-img**类的显示均为块状元素(`display: block;`)
>
> 可以通过右键的‘<u>检查元素</u>’直接查看对应css源码！

#### table

### HTML元素进阶

#### head

#### div

#### span

### HTML元素-杂

---

# <font id="footnote">footnote</font>

[^1]:https://developer.mozilla.org/zh-CN/docs/Learn/Getting_started_with_the_web/HTML_basics
[^2]:关于无障碍技术https://developer.mozilla.org/zh-CN/docs/Web/Accessibility
[^3]:https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/img
[^4]:https://developer.mozilla.org/zh-CN/docs/Web/HTML/Element/a
