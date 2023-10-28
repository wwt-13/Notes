# 关于 conic-gradient()

> 锥型渐变，`conic-gradient()` 创建一个由渐变组成的图像，渐变的颜色围绕一个中心点旋转（而不是从中心辐射）进行过渡

**如何消除颜色突变导致的射线：收尾颜色节点设置为相同颜色即可**

```css
/* 只需要相同，不需要递归也一样（递归只是让颜色过渡更顺滑） */
background: conic-gradient(
    from var(--gradient-angle),
    var(--clr-3),
    var(--clr-4),
    var(--clr-5),
    var(--clr-4),
    var(--clr-3)
);
```
