# lab2实验报告

> 整个项目从开始构思到最终实现，大概花了6个小时左右，从无到有实现了一个非常简陋的博客系统（实现了注册、登录、发布文章、查看文章、错误校验等功能），为了看到一些返回结果还特意跑去学了学前端相关的内容，最好终于是没啥bug的运行起来了hhh~
>
> $PLUS$：所有代码均已使用pep8+isort格式化，且命名规范**基本符合**django官方文档

其实暂时还没想好实验报告写啥，说明文档的话emm（这么简单的网页貌似不用写啥说明文档）

---

## 最终成果展示

### HOME

> 首页其实就是注册页（原本想放登录页的但是写好就懒的改了emmm）

![](https://gitee.com/ababa-317/image/raw/master/images/20220327210933.png)

最上方的是**导航栏**，所有页面都有，是直接通过`{% extends 'navbar.html' %}`实现的，在不同的状态下会跳转到不同的页面，未登录状态下（`request.session.has_key('id')=False`），点击PROFILE（个人主页）、POST（文章提交页）会默认跳转回HOME页

如果现在稍微注个册的话，比如随便输入点东西（错误示例，跳转到了Error页面）

![](https://gitee.com/ababa-317/image/raw/master/images/20220327211702.png)

## PROFILE

> 好了现在假设现在的时间线是注册成功（格式无误）的时间线，那么此时就会默认跳转到你的个人主页PROFILE

![image-20220327211857166](https://gitee.com/ababa-317/image/raw/master/images/image-20220327211857166.png)

首先是个人信息的一个展示，然后是你自己提交的所有文章列举。

假设现在去POST界面提交了几篇文章......

![image-20220327212311740](https://gitee.com/ababa-317/image/raw/master/images/image-20220327212311740.png)

界面就变成了上面这样，点击view可以前往相应的文章页面查看具体文章.

## ARTICLE

> 文章页面，实现比较简单，就是随便把文章的具体内容展示了一下

![image-20220327212156551](https://gitee.com/ababa-317/image/raw/master/images/image-20220327212156551.png)

## LOGIN

> 登录页面具体实现思路和HOME界面差不太多

![image-20220327212622706](https://gitee.com/ababa-317/image/raw/master/images/image-20220327212622706.png)

## LOGOUT

> LOGOUT按钮其实有点偷懒，因为实在是没时间学js，所以点击LOGOUT按钮就会直接清空session中的数据，并不会出现提醒（是否退出登录？是/否）啥的。

## 项目大体思路图

> 可能会和最终实现的项目有些出入（因为这是还没开始写的时候花的一个大体框架图）

![image-20220327213031698](https://gitee.com/ababa-317/image/raw/master/images/image-20220327213031698.png)

具体实现还是以代码为准啦~~

