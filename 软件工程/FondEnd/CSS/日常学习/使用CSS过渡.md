# 关于 CSS transition 属性

> transition 属性是 CSS3 中的一个新属性，用于设置元素的过渡效果，可以让元素的*某个属性值*在*一定时间*内*平滑地*过渡到另一个值
>
> 详细的说：CSS 过渡决定了**哪些属性发生动画效果**、**何时开始**（设置延时）、**持续多久**（设置时长）、**如何动画**（定义缓动函数）

```css
div {
    transition: <property> <duration> <timing-function> <delay>;
}
```
