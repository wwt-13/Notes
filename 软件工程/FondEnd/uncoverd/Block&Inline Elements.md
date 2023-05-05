[toc]

# Block&Inline Elements

## Intro

> 记录block（块级元素）和inline（内联元素）的具体区别
>
> *<font color="red">Attention:</font>:html中的所有元素都是box模型，所有盒子模型都有==width、height、content、padding、border、margin==*

## Block-Level Element

> A block-level elemet always `starts on a new line`, and the browsers automaticlly add some space(`a margin`) before and after the element.
>
> And a block-level element always `takes up the full width`(of its parent element) available.

常见的块级元素：==div==,==p==,`form`,`table`,`h1~h6`,`ol`,`ul`

## Inline-Level Element

> An inline element `does not start on a new line`.
>
> An inline element `only takes up as much width as necessary.`

常见的内联元素：==span==,==a==,==img==,`strong`,`em`,`label`,`input`,`select`,`textarea`

---

block元素可以包含block和inline元素，但是inline元素只能包含inline元素。但是要注意该说法只适用于大部分情况，**存在特例**，比如`p`标签只能包含inline元素，不能包含block元素。

可以通过设置`display:inline,display:block`来改变元素的布局。

---

## block，inline和inline-block的区别

- `display:block`
  1. block元素会独占一行，多个block元素会各自新起一行。默认情况下，*block元素宽度自动填满其父元素宽度*。
  2. block元素*可以设置width,height属性*。但是块级元素即使设置了宽度,仍然是独占一行。
  3. block元素*可以设置margin和padding属性*
- `display:inline`
  1. inline元素不会独占一行，*多个相邻的行内元素会排列在同一行里*，直到一行排列不下，才会新换一行，其**宽度随元素的内容而变化**。
  2. **inline元素设置width,height属性无效**。
  3. inline元素的margin和padding属性，*水平方向的padding-left, padding-right, margin-left, margin-right都产生边距效果；但竖直方向的padding-top, padding-bottom, margin-top, margin-bottom不会产生边距效果（也就是只会延伸，不会挤开其他元素）*。

- `display:inline-block`
  1. 简单来说就是将对象呈现为inline对象，但是对象的内容作为block对象呈现。之后的内联对象会被排列在同一行内。比如我们可以给一个link（a元素）inline-block属性值，使其*既具有block的宽度高度特性*又*具有inline的同行特性*。

## 属性设定

### padding和margin的设定

1. 4方向：上开始，顺时针`padding: 1px 2px 3px 4px;`
2. 2方向：上下`padding: 1px 2px;`
3. 1方向：等距`padding: 1px;`

```css
button{
    margin-left: 40px;
    /* width和height设置的是除margin的大小 */
    width: 80px;
    height: 100px;
    /* 并且content的部分不是指只包含了字母的部分，这是可以通过设置padding进行调整的 */
    padding:20px;
}
```

#### margin进阶设定

> 出现的问题如下
>
> - style设定
>
>   ```css
>   <style>
>   a {
>       margin: 150px 30px;
>       background-color: aqua;
>   }
>   </style>
>   ```
>
> - 网页结构
>
>   ```html
>   <a href="https://www.baidu.com">百度百科</a>
>   <a href="https://www.baidu.com">百度百科</a>
>   <a href="https://www.baidu.com">百度百科</a>
>   ```
>
> - 具体显示如下
>
>   <style>
>       div{
>           font-size:0rem;
>       }
>       img{
>           max-width:50%;
>           height:auto;
>       }
>   </style>
>   <div>
>       <img src="/Users/apple/Documents/Notes/assets/image-20220714173533426.png">
>       <img src="/Users/apple/Documents/Notes/assets/image-20220714174242194.png">
>   </div>
>
>   也就是说，现在对a标签设置的margin，*虽然上下左右都有显示，但是上下部分并没有和p标签隔开*。

[w3.org上的官方解释](https://www.w3.org/TR/CSS21/box.html#box-model)

原话如下：*Margin properties specify the width of the [margin area](https://www.w3.org/TR/CSS21/box.html#box-margin-area) of a box. The ['margin'](https://www.w3.org/TR/CSS21/box.html#propdef-margin) shorthand property sets the margin for all four sides while the other margin properties only set their respective side. These properties apply to all elements, but vertical margins will not have any effect on non-replaced inline elements.*

翻译一下：**margin属性适用于所有html元素，但是对于垂直方向上的margin不会在inline元素上有任何效果**。

![image-20220714200948383](/Users/apple/Documents/Notes/assets/image-20220714200948383.png)

### border设定

> 设定顺序：`border-width,border-style,border-color`，可以分开设定也可以一起设定

```css
border: 4px dashed red;
```

### display设定

> 复习一下block和inline的重要区别
>
> 1. *block element width by default is 100% if its parent element.*
> 2. *inline element 不能设定 width, height.*

如何解决？

**设定display属性！！！**

*<font color="red">Attention:</font>*特殊元素==img、input、button、select、textarea==——**inline-block**

inline-block属性的特点：

1. 网页排版上符合inline元素
2. 在高度和宽度的设定上符合block元素