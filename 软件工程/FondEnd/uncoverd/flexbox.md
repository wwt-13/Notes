# flexbox

> 布局的传统解决方案，基于[盒状模型](https://developer.mozilla.org/en-US/docs/Web/CSS/box_model)，依赖 [`display`](https://developer.mozilla.org/en-US/docs/Web/CSS/display) 属性 + [`position`](https://developer.mozilla.org/en-US/docs/Web/CSS/position)属性 + [`float`](https://developer.mozilla.org/en-US/docs/Web/CSS/float)属性。它对于那些特殊布局非常不方便，比如，[垂直居中](https://css-tricks.com/centering-css-complete-guide/)就不容易实现。
>
> 2009年，W3C 提出了一种新的方案----Flex 布局，可以简便、完整、响应式地实现各种页面布局。目前，它已经得到了所有浏览器的支持，这意味着，现在就能很安全地使用这项功能（好处，可延展性极高，能够自由的在手机、平板、PC端端网页布局进行切换）。
>
> *<font color="red">Attention:</font>这是css中非常非常重要的概念‼️*

任何一个容器都可以设定为flex布局，并且设定为flex布局后，子元素（`flex item`）的float、clear、vertical-align属性将失效

## 基本概念

> 采用 Flex 布局的元素，称为 *Flex 容器*（*flex container*），简称"容器"。它的所有子元素自动成为容器成员，称为 *Flex 项目*（*flex item*），简称"项目”

`flex container`默认存在两根主轴，主轴（main axis）和垂直于主轴的交叉轴（cross axis），主轴的开始位置（与边框的交叉点）称为`main start`，结束位置称为`main end`；交叉轴的开始位置称为`cross start`，结束位置称为`cross end`

`flex item`沿主轴排列。单个项目占据的主轴空间叫做`main size`，占据的交叉轴空间叫做`cross size`

![bg2015071004](https://www.ruanyifeng.com/blogimg/asset/2015/bg2015071004.png)

## 容器的属性

> 以下六个属性在容器上设置
>
> - *flex-direction*定义了==项目的排列方向==，即主轴的方向
> - *flex-wrap*定义了==项目的排列方式==（轴线排不下的话如何换行）
> - *flex-flow*前两个属性的==简写==
> - *justify-content*定义了项目==在主轴上的对齐方式==
> - *align-items*定义了项目在==交叉轴上的对齐方式==
> - *align-content*

### flex-direction

> `flex-direction`属性决定主轴的方向（即项目的排列方向）
>
> ```css
> .box {
>   flex-direction: row | row-reverse | column | column-reverse;
> }
> ```
>
> ![bg2015071005](https://www.ruanyifeng.com/blogimg/asset/2015/bg2015071005.png)



- `row`（默认值）：主轴为水平方向，起点在左端。
- `row-reverse`：主轴为水平方向，起点在右端。
- `column`：主轴为垂直方向，起点在上沿。
- `column-reverse`：主轴为垂直方向，起点在下沿

### flex-wrap

> 默认情况下，项目都排在一条线（又称"轴线"）上。`flex-wrap`属性定义，如果一条轴线排不下，如何换行
>
> ```css
> .box{
>   flex-wrap: nowrap | wrap | wrap-reverse;
> }
> ```
>
> ![bg2015071006](https://www.ruanyifeng.com/blogimg/asset/2015/bg2015071006.png)

1. `nowrap`（默认）：不换行。

   ![img](https://www.ruanyifeng.com/blogimg/asset/2015/bg2015071007.png)

2. `wrap`：换行，第一行在上方。

   ![img](https://www.ruanyifeng.com/blogimg/asset/2015/bg2015071008.jpg)

3. `wrap-reverse`：换行，第一行在下方。

   ![img](https://www.ruanyifeng.com/blogimg/asset/2015/bg2015071009.jpg)

### flex-flow

> `flex-flow`属性是`flex-direction`属性和`flex-wrap`属性的简写形式，默认值为`row nowrap`。
>
> ```css
> .box {
>   flex-flow: <flex-direction> || <flex-wrap>;
> }
> ```

### justify-content

> `justify-content`属性定义了项目在主轴上的对齐方式
>
> ```css
> .box {
>   justify-content: flex-start | flex-end | center | space-between | space-around;
> }
> ```

- `flex-start`（默认值）：左对齐
- `flex-end`：右对齐
- `center`： 居中
- `space-between`：两端对齐，项目之间的间隔都相等。
- `space-around`：每个项目两侧的间隔相等。所以，项目之间的间隔比项目与边框的间隔大一倍。

![justify-content](https://css-tricks.com/wp-content/uploads/2018/10/justify-content.svg)

### align-items

> `align-items`属性定义项目在交叉轴上如何对齐。
>
> ```css
> .box {
>   align-items: flex-start | flex-end | center | baseline | stretch;
> }
> ```

- `flex-start`：交叉轴的起点对齐。
- `flex-end`：交叉轴的终点对齐。
- `center`：交叉轴的中点对齐。
- `baseline`: 项目的第一行文字的基线对齐。
- `stretch`（默认值）：如果项目未设置高度或设为auto，将占满整个容器的高度。

![align-items](/Users/apple/Documents/Notes/assets/align-items.svg)

## 项目属性

> 以下6个属性设置在项目上
>
> - `order`==定义项目的排列顺序==。数值越小，排列越靠前，默认为0
> - `flex-grow`==定义项目的放大比例==，默认为`0`，即如果存在剩余空间，也不放大。
> - `flex-shrink`==定义了项目的缩小比例==，默认为1，即如果空间不足，该项目将缩小。
> - `flex-basis`==定义了在分配多余空间之前，项目占据的主轴空间（main size）==。浏览器根据这个属性，计算主轴是否有多余空间。它的默认值为`auto`，即项目的本来大小。
> - `flex`是`flex-grow`, `flex-shrink` 和 `flex-basis`的简写，默认值为`0 1 auto`。后两个属性可选
> - `align-self`==允许单个项目有与其他项目不一样的对齐方式==，可覆盖`align-items`属性。默认值为`auto`，表示继承父元素的`align-items`属性，如果没有父元素，则等同于`stretch`。

### order

> `order`属性定义项目的排列顺序。数值越小，排列越靠前，默认为0。
>
> ```css
> .item {
>   order: <integer>;
> }
> ```

![Diagram showing flexbox order. A container with the items being 1 1 1 2 3, -1 1 2 5, and 2 2 99.](https://css-tricks.com/wp-content/uploads/2018/10/order.svg)

### flex-grow

> `flex-grow`属性定义项目的放大比例，默认为`0`，即如果存在剩余空间，也不放大。
>
> ```css
> .item {
>   flex-grow: <number>; /* default 0 */
> }
> ```

![two rows of items, the first has all equally-sized items with equal flex-grow numbers, the second with the center item at twice the width because its value is 2 instead of 1.](https://css-tricks.com/wp-content/uploads/2018/10/flex-grow.svg)

#### 关于flex-grow的计算规则

> 有一个1000px宽的网页，设置两个box，并且css设定为`flex-basis=100px,box1的flex-grow=3,box2的flex-grow=1`问两个box的宽度分别是多少？

1. 总宽度减去两者的`flex-basis`

   *1000px-100px-100px=800px*

2. 剩下的宽度按照`flex-grow`的比例按比分配

   *box1:600px+100px=700px, box2:200px+100px=300px*

### flex-shrink

> `flex-shrink`属性定义了项目的缩小比例，默认为1，即如果空间不足，该项目将缩小。
>
> 如果所有项目的`flex-shrink`属性都为1，当空间不足时，都将等比例缩小。如果一个项目的`flex-shrink`属性为0，其他项目都为1，则空间不足时，前者不缩小
>
> ```css
> .item {
>   flex-shrink: <number>; /* default 1 */
> }
> ```

![bg2015071015](https://www.ruanyifeng.com/blogimg/asset/2015/bg2015071015.jpg)

### flex-basis

> `flex-basis`属性定义了在分配多余空间之前，项目占据的主轴空间（main size）。浏览器根据这个属性，计算主轴是否有多余空间。它的默认值为`auto`，即项目的本来大小。
>
> ```css
> .item {
>   flex-basis: <length> | auto; /* default auto */
> }
> ```
>
> 它可以设为跟`width`或`height`属性一样的值（比如350px），则项目将占据固定空间。

### flex

> `flex`属性是`flex-grow`, `flex-shrink` 和 `flex-basis`的简写，默认值为`0 1 auto`。后两个属性可选
>
> ```css
> .item {
>   flex: none | [ <'flex-grow'> <'flex-shrink'>? || <'flex-basis'> ]
> }
> ```

### align-self

> `align-self`属性允许单个项目有与其他项目不一样的对齐方式，可覆盖`align-items`属性。默认值为`auto`，表示继承父元素的`align-items`属性，如果没有父元素，则等同于`stretch`。
>
> ```css
> .item {
>   align-self: auto | flex-start | flex-end | center | baseline | stretch;
> }
> ```

## flex item width and height

> 关于项目宽度和高度设定对于页面布局的影响

### width

> 共有三种设定情况
>
> - no setting for width：**width=content**
> - unit setting for width：**width~max~=width,width~min~=content**
> - Unit setting and *flex-warp(!=nowrap)*：**width=width**（借此实现网页自动调节）
> - flex-grow setting：**width~min~=content**（随着viewport改变自动缩放）
> - flex-grow setting and flex-basis setting and flex-wrap(!=nowrap)：**width~min~=flex-basis setting并且宽度小于flex-basis时自动换行**

### height

> - no setting for width：**width=content**
> - unit setting for width：**width=width**