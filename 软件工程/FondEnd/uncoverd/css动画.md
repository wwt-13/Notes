# css动画

## transition

> transition（转场），该属性是 [`transition-property`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/transition-property)，[`transition-duration`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/transition-duration)，[`transition-timing-function`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/transition-timing-function) 和 [`transition-delay`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/transition-delay) 的一个[简写属性](https://developer.mozilla.org/en-US/docs/Web/CSS/Shorthand_properties)。
>
> transition可以为一个元素在不同状态之间切换的时候定义不同的过渡效果。像是 [`:hover`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/:hover)，[`:active`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/:active) 或者通过 JavaScript 实现的状态变化。
>
> CSS transitions 可以决定*哪些属性*发生动画效果 (明确地列出这些属性)，*何时开始* (设置 delay），*持续多久* (设置 duration) 以及*如何动画* (定义*timing function*，比如匀速地或先快后慢)。

语法格式与部分基本效果演示（多属性转换以`,`隔开即可）

*<font color="red">Attention:</font>:不可以将不同属性的transition分开写，因为后面的transition会覆盖前面的transition*

|                     syntax                     |                     style                     |                           explain                            |                           example                            |
| :--------------------------------------------: | :-------------------------------------------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
|           `property name |duration`            |        `transition: margin-right 2s;`         |               将margin-right属性的变化延长到2s               | ![vscode-transition演示1](/Users/wwt13/Documents/Notes/assets/vscode-transition演示1.gif) |
|         `property name|duration|delay`         |       `transition: margin-right 2s 1s;`       |   将margin-right属性的变化延长到2s，并且该变化延迟一秒发生   | ![vscode-transition演示2](/Users/wwt13/Documents/Notes/assets/vscode-transition演示2.gif) |
| `property name|duration|timing function|delay` | `transition: margin-right 2s ease-in-out 1s;` | 将margin-right属性的变化延长到2s，延迟1s发生，并且过渡式的时间动画效果为ease-in-out | ![vscode-transition演示3](/Users/wwt13/Documents/Notes/assets/vscode-transition演示3.gif) |
|                 `all|duration`                 |              `transition:all 2s`              |                    所有属性的变化延长到2s                    |                              -                               |
|                                                |                                               |                                                              |                                                              |

## 2D transform

> **`transform`**属性允许你旋转`rotate()`，缩放`scale()`，倾斜或平移`translate()`给定元素。这是通过修改 CSS 视觉格式化模型的坐标空间来实现的

### translate

> **`translate`** 允许你单独声明平移变换，并独立于 [`transform`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/transform) 属性。这在一些典型的用户界面上更好用，而且这样就无需在 `transform` 中声明该函数并记住转换函数的确切顺序了

- Syntax1：`transform:translate(lengthX,lengthY)`
- Syntax2：`translate(lengthX,lengthY)`

#### 问题：如何实现元素居中？

> 分为几种不同的实现需求：
>
> 1. 按照实现对象可以分为块级元素、行内元素、inline-block元素
> 2. 按照实现效果可以分为水平居中、垂直居中和水平垂直居中。
>
> 参考文章：[CSS-水平居中、垂直居中、水平垂直居中](https://segmentfault.com/a/1190000014116655)

##### 水平居中

> 这里行内元素是指文本text、图像img、按钮超链接等

- 行内元素水平居中：设置text-align: center;即可
- 块级元素水平居中
  1. 给需要居中的块级元素添加`margin: 0 auto`，需要注意的是必须设置块级元素的width

##### 水平垂直居中

> 关键是块级元素如何设置水平垂直居中

1. 绝对定位+margin:auto;

   ```css
   div{
       /* parent元素需设置成非static */
       position:absolute;
       left:0;
       top:0;
       bottom:0;
       right:0;
       margin: auto;
   }
   ```

2. 绝对定位+设置transform

   ```css
   div{
       position: absolute;
       left: 50%;
       top: 50%;
       transform: translate(-50%,-50%)
   }
   ```

### rotate

> **`rotate()`**函数定义了一种将元素围绕一个定点（由[`transform-origin`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/transform-origin)属性指定）旋转而不变形的转换。指定的角度定义了旋转的量度。若角度为正，则顺时针方向旋转，否则逆时针方向旋转。旋转 180°也被称为点反射。

#### transform-origin

> 该属性让你更改一个元素变形的原点，一般和rotate配合使用

几种常见设定演示

![vscode-transform-origin演示](/Users/apple/Documents/Notes/assets/vscode-transform-origin演示.gif)

----

```css
div{
    transform-origin: center;
    /* 绕中心点，顺时针旋转123度 */
    transform: rotate(123deg);
}
```

### scale

> `scale()` 用于修改元素的大小。可以通过向量形式定义的缩放值来放大或缩小元素，同时可以在不同的方向设置不同的缩放值

```css
div{
    /* x方向放大两倍，y方向放大3倍，并且默认按照中心点进行放大 */
    scale(2,3);
}
```

## 3D transform

> 三种需要认识的3D旋转
>
> - rotateX
> - rotateY
> - rotateZ
>
> 总的来说就是分别绕x，y，z轴进行旋转，语法格式和rotate完全一致

## Animation

> **animation** 属性是 [`animation-name`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/animation-name)，[`animation-duration`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/animation-duration), [`animation-timing-function`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/animation-timing-function)，[`animation-delay`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/animation-delay)，[`animation-iteration-count`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/animation-iteration-count)，[`animation-direction`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/animation-direction)，[`animation-fill-mode`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/animation-fill-mode) 和 [`animation-play-state`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/animation-play-state) 属性的一个简写属性形式。

如何自定义一个动画效果+基本animation格式设定

```css
div.container {
    width: 500px;
    height: 500px;
    background-color: black;
    position: relative;
}
div.box {
    margin: auto;
    width: 100px;
    height: 100px;
    background-color: aqua;
    position: absolute;
    /* 动画名 */
    animation-name: cross;
    /* 动画持续时间 */
    animation-duration: 4s;
    /* 动画类型 */
    animation-timing-function: ease-in-out;
    /* 动画延迟时间 */
    animation-delay: 1s;
    /* 动画持续次数，infinite代表永久 */
    animation-iteration-count: 2;
    /* 动画执行方向，alternate代表往返执行，reverse代表反向执行 */
    animation-direction: alternate;
    /* 动画执行完毕的状态，forwords代表定格在动画执行结束的时候 */
    animation-fill-mode: forwards;

}
@keyframes cross {
    from {
        background-color: aqua;
        top: 0;
        left: 0;
    }
    to {
        background-color: red;
        top: 400px;
        left: 400px;
    }
}
```

