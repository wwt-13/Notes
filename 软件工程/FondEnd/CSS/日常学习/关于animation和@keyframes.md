# 关于 animation 和@keyframes

## animation

> 注：这暂时还是一项实验性技术(但貌似除了 Opear-mini 之外的浏览器之外都支持了)
>
> CSS animations 使得可以将从一个 CSS 样式配置转换到另一个 CSS 样式配置。动画包括两个部分：描述动画的样式规则和用于指定动画开始、结束以及中间点样式的关键帧。
>
> 需要注意的是，CSS animations 指定的是动画的相关配置，_实际动画序列是由@keyframes 定义的_

优点如下 👇🏻

1. 能够非常容易地创建简单动画，你甚至不需要了解 JavaScript 就能创建动画。
2. 动画运行效果良好，甚至在低性能的系统上。渲染引擎会使用跳帧或者其他技术以保证动画表现尽可能的流畅。而使用 JavaScript 实现的动画通常表现不佳（除非经过很好的设计）。
3. 让浏览器控制动画序列，允许浏览器优化性能和效果，如降低位于隐藏选项卡中的动画更新频率。

```css
div {
    animation: animation-name animation-duration animation-timing-function animation-delay animation-iteration-count
        animation-direction animation-fill-mode animation-play-state;
}
```

-   `animation-name`：指定要绑定到选择器的 keyframe 名称
-   `animation-duration`：指定完成动画所花费的时间，以秒或毫秒为单位
-   `animation-timing-function`：指定动画的速度曲线
-   `animation-delay`：指定动画何时开始
-   `animation-iteration-count`：指定动画应该播放的次数，设置为`infinite`即可重复播放
-   `animation-direction`：指定动画是否应该反向播放
    -   `normal`: 每次动画循环时，动画将重置为起始状态并重新开始
    -   `reverse`: 每次动画循环时，动画将重置为结束状态并重新开始(时间函数也会被反转)
    -   `alternative`: 动画在每个循环中正反交替播放，第一次迭代是正向播放
    -   `alternative-reverse`: .....
-   `animation-fill-mode`：指定对象动画时间之外的状态
-   `animation-play-state`：指定动画是否正在运行或已暂停,running or paused,需要注意的是从 paused 状态切换到 running 状态时，动画会从当前位置继续播放，而不是从头开始

## @keyframes

> 完成动画属性相关设置后，就需要对动画的序列进行设置了
>
> 通过使用`@keyframes` 建立两个或两个以上关键帧来实现。每一个关键帧都描述了动画元素在给定的时间点上应该如何渲染
>
> 关键帧使用<percentage>来指定时间点，或者使用`from`和`to`关键字来指定起始和结束点

```css
@keyframes rotation {
    0% {
        --gradient-angle: 0deg;
    }
    100% {
        --gradient-angle: 360deg;
    }
}
```
