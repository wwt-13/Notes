# HTML5 Semantic Elements

> HTML5中独有的语意标签。
>
> 语意元素=有意义的元素

## 什么是语义元素？

> 语义元素清楚地向浏览器和开发人员描述了它的含义。
>
> **非语义**元素的例子：`<div>`和`<span>`- 没有说明它的内容。
>
> **语义**元素示例： `<form>`、`<table>`和`<article>`- 明确定义其内容
>
> - 当只有HTML页面时，没有CSS，我们仍然可以很清晰的看懂页面的DOM结构
> - 团队维护，当团队来review代码或者重构时，增强代码的可读性，更利于维护
> - 有利于SEO，搜索引擎爬虫依赖于标签来确定上下文和各个关键字的权重
> - 提高用户体验，比如 title 和 alt 等用来解释内容信息

html5的语意元素基本上都没有任何default styling，可以等价于<div>，定义他们就像是定义变量一样，都是为了开发人员方便。

- *<header>*：网页的标头，用于给网页文档、section、article**指定标题**。

- *<nav>*：网页的选单、导览，**导航栏**。

- *<main>*：网页的主要内容。

- *<aside>*：网页的侧栏、附加内容。

- *<article>*：一篇文章内容，并且可以脱离网站的其他部分进行阅读。

- *<section>*：自定义的区块，例如数篇摘要组成的空间。

  *<font color="green">Ps:</font><section> 中可以包含 <article>，同时 <article> 中也可以包含 <section>*

- *<footer>*：网页的页尾，通常放置*联络方式、著作权宣告*等等。

- *<mark>*：强调一小块内容。

- *<time>*：显示日期时间。

![preview](https://pic4.zhimg.com/v2-d1d66937ed3a68fc78ca6adeddd82e97_r.jpg)