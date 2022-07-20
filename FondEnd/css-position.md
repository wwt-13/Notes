# css-position

## css代码位置

> 共有三种css位置，优先级逐渐降低

1. `inline styling`：直接放置在html标签的内部

   ```html
   <h1 style="color: green;font-size:50px;">
       This is a test head.
   </h1>
   ```

2. `internal styling`：直接放置在`head`标签内部

   ```html
   <head>
   	<style>
           h1{
               color: green;
               font-size: 50px;
           }
           p{
               color: coral;
           }
       </style>
   </head>
   ```

3. `external styling`：设置独立的css styling文件，再在head中引用  

## css-position

> CSS **`position`**属性用于指定一个元素在文档中的**定位方式**。[`top`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/top)，[`right`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/right)，[`bottom`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/bottom) 和 [`left`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/left) 属性则决定了该元素的最终位置
>
> *<font color="green">Ps:</font>可以类比background-origin和background-position之间的关系。*

### normal flow和stacking content

> 两者都是在后面的css-position中频繁出现的东西

- `normal flow`：总结一下就是html的默认排版形式，比如block元素从上到下排列，inline元素从左到右排列
- `stacking context`：堆叠上下文，具体解释涉及到了css样式中的坐标z轴问题，具备了stacking context的*定位方式*可以设置z轴坐标（`z-index`属性）来达到不同层次的效果

----

除了static外的定位方式都能具备*堆叠上下文*

|   style    |                           explain                            |                           example                            |
| :--------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
|  `static`  | 该关键字指定元素使用正常的布局行为，即元素在文档常规流中当前的布局位置。此时 `top`, `right`, `bottom`, `left` 和 `z-index `属性无效 |                              -                               |
| `relative` | 不会从正常文档流中移除，不设置top等时和static时的状态一致，relative相对的是static状态下的位置，并且移动后会在原先位置留下空白 |                              -                               |
| `absolute` | **该元素会被移出`normal flow`**，不再为该元素预留空间，按照==相对于该元素最近的非static定位祖先元素==进行偏移，来确定元素位置， | ![vscode-absolute定位演示](/Users/apple/Documents/Notes/assets/vscode-absolute定位演示.gif) |
|  `fixed`   | **该元素会被移出`normal flow`**，不再为该元素预留空间，通过==指定该元素相对于屏幕视窗（viewport）来指定元素位置==，元素位置在屏幕滚动的时候保持相对位置不变 | ![vscode-fixed定位演示](/Users/apple/Documents/Notes/assets/vscode-fixed定位演示.gif) |
|  `sticky`  | **该元素按照`normal flow`进行定位**，该元素结合了`position:relative`和`position:fixed`为一体，元素首先按照普通文档流进行定位，然后达到设定的阈值后（top:0等等），元素以fixed定位表现（被固定在特定位置） | ![vscode-sticky定位演示](/Users/apple/Documents/Notes/assets/vscode-sticky定位演示.gif) |
|            |                                                              |                                                              |

