# flex 布局

> flex 布局也看过很多遍了，但是用的时候老是往，遂写篇文章记录下加深下记忆
>
> 参考资料：[深入理解 flex 布局的 flex-grow,flex-shrink,flex-basis](https://zhuanlan.zhihu.com/p/39052660)、[flex-layout MDN](https://developer.mozilla.org/zh-CN/docs/Web/CSS/CSS_flexible_box_layout/Basic_concepts_of_flexbox)

flex 是一维布局模型，同时只能处理一个维度上的元素布局

flex 布局最关键的概念就是两根轴线，主轴和交叉轴，其中主轴由`flex-direction`设置，交叉轴则自动垂直于主轴，所有 flex 子元素都沿着 flexbox 的主轴排列

`flex-direction: row|row-reverse|column|column-reverse`

主轴的起始位置为`main start`，结束位置为`main end`，交叉轴的起始位置为`cross start`，结束位置为`cross end`

_三个空间占用相关的属性_

-   `flex-basis`: 定义了元素基准空间的大小，默认值为元素宽度（未设置元素宽度则默认为元素内容宽度），并且 flex-basis 的优先级要高于 width
-   `flex-grow`: 定义了主轴富余空间的分配比例，默认为 0(也就是主轴增长元素宽度在达到 flex-basis 后即不变)
-   `flex-shrink`: 和 flex-grow 相对，也就是定义了主轴缺省空间的吸收率，当所有元素的基准空间之和要大于主轴空间时，通过 flex-shrink 来分配各子元素需要缩小的长度，默认 flex-shrink 为 1，也就是说所有子元素等比例减小

具体演示参见`./flex.html`

**两个空间布局相关的属性**

-   `align-items`: 定义元素在交叉轴的对齐方式，默认为 `stretch`，也就是默认拉伸到最高元素高度，其他值有`flex-start`、`flex-end`、`center`
-   `justify-center`: 定义元素在主轴上的对齐方式，默认为`flex-start`，也就是默认从主轴起始位置开始排列，其他值有`flex-end`、`center`、`space-between`、`space-around`、`stretch`
