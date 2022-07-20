# Jekyll入门

## Jekyll的基本逻辑

> `Jekyll` 的核心其实是一个文本转换引擎。它的概念其实就是：你用你最喜欢的标记语言来写文章，可以是 `Markdown`, 也可以是 `Textile`, 或者就是简单的 `HTML`, 然后 `Jekyll` 就会帮你套入一个或一系列的布局中。在整个过程中你可以设置 `URL` 路径，你的文本在布局中的显示样式等等。这些都可以通过纯文本编辑来实现，最终生成的静态页面就是你的成品了。

## Jekyll基本目录结构

```shell
.
├── _config.yml 	
├── _drafts		    
|   ├── begin-with-the-crazy-ideas.textile
|   └── on-simplicity-in-technology.markdown
├── _includes
|   ├── footer.html
|   └── header.html
├── _layouts
|   ├── default.html
|   └── post.html
├── _posts
|   ├── 2007-10-29-why-every-programmer-should-play-nethack.textile
|   ├── 2008-11-29-why-every-programmer-should-play-nethack.textile
|   └── 2022-04-26-barcamp-boston-4-roundup.md
├── _site
├── .jekyll-metadata
└── index.html
```

|                      文件/目录                       |                             描述                             |
| :--------------------------------------------------: | :----------------------------------------------------------: |
|                    `_config.yml`                     | **保存[配置](http://jekyllcn.com/docs/configuration/)数据**。很多配置选项都可以直接在命令行中进行设置，但是如果你把那些配置写在这儿，你就不用非要去记住那些命令了。 |
|                      `_drafts`                       | drafts（**草稿**）是未发布的文章。这些文件的格式中都没有 `title.MARKUP` 数据。学习如何 [使用草稿](http://jekyllcn.com/docs/drafts/). |
|                     `_includes`                      | <u>你可以加载这些包含部分到你的布局或者文章中以方便重用</u>。可以用这个标签 `{% include file.ext %}` 来把文件 `_includes/file.ext` 包含进来。 |
|                      `_layouts`                      | **layouts（布局）是包裹在文章外部的模板**。布局可以在 [YAML 头信息](http://jekyllcn.com/docs/frontmatter/)中根据不同文章进行选择。 这将在下一个部分进行介绍。标签 `{{ content }}` 可以将content插入页面中。 |
|                       `_posts`                       | 这里放的就是你的文章了。文件格式很重要，必须要符合: `YEAR-MONTH-DAY-title.MARKUP`。 [永久链接](http://jekyllcn.com/docs/permalinks/) 可以在文章中自己定制，但是数据和标记语言都是根据文件名来确定的。 |
|                       `_data`                        | 格式化好的网站数据应放在这里。jekyll 的引擎会自动加载在该目录下所有的 yaml 文件（后缀是 `.yml`, `.yaml`, `.json` 或者 `.csv` ）。这些文件可以经由 ｀site.data｀ 访问。如果有一个 `members.yml` 文件在该目录下，你就可以通过 `site.data.members` 获取该文件的内容。 |
|                       `_site`                        | 一旦 Jekyll 完成转换，就会将生成的页面放在这里（默认）。最好将这个目录放进你的 `.gitignore` 文件中。 |
|                  `.jekyll-metadata`                  | 该文件帮助 Jekyll 跟踪哪些文件从上次建立站点开始到现在没有被修改，哪些文件需要在下一次站点建立时重新生成。该文件不会被包含在生成的站点中。将它加入到你的 `.gitignore` 文件可能是一个好注意。 |
| `index.html` and other HTML, Markdown, Textile files | 如果这些文件中包含 [YAML 头信息](http://jekyllcn.com/docs/frontmatter/) 部分，Jekyll 就会自动将它们进行转换。当然，其他的如 `.html`, `.markdown`, `.md`, 或者 `.textile` 等在你的站点根目录下或者不是以上提到的目录中的文件也会被转换。 |
|                 Other Files/Folders                  | 其他一些未被提及的目录和文件如 `css` 还有 `images` 文件夹， `favicon.ico` 等文件都将被完全拷贝到生成的 site 中。这里有一些[使用 Jekyll 的站点](http://jekyllcn.com/docs/sites/)，如果你感兴趣就来看看吧。 |



## 环境配置

> 首先创建一个官方模板用于个人学习使用

```shell
jekyll new jekyll_for_learn
bundle exec jekyll server # 构建本地静态页面
```

- `jekyll build`：构建静态网页，但是不会部署到本地服务器上。