# Reseponsive Web Design

> 以下是对RWD（响应式网页设计）的名词解释：
>
> *Responsive web design is about creating web pages that look good on all devices!*
>
> *A responsive web design will automatically adjust for different screen sizes and viewports.*
>
> 简单来说，RWD就是要求我们去设计在各种不同的设备上都能完美显示的网页
>
> ![img_temp_band](https://www.w3schools.com/css/img_temp_band.jpg)

## RWD原则

> 1. 能用`flexbox`处理，就用`flexbox`处理
> 2. 不能用`flexbox`处理，就用`media query`处理

## media query

> **媒体查询**（**Media queries**）非常实用，尤其是当你想要根据设备的大致类型（如打印设备与带屏幕的设备）或者特定的特征和设备参数（例如屏幕分辨率和浏览器[视窗](https://developer.mozilla.org/zh-CN/docs/Glossary/Viewport)宽度）来修改网站或应用程序时。
>
> 常用语调整不同分辨率下网页的菜单栏等等
>
> [教程网站](https://developer.mozilla.org/zh-CN/docs/Web/CSS/Media_Queries/Using_media_queries)

```css
@media screen and (max-width:1080px){...}
/* 仅当屏幕宽度小于等于1080px的时候，浏览器才会应用此样式 */
@media screen and (max-width: 800px){
    h1{
        background-color: orange;
    }
}
```