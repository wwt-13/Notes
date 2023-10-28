# 关于 border、background-color 和 background-image

> 这里需要注意的是它们的范围

-   `border`：只是边框
-   `background-color`：是从元素边框的左上角起到右下角为止
-   `background-image`：见下文

## 关于 background-image

-   `background-origin`：指定了背景图片开始绘制的位置，默认为`padding-box`，也就是从 padding 的左上角开始绘制;如果设置为`border-box`，则从 border 的左上角开始绘制;如果设置为`content-box`，则从 content 的左上角开始绘制
-   `background-clip`：指定了背景图片绘制的范围，默认为`border-box`，也就是绘制到 border 的边缘;如果设置为`padding-box`，则绘制到 padding 的边缘;如果设置为`content-box`，则绘制到 content 的边缘
