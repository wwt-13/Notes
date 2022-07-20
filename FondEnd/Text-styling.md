# Text-styling

> 记录css中文字样式的设定

## CSS Units

> css中的单位分为两种，绝对单位和相对单位
>
> 常见绝对单位：px、pt
>
> 常见相对单位：em、rem、vw、vh、%
>
> *<font color="red">Attention:</font>在ios开发中，pt是绝对像素点，而px则是相对像素单位，这和html开发中描述的会有出入*

- 开发中常用的属性`font-size(用于设定字体大小)`
- 网页默认字体大小`16px`

### 绝对单位

| Unit |     Definition      |                         Useage                         |
| :--: | :-----------------: | :----------------------------------------------------: |
| `px` | 1px = 1/96th of 1in | 对于只需要适配少部分手机设别，且分辨率对页面影响不大的 |
| `pt` | 1px = 1/72th of 1in |                           -                            |
|      |                     |                                                        |

### 相对单位

| Unit  |         Definition         |                            Useage                            |
| :---: | :------------------------: | :----------------------------------------------------------: |
| `em`  |   相对于父元素的字体大小   |                              -                               |
| `rem` | 相对于html根元素的字体大小 | 对于需要适配各种移动设备（例如需要适配iphone、ipad等分辨率差别较大的设备） |
| `vw`  |  1% of viewpoint’s width   |                                                              |
| `vh`  |  1% of viewpoint’s height  |                              -                               |
|  `%`  |  相对于parent元素的百分比  |                              -                               |
|       |                            |                                                              |

## Attributes

> 关于文字可以设定的各种属性

