# 关于绝对定位元素

> 同样是今天学习"左边框的多种实现方式"发现的问题
>
> 如果讲::before 设置 position: absolute 之后，它居然能设置 height 了！！！
> 当时就绷不住了，一个 inline 元素 tm 的能设置高度 😅
>
> 参考：https://www.cnblogs.com/lianghong/p/8022911.html

**结论**：`position: absolute`和`float`会隐式地改变 display 类型为 block，这进而导致了宽高有效

```css
#m2 {
    position: relative;
}
#m2::before {
    content: '';
    /* height: 2rem;hei无效，因为::before等价行内元素 */
    border: 0.5rem solid deeppink;
    position: absolute;
}
#m3 {
    position: relative;
}
#m3 > span {
    height: 2rem;
    border: 0.5rem solid deeppink;
    position: absolute;
}
```
