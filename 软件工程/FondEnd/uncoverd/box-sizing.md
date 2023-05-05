# box-sizing

> 学习该属性，旨在解决页面底部导航栏的问题。

[CSS](https://developer.mozilla.org/en-US/docs/Web/CSS) 中的 **`box-sizing`** 属性定义了 [user agent](https://developer.mozilla.org/zh-CN/docs/Glossary/User_agent) 应该如何计算一个元素的总宽度和总高度。

在 [CSS 盒子模型](https://developer.mozilla.org/en-US/docs/Web/CSS/CSS_Box_Model/Introduction_to_the_CSS_box_model)的默认定义里，你对一个元素所设置的 [`width`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/width) 与 [`height`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/height) 只会应用到这个元素的内容区。如果这个元素有任何的 [`border`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/border) 或 [`padding`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/padding) ，绘制到屏幕上时的盒子宽度和高度会加上设置的边框和内边距值。这意味着当你调整一个元素的宽度和高度时需要时刻注意到这个元素的边框和内边距。当我们实现响应式布局时，这个特点尤其烦人。

box-sizing 属性可以被用来调整这些表现：

- `content-box` 是默认值。如果你设置一个元素的宽为 100px，那么这个元素的内容区会有 100px 宽，并且任何边框和内边距的宽度都会被增加到最后绘制出来的元素宽度中。
- `border-box` 告诉浏览器：你想要设置的边框和内边距的值是包含在 width 内的。也就是说，如果你将一个元素的 width 设为 100px，那么这 100px 会包含它的 border 和 padding，内容区的实际宽度是 width 减去 (border + padding) 的值。大多数情况下，这使得我们更容易地设定一个元素的宽高。

*<font color="green">Ps:</font>border-box不包含margin*

**Note:** 对于新的 web 站点，你可能希望首先将 box-sizing 设置为 border-box，如下所示：

```css
* { box-sizing: border-box; }
```

这使得处理元素大小的工作变得容易得多，并且通常消除了在布局内容时可能遇到的许多陷阱。然而，在某些情况下，你应谨慎使用这个属性。例如：你正在编写一个将由其他人使用的共享组件库，如果他们网站的其余部分没有设置此值，他们可能会发现很难使用你的组件库。