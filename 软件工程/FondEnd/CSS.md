[toc]

# CSS

> **CSS** （Cascading Style Sheets，层叠样式表），是用于<u>*控制网页在浏览器中的显示外观*</u>的声明式语言，一条css语句由属性和属性值组成，它们共同决定了网页的外观。

| Without CSS                                                  | With CSS                                                     |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| <img src="/Users/wwt13/Documents/Notes/assets/CleanShot 2023-04-01 at 15.34.53.png" alt="CleanShot 2023-04-01 at 15.34.53"/> | <img src="/Users/wwt13/Documents/Notes/assets/CleanShot 2023-04-01 at 15.34.25.png" alt="CleanShot 2023-04-01 at 15.34.25" /> |

CSS 可以用于给文档**添加样式** —— 比如改变标题和链接的[颜色](https://developer.mozilla.org/zh-CN/docs/Web/CSS/color_value)及[大小](https://developer.mozilla.org/zh-CN/docs/Web/CSS/font-size)。它也可用于**创建布局** —— 比如将一个单列文本变成包含主要内容区域和存放相关信息的侧边栏区域的[布局](https://developer.mozilla.org/zh-CN/docs/Web/CSS/Layout_cookbook/Column_layouts)。它甚至还可以用来**做一些特效**，比如[动画](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_Animations)

通俗的讲，CSS就是用来美化网页的，这也是CSS的根本目的

```css
h1{
    color: red;
    font-size: 5rem;
}
```

css语法由**选择器**开头，它选择了用于添加样式的html元素，:arrow_up:中给一级标题添加了样式

随后的大括号定义了一个或者多个属性(property)值(value)的声明(declarations)，每个声明都指定了选择元素的一个属性的值，比如这里指定了h1的颜色为红色，字体大小为5rem

每个属性都有这不同的属性值，而每个标签又有着不同的属性，并且HTML中有着各式各样的标签，可能你已经发现了，<u>css的学习是一个远远比html学习还要繁琐的过程orz</u>

![含有选择器 .my-css-rule 的 CSS 规则的图像](/Users/wwt13/Documents/Notes/assets/hFR4OOwyH5zWc5XUIcyu.svg)

> ##  
>
> 和HTML学习一致，`Only learn what you need to know and what you're not so familer with.`
>
> ***切莫贪多***

## CSS Basic

### 在HTML中使用CSS

> 可以使用三种方法在HTML中添加css，其中优先级：**内联样式>内部样式表>外部样式表**

1. 外部样式表：使用外部CSS文件，通过 `link` 标签将CSS文件链接到HTML页面中
   ```html
   <head>
     <link rel="stylesheet" href="style.css">
   </head>
   ```

2. 内部样式表：将CSS样式直接写在HTML页面的 `head` 标签中，使用 `style` 标签来定义样式
   ```html
   <head>
     <style>
       body {
         background-color: #f4f4f4;
       }
     </style>
   </head>
   ```

3. 内联样式：将CSS样式直接写在HTML元素的 `style` 属性中
   ```html
   <div style="background-color: #f4f4f4;">
     这是一个 div 元素。
   </div>
   ```

## CSS Advanced

### 选择器

> **CSS选择器**是 CSS 规则的一部分，用于匹配文档中的元素。匹配的元素将会应用规则指定的样式

#### 基础选择器

- 通用选择器：匹配`任何元素`

  ```css
  *{
      color: hotpink;
  }
  ```

- <u>类型选择器</u>：根据`tag`匹配文档中的元素

  ```css
  h1{
      color: red;
  }
  ```

- <u>类选择器</u>：根据元素的`class`属性匹配文档元素(**只要包含了该类的元素就会被匹配**)

  ```css
  .box{
      font-size: 2rem;
  }
  ```

- <u>id选择器</u>：根据元素的`id`属性匹配文档元素

  ```css
  #unique{
      background-color: blue;
  }
  ```

- <u>标签属性选择器</u>：根据一个元素上`标签的某个属性是否存在/等于某值`匹配文档元素

  ```css
  [title]{
      ...
  }
  /* 显然也可以指定特定值来进行筛选 */
  [title="value"]{
      ...
  }
  /* 可以通过向属性选择器添加i运算符来取消大小写区分 */
  [title="value" i]{
      /* Value也会被匹配 */
      ...
  }
  ```

- <u>伪类选择器</u>：这组选择器包含了伪类，用来`选择元素的特定状态`

  ```css
  a:hover{
      /* 设置在鼠标指针悬浮在a标签上时，a标签的样式 */
      ...
  }
  ```

- <u>伪元素选择器</u>：这组选择器包含了伪元素，用于`选择元素的某个部分`而不是元素自己

  ```css
  p::first-line{
      /* 选择p标签的第一行 */
      ...
  }
  ```

- 分组选择器：选择器不必只匹配单类元素，可以用逗号分隔多个选择器，`适用于想要对多类元素施加同种样式的情况`，可以大大节省代码量
  如果其中一条规则失效的话，整个分组选择器都会**连坐**
  
  ```css
  strong,
  em,
  .my-class,
  [lang]{
      color: red;
  }
  ```

#### 复杂选择器[^1]

> 大部分时候，上面展示的基础选择器已经足够使用，但是有时为了对CSS进行更精细的控制，就需要使用到复杂选择器👇🏻

##### 复合选择器

> 是复杂选择器最简单的一种，就是将基础选择器进行组合以提高特异性和可读性

```css
a.myclass{
    /* 选择class="myclass"的a标签 */
    color: red;
}
strong,
p[color="red"]{
    ...
}
```

##### 连结符

> 位于两个选择器之间，例如，如果选择器是 `p > strong` ，则连结符是 `>` 字符
>
> 使用这些连结符的选择器可以`根据元素在文档中的相对位置`选择元素
>
> <em><font color="green">Attention:</font></em>该部分内容还不完善，之后需要进行补充(主要为*下一个同级连结符*和*后续同级连结符*)

父子元素：指HTML元素之间的层级关系，父元素是指包含其他元素的元素，子元素是指被包含在其他元素中的元素，并且**对于某父元素而言，其子元素指的是递归包含在该父元素下的所有元素**

###### 下一个同级连结符

> 连结符为`+`，用于查找紧跟在某元素的子元素之后的元素

<iframe height="300" style="width: 100%;" scrolling="no" title="Learn CSS - Next sibling selector" src="https://codepen.io/web-dot-dev/embed/JjEPzwB?default-tab=html%2Cresult" frameborder="no" loading="lazy" allowtransparency="true" allowfullscreen="true">
  See the Pen <a href="https://codepen.io/web-dot-dev/pen/JjEPzwB">
  Learn CSS - Next sibling selector</a> by web.dev (<a href="https://codepen.io/web-dot-dev">@web-dot-dev</a>)
  on <a href="https://codepen.io">CodePen</a>.
</iframe>

###### 后续同级连结符

###### 后代连结符

> 连结符为` `，选择父元素包含的所有指定子元素，**递归包含**

```css
p strong{
    /* 选择p元素的子元素的所有strong元素，使它们递归地变为蓝色 */
    color: blue;
}
```

请尝试阅读下列代码👇🏻

<iframe height="300" style="width: 100%;" scrolling="no" title="Learn CSS - Descendant combinator, recursive effect" src="https://codepen.io/web-dot-dev/embed/BapBbGN?default-tab=html%2Cresult" frameborder="no" loading="lazy" allowtransparency="true" allowfullscreen="true">
  See the Pen <a href="https://codepen.io/web-dot-dev/pen/BapBbGN">
  Learn CSS - Descendant combinator, recursive effect</a> by web.dev (<a href="https://codepen.io/web-dot-dev">@web-dot-dev</a>)
  on <a href="https://codepen.io">CodePen</a>.
</iframe>

关键点在于这段代码:arrow_double_down:

```css
.top > div {
  padding-left: 2em;
}
/* 下面这段代码虽然也有影响，但是影响微乎其微 */
.top p {
  text-align: left;
  border-left: 1px solid var(--color-primary);
}
```

###### 子代连结符

> 连结符为`>`，又叫直接后代连结符，和后代连结符相对，区别是**选择器限制于直接子级**，并不会递归套用

```css
p > strong{
    /* 选择p元素的直接子strong元素 */
    color: blue;
}
```

<iframe height="300" style="width: 100%;" scrolling="no" title="Learn CSS - Next sibling selector" src="https://codepen.io/web-dot-dev/embed/JjEPzwB?default-tab=html%2Cresult" frameborder="no" loading="lazy" allowtransparency="true" allowfullscreen="true">
  See the Pen <a href="https://codepen.io/web-dot-dev/pen/JjEPzwB">
  Learn CSS - Next sibling selector</a> by web.dev (<a href="https://codepen.io/web-dot-dev">@web-dot-dev</a>)
  on <a href="https://codepen.io">CodePen</a>.
</iframe>






#### 选择器优先级

[^1]:https://web.dev/learn/css/selectors/
