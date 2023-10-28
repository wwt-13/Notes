# 关于 linear-gradient()

> 线性渐变函数，可用于设置 CSS background
>
> 还是非常 easy 的，更多可见https://www.tiny66.com/example-code/css-linear-gradient-background
>
> 其实也没啥好说的就是

基本语法：`linear-gradient([<angle> | to <side-or-corner>]? , <color-stop-list>)`
颜色节点 color-stop-list：`<color> [ <percentage> | <length> ]?`

两大要素：_渐变方向_、**颜色节点**

关于更加细节的理解可以尝试*sketch 中的渐变颜色设置*

需要注意的是，**元素边框的颜色并不支持**`linear-gradient()`，如果需要的话，可以通过设置`::before` 伪元素的背景为渐变来间接实现
