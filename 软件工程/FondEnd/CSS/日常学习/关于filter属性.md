# 关于 filter 属性

> CSS filter 属性用于将模糊或颜色偏移等图形效果应用于元素。通常用于调整图像、背景和边框的渲染
>
> filter 又叫滤镜

## blur()

> 将高斯模糊应用于输入图像
>
> 语法 etc：`filter: blur(5px);`

## drop-shadow()

> 将投影应用于图像，该投影实际上是输入图像的 alpha 蒙版的一个模糊+偏移的版本
>
> 和 box-shadow 的区别在于 box-shadow 的阴影应用对象是元素的框

```css
div {
    filter: box-shadow(offset-x offset-y blur-radius [spread-radius] color);
}
```

-   `offset-x` 指定水平距离，其中负值将阴影放置到元素的左侧。`offset-y` 指定垂直距离，其中负值将阴影置于元素之上。如果两个值都为 0，则阴影直接放置在元素后面
-   `blur-radius`指定阴影的模糊半径，值越大，阴影越大，也越模糊
-   `spread-radius`指定阴影的扩展半径，大部分浏览器还不支持一般不写也不用管
-   `color`指定阴影的颜色，如果省略，则继承使用元素的 `color` 属性的值
-   不能设置 `inset`（废话都是蒙版了哪来的 inset）
