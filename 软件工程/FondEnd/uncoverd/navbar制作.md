# navbar制作

## 目前使用的navbar样式

```css
/* 开发技巧：需要的时候再自定义padding和margin */
* {
    padding: 0;
    margin: 0;
    box-sizing: border-box;
}
header {
    background-color: #cee5d0;
    width: 100%;
    padding: 1rem;
}
nav {
    background-color: #94b49f;
    /* 自定义字体 */
    font-family: "Zhi Mang Xing", cursive;
    font-size: 1.5rem;
}
nav ul {
    list-style-type: none;
    /* 设置为弹性container */
    display: flex;
    /* 设置菜单栏方向 */
    flex-direction: row;
}
nav ul li {
    /* 设置li为flex container，这一步的目的是为了使得a标签能够填充li标签 */
    display: flex;
    /* 使得li标签可以随页面大小延展 */
    flex-grow: 1;
}
nav ul li a {
    /* 设置文字居中 */
    text-align: center;
    padding: 0.5rem 0.75rem;
    /* 取消文字样式 */
    text-decoration: none;
    color: white;
    /* 使宽度填充 */
    flex-grow: 1;
    /* 设置动画效果 */
    transition: all 1s ease;
}
nav ul li a:hover {
    background-color: #FCF8E8;
    color: #ECB390;
}
p{
    /* 设置段首空格 */
    text-indent: 2rem;
}
```

