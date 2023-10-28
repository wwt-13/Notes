# 关于 grid 布局

> Grid 布局，是最强大的 CSS 布局方案，它将网页划分成一个个网格，可以任意组合不同的网格，做出各种各样的布局
>
> 如果和 flex 布局做对比的话，flex 布局适用于一维方面的布局，比如菜单栏，而 Grid 则适用于整个网页内容的布局，是二维布局，更加强大

-   Flex 布局属于轴线布局，只能指定“项目”针对轴线的位置
-   Grid 布局则是将容器划分为行和列，产生**单元格，然后指定项目所在的单元格**

和 flex 布局类似的，Grid 布局只对容器的*直接子元素*生效

```css
.container {
    display: grid;
    grid-template-columns: 100px 100px 100px;
    grid-template-rows: 100px 40px 100px;
}
```

通过设置`grid-template-columns`和`grid-template-rows`属性，指定网格的行数和列数，生成单元格，然后 Grid 布局会自动按顺序将子元素分别填入单元格中，这就是 Grid 布局的原理

如果觉的重复的值太麻烦，可以使用`repeat()`函数代替

```css
.container {
    display: grid;
    grid-template-columns: repeat(3, 100px);
    grid-template-rows: 100px 40px 100px;
}
```

> 懒得记了，直接看 [阮一峰的网络日志](https://www.ruanyifeng.com/blog/2019/03/grid-layout-tutorial.html) 吧
