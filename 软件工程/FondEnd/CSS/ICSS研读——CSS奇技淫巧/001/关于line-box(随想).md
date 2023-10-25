# 关于 line-box

> 在学习“左边框的多种实现样式”时发现的问题 👇🏻
>
> 如果对某个 div 设置了::before，并且在::before 内设置其 border 为 0.5rem，最终通过浏览器开发者工具会发现该::before 元素的高度要远远大于 1rem（Chrome 中是 38.5px），于是就想知道这多出来的 22.5px 是从哪里来的呢？

思考发现伪元素和直接在 div 开头添加<span></span>的行为完全一致，查了资料发现果然如此，`::before`和`::after`的元素行为就等价于行内元素的元素行为

因此，这个问题就变成了：**行内元素的高度是如何计算的？**

直接写了一个不带高度的<span></span>，发现其高度正好为 22.5px，这下好了，问题解决了，就是行内元素内嵌的`line-box`搞的鬼

```css
#m2::before {
    content: '1';
    /* height: 2rem; */
    border: 0.5rem solid deeppink;
    /* position: absolute; */
}
#m3 > span {
    border: 1rem solid deeppink;
}
```