- `text-align`：用于设定文字居左（默认）、居中、居右
- `text-decoration`：用于设置文本的修饰线外观（下划线、上划线、贯穿线/删除线、闪烁等等，比较复杂，需要单独进行介绍）
- `line-heighe`：该属性用于设置多行元素的空间量，如多行文本的间距。对于块级元素，它指定元素行盒（line boxes）的最小高度。对于非[替代](https://developer.mozilla.org/en-US/docs/Web/CSS/Replaced_element)的 inline 元素，它用于计算行盒（line box）的高度
- `letter-spacing` ：该属性用于设置文本字符的间距表现
- `font-weight`：代表字体的粗细程度，regular是400
- `text-indent`：就是一段文本前面的了；留白，一般设为`32px`或者`2rem`

### text-decoration

> `text-decoration` 这个 CSS 属性是用于设置文本的修饰线外观的（下划线、上划线、贯穿线/删除线 或 闪烁）它是 [`text-decoration-line`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/text-decoration-line), [`text-decoration-color`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/text-decoration-color), [`text-decoration-style`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/text-decoration-style), 和新出现的 [`text-decoration-thickness`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/text-decoration-thickness) 属性的缩写
>
> *<font color="green">Ps:</font>如果要取消所有文本修饰线，直接设定`text-decoration:none;`即可*

text-decoration是简写属性，下面分别展示间歇和普通属性的两种书写区别（最好按照规范的line、color、style、thickness顺序来写）

```css
p {
    font-size: 40px;
    text-decoration: line-through aquamarine wavy 10px;
}
p {
    font-size: 40px;
    text-decoration-line: line-through;
    text-decoration-color: aquamarine;
    text-decoration-style: wavy;
    text-decoration-thickness: 10px;
}
```

#### text-decoration-line

|     style      |  explain   |
| :------------: | :--------: |
|     `none`     | 无文本效果 |
|  `underline`   |   下划线   |
|   `overline`   |   上划线   |
| `line-through` |   删除线   |
|                |            |

#### text-decoration-style

|  style   | explain |                           example                            |
| :------: | :-----: | :----------------------------------------------------------: |
| `solid`  |  实线   | ![image-20220714112856671](/Users/apple/Documents/Notes/assets/image-20220714112856671.png) |
| `double` | 双实线  | ![image-20220714112907809](/Users/apple/Documents/Notes/assets/image-20220714112907809.png) |
| `dotted` | 点划线  | ![image-20220714112919874](/Users/apple/Documents/Notes/assets/image-20220714112919874.png) |
| `dashed` |  虚线   | ![image-20220714112931628](/Users/apple/Documents/Notes/assets/image-20220714112931628.png) |
|  `wavy`  | 波浪线  | ![image-20220714112942334](/Users/apple/Documents/Notes/assets/image-20220714112942334.png) |

### font-family

> [cssfontstack—查看字体应用广泛程度](https://www.cssfontstack.com/)
>
> [googlefonts—字体大全](https://fonts.google.com/)

字体有两种设定方式：

1. 直接本地引入

   ![image-20220714130400826](/Users/apple/Documents/Notes/assets/image-20220714130400826.png)

   *<font color="green">Ps:</font>css字体的保护机制，默认从前向后读取字体，本地字体不存在的话则应用后序字体（大部分电脑使用）*

2. 从`googlefonts`网站引入

   ![vscode-googlefonts使用演示](/Users/apple/Documents/Notes/assets/vscode-googlefonts使用演示.gif)

### background

> 此属性是一个 [简写属性](https://developer.mozilla.org/zh-CN/docs/Web/CSS/Shorthand_properties)，可以在一次声明中定义一个或多个属性：[`background-clip`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/background-clip)、[`background-color`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/background-color)、[`background-image`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/background-image)、[`background-origin`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/background-origin)、[`background-position`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/background-position)、[`background-repeat`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/background-repeat)、[`background-size`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/background-size)，和 [`background-attachment`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/background-attachment)

- `background-clip` ：设置元素的背景（背景图片或颜色）是否延伸到边框、内边距盒子、内容盒子下面
- `background-color`：设置元素背景颜色
- `background-image`：设置一个或者多个背景图片，图像之间用*逗号*隔开，*绘制时按照z方向堆叠*，先指定的图像在背景上层（支持纯色、渐变色、图片等等）
- `background-origin`：略
- `background-position`：为每一个背景图片设置初始位置。这个位置是相对于由 [`background-origin`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/background-origin) 定义的位置图层的
- `background-repeat`：定义背景图像的重复方式。背景图像可以沿着水平轴，垂直轴，两个轴重复，或者根本不重复
- `background-size` 设置背景图片大小。图片可以保有其原有的尺寸，或者拉伸到新的尺寸，或者在保持其原有比例的同时缩放到元素的可用空间的尺寸。

#### background-clip

> `background-clip` 设置元素的背景（背景图片或颜色）是否延伸到边框、内边距盒子、内容盒子下面

|     style     |        explain         |                           example                            |
| :-----------: | :--------------------: | :----------------------------------------------------------: |
| `border-box`  |     背景延伸到边框     | ![image-20220714145711192](/Users/apple/Documents/Notes/assets/image-20220714145711192.png) |
| `padding-box` |  背景延伸到内边距盒子  | ![image-20220714145726696](/Users/apple/Documents/Notes/assets/image-20220714145726696.png) |
| `content-box` | 背景延伸到元素内容盒子 | ![image-20220714145736889](/Users/apple/Documents/Notes/assets/image-20220714145736889.png) |

##### 关于文字图片背景的实现

> 实现下面这幅文字背景图，需要使用css3的新属性`background-clip:text;`
>
> ![image-20220714145834342](/Users/apple/Documents/Notes/assets/image-20220714145834342.png)

1. 首先*文字本身*要设置为透明：`color: transparnt;`
2. 设置背景剪切为文本：`background-clip: text;`
3. 添加浏览器私有前缀来兼容其他浏览器：`-webkit-background-clip: text;`

```css
background-clip: text;
-webkit-background-clip: text;
color: transparent;
```

#### background-repeat

>  **`background-repeat`**属性定义背景图像的重复方式。背景图像可以沿着水平轴，垂直轴，两个轴重复，或者根本不重复

|  style   |                           explain                            |                           example                            |
| :------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| `repeat` | 图像会按需重复来覆盖整个背景图片所在的区域。最后一个图像会被裁剪，如果它的大小不合适的话 | ![image-20220714151907261](/Users/apple/Documents/Notes/assets/image-20220714151907261.png) |
| `space`  | 图像会尽可能得重复，但是不会裁剪。第一个和最后一个图像会被固定在元素 (element) 的相应的边上，同时空白会均匀地分布在图像之间. | ![image-20220714151921030](/Users/apple/Documents/Notes/assets/image-20220714151921030.png) |
| `round`  |   不理解和repeat的区别，整体感觉round的背景图片会更大一点    | ![image-20220714151934646](/Users/apple/Documents/Notes/assets/image-20220714151934646.png) |
|          |                                                              |                                                              |

*单值语法是完整的双值语法的简写*：在双值语法中，第一个值表示水平重复行为，第二个值表示垂直重复行为。

|  **单值**   |    **等价于双值**     |
| :---------: | :-------------------: |
| `repeat-x`  |  `repeat no-repeat`   |
| `repeat-y`  |  `no-repeat repeat`   |
|  `repeat`   |    `repeat repeat`    |
|   `space`   |     `space space`     |
|   `round`   |     `round round`     |
| `no-repeat` | `no-repeat no-repeat` |

#### background-position

> 为每一个背景图片设置初始位置。这个位置是相对于由 [`background-origin`](https://developer.mozilla.org/zh-CN/docs/Web/CSS/background-origin) 定义的位置图层的

五种基本模式：top、bottom、left、right、center（字面意思）

x-y轴模式：`background-position: x坐标 y坐标`

基本+距离模式：`background-position: 轴1 距离轴1的距离 轴2 距离轴2的距离`

#### background-size

> `background-size` 设置背景图片大小。图片可以保有其原有的尺寸，或者拉伸到新的尺寸，或者在保持其原有比例的同时缩放到元素的可用空间的尺寸。
>
> *<font color="green">Ps:</font>建议配合background-repeat使用*

|   style   |                           explain                            |                           example                            |
| :-------: | :----------------------------------------------------------: | :----------------------------------------------------------: |
| `contain` | 缩放背景图片以完全装入背景区，可能背景区部分空白。`contain` 尽可能的缩放背景并保持图像的宽高比例（图像不会被压缩） | ![image-20220714153838879](/Users/apple/Documents/Notes/assets/image-20220714153838879.png) |
|  `cover`  |    缩放背景图片以完全覆盖背景区，可能背景图片部分看不见。    | ![image-20220714153851608](/Users/apple/Documents/Notes/assets/image-20220714153851608.png) |
|  `auto`   |                   以图片背景的比例缩放图片                   |                              -                               |
| `50% 40%` |      按照背景区域的百分比设定背景图片，空缺值设置为auto      | ![image-20220714154113052](/Users/apple/Documents/Notes/assets/image-20220714154113052.png) |

