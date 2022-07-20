# css选择器

> 各种css选择器之间可以互相组合
>
> *<font color="red">Attention:</font>css文件的读取顺序是从前往后的，也就是说后面的css样式会覆盖前面的css样式（同级别的时候）*

|         类型          |               效果                |     选择前缀示例     |
| :-------------------: | :-------------------------------: | :------------------: |
| `Universal Selector`  |      更改所有html元素的样式       |         `*`          |
|  `Element Selector`   |      更改特定html元素的演示       |         `h1`         |
|     `Id Selector`     |   更改特定id的html元素（唯一）    |      `#redText`      |
|   `Class Selector`    |      更改特定类型的html元素       |     `.blueText`      |
|  `Grouping Selector`  | 具备相同css属性的元素可以进行合并 |  `#testh1,h2.test`   |
| `Descendant Selector` |        parent标签和son标签        |    `div.link1 a`     |
| `Attribute Selector`  |     设定特定属性的标签的样式      | `input[type="text"]` |

> 一个html元素添加多个class属性示例
>
> ```html
> <p class="redText largerText Sont">
>     Test
> </p>
> ```
>
> 直接将各个class类型按照空格隔开即可

## Pseudo-classes

> css伪类，用于制定html元素在==特定状态==下的样式，比方说`:hover`用于指定鼠标悬停在特定元素下该元素的状态

|   类型    |                           效果演示                           |
| :-------: | :----------------------------------------------------------: |
| `:hover`  | ![vscode-hover演示](/Users/apple/Documents/Notes/assets/vscode-hover演示.gif) |
| `:active` | ![vscode-active演示](/Users/apple/Documents/Notes/assets/vscode-active演示-7763872.gif) |
| `:focus`  | ![vscode-focus演示](/Users/apple/Documents/Notes/assets/vscode-focus演示.gif) |

## Pseudo-elements

> A CSS pseudo-element is a keyword added to a selector that lets you *style a specific part of the selected elements*.
>
> For example, [`::first-line`](https://developer.mozilla.org/en-US/docs/Web/CSS/::first-line) can be used to change the font of the first line of a paragraph.

**About the Syntax**

```css
/* You can use only one pseudo-element in a selector. It must appear after the simple selectors in the statement. */
selector::pseudo-element{
    property: value;
}
```

举例说明

```css
p::before{/* 在p标签的前面添加样式，::after同理就是在标签的后面添加样式 */
    content:">>";
    color:red;
}
```

![image-20220714101103965](/Users/apple/Documents/Notes/assets/image-20220714101103965.png)

常见的还有`::first-letter(设定第一个字样式)`、`::selection(设定元素被选取的时候的样式)`等等