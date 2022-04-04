[toc]

# HTML Beginner Tutorial

> The primary thing to keep in mind, is that ==HTML is used for the structure== and ==CSS is user for presentation==. 
>
> HTML is nothing more than fancy structured content and the visual formatting of that content will come later when we tackle CSS.

## Tags

> The basic structure of an HTML document includes tags, which **surround content** and **apply meaning** to it.

You can compared the two HTML files as follows. 

```html
This is my first web page.
```

```html
<!DOCTYPE html>
<html>
    <body>
        This is my first web page.
    </body>
</html>
```

The apperence of these two pages doesn't differ at all, but the purpose of HTML tags is to apply meaning.

The first line on the top, `<!DOCYPE html>` is a **document type declaration** and it lets the browser know which flavor of HTML you're using (HTML5, in this case).  It's very important to stick this in, else browser will assume you don't really what you're doing and render page in a very peculiar way.

To get back to the point, `<html>` is the **opening tag** that kicks things off and tells the browser that everything between that and the `</html>` **closing tag** is an HTML document. The stuff between `<body>` and `</body>` is the main content of the document that will appear in the browser window.

Not all tags have closing tags, like `<br>` - a line break doesn't hold anything so the tag merrily sits by its lonly self. I will come accross these later, all you need to remember now is that all tags with content between them should be closed.

### Paragraphs

> The web browsers don't usually take any notice of what line your code is on. It alse doesn't take any notice of spaces
>
> So if you want text to appear on different lines or, rather, if you intend there to be two distinct block of text, you should use `<p>` tags surrround your elements.

![](https://gitee.com/ababa-317/image/raw/master/images/20220402163849.png)

Look at the results of this. The two lines will now appear on two lines because the browser recognizes them as separate paragraphs.

#### $Emphasis$

> You can emphasize text in a paragraph using `<em></em>`(emphasis) and `<strong></strong>`(strong importance).
>
> These tags can be used outside.

```html
<p>This is paragraph <em>one</em>.</p>
<p>This is paragraph <strong>two</strong>.</p>
<strong>Test for strong out of p tags</strong>
```

![image-20220402164430470](https://gitee.com/ababa-317/image/raw/master/images/image-20220402164430470.png)

#### $Line\ breaks$

> The line-break tag can also be used to separate lines like this.

```html
This is my first web page<br>
How exiting.
```

It could be tempting to **over-use line breaks** and [`br`](https://htmldog.com/references/html/tags/br/) shouldn’t be used if two blocks of text are intended to be separate from one another (because if that’s what you want to do you probably want the [`p`](https://htmldog.com/references/html/tags/p/) tag).

### Headings

> The p tag is just the start of text formatting.
>
> If you have documents with genuine headings, then there are HTML tags specifically designed just for them.
>
> They are [`h1`](https://htmldog.com/references/html/tags/h1h2h3h4h5h6/), [`h2`](https://htmldog.com/references/html/tags/h1h2h3h4h5h6/), [`h3`](https://htmldog.com/references/html/tags/h1h2h3h4h5h6/), [`h4`](https://htmldog.com/references/html/tags/h1h2h3h4h5h6/), [`h5`](https://htmldog.com/references/html/tags/h1h2h3h4h5h6/) and [`h6`](https://htmldog.com/references/html/tags/h1h2h3h4h5h6/), [`h1`](https://htmldog.com/references/html/tags/h1h2h3h4h5h6/) being the almighty emperor of headings and [`h6`](https://htmldog.com/references/html/tags/h1h2h3h4h5h6/) being the lowest pleb.

```html
<h1>h1</h1>
<h2>h2</h2>
<h3>h3</h3>
<h4>h4</h4>
<h5>h5</h5>
<h6>h6</h6>
```

<img src="https://gitee.com/ababa-317/image/raw/master/images/20220402165215.png" style="zoom:33%;" />

Note that the [`h1`](https://htmldog.com/references/html/tags/h1h2h3h4h5h6/) tag is only used once, as the main heading of the page. [`h2`](https://htmldog.com/references/html/tags/h1h2h3h4h5h6/) to [`h6`](https://htmldog.com/references/html/tags/h1h2h3h4h5h6/), however, can be used as often as desired, but they should always be used in order, as they were intended. For example, an [`h4`](https://htmldog.com/references/html/tags/h1h2h3h4h5h6/) should be a sub-heading of an [`h3`](https://htmldog.com/references/html/tags/h1h2h3h4h5h6/), which should be a sub-heading of an [`h2`](https://htmldog.com/references/html/tags/h1h2h3h4h5h6/).

==Size doesn't matter==: you can make headings any size you want with CSS

<img src="https://gitee.com/ababa-317/image/raw/master/images/20220402165617.png" style="zoom:33%;" />

### Lists

> There are three types of list; **unordered lists**, **ordered lists** and definition lists. We will look at the first two here.
>
> Unordered lists and ordered lists **work the same way,** except that the former is used for non-sequential lists with list items usually preceded by bullets and the latter is for sequential lists, which are normally represented by incremental numbers.
>
> The [`ul`](https://htmldog.com/references/html/tags/ul/) tag is used to define unordered lists and the [`ol`](https://htmldog.com/references/html/tags/ol/) tag is used to define ordered lists. Inside the lists, the [`li`](https://htmldog.com/references/html/tags/li/) tag is used to define each list item.

```html
<ul>
    <li>To learn HTML</li>
    <li>To learn CSS</li>
    <li>To learn JavaScript</li>
</ul>
<ol>
    <li>To learn HTML</li>
    <li>To learn CSS</li>
    <li>To learn JavaScript</li>
</ol>
```

<img src="https://gitee.com/ababa-317/image/raw/master/images/20220402173343.png" style="zoom:45%;" />

### Links

> So far we have made a stand-alone web page, which is all very well and nice, but what makes the Internet so special is that it all **links** together.
>
> An **anchor** tag ([`a`](https://htmldog.com/references/html/tags/a/)) is used to define a link, but you also need to add something to the anchor  tag — the **destination** of the link.

```html
<p><a href="https://www.baidu.com">This is anchor tag to baidu.com</a></p>
```

<img src="https://gitee.com/ababa-317/image/raw/master/images/image-20220402174020069.png" alt="image-20220402174020069" style="zoom:67%;" />

### Images

The img tag is used to put an image in an HTML document and it looks like this:

```html
<img src="http://www.htmldog.com/badge1.gif" width="120" height="90" alt="HTML Dog">
```

The **src** attribute tells the browser where to find the image. It can be absolute but is usually relative. And src not only support images, but also ==support gif and .mp4==!!

**The width and height attributes are necessary** because if they are excluded, the browser will tend to calculate the size as the image loads, instead of  when the page loads, which means that the layout of the document may jump around while the page is loding.

The alt attributes is the **alternative description** when the image failed to load, it provide meaningful info for users.

#### $Somthing\ about\ image$

> The construction of images for the web is a little outside of the remit of this website, but **it is worth noting a few things**…
>
> The most commonly used file formats used for images are **JPEGs**, **GIFs**, and **PNGs**. They are compressed formats, and have very different uses.
>
> A JPEG (pronounced “jay-peg”) uses a mathematical algorithm to compress the image and will distort the original slightly. The lower the compression, the higher the file size, but the clearer the image.
>
> ==**JPEGs are typically used for images such as photographs.**==
>
> A GIF (pronounced “jif”) can have no more than 256 colors, but they maintain the colors of the original image. The lower the number of colors you have in the image, the lower the file size will be. GIFs also allow any pixel in the image to be transparent.
>
> ==**GIFs are typically used for images with solid colors, such as icons or logos.**==
>
> A PNG (pronounced “ping”) replicates colors, much like a GIF, but allows 16 million colors as well as alpha transparency (that is, an area could be 50% transparent).
>
> ==**PNGs are typically used for versatile images in more complex designs BUT they are not fully supported by some older browsers.**==
>
> The web is forever getting faster and faster but you obviously want your web pages to download as quickly as possible. Using super-high resolution images isn’t doing your or your user’s bandwidth (or patience) any favors. ==Image compression is a great tool and you need to strike a balance between image quality and image size.== Most modern image manipulation programs allow you to compress images and the best way to figure out what is best suited for yourself is trial and error.

### Tables

> HTML tables are still best known for being used and abused to lay out pages.
>
> The correct use for tables is to do exactly what you would expect a table to do — to **structure tabular**
>
> There are a number of tags used in tables, and to fully get to grips with how they work is probably the most difficult area of this HTML Beginner Tutorial.

```html
<table border="2px">
    <tr>
        <td>Row 1, cell 1</td>
        <td>Row 1, cell 2</td>
        <td>Row 1, cell 3</td>
    </tr>
    <tr>
        <td>Row 2, cell 1</td>
        <td>Row 2, cell 2</td>
        <td>Row 2, cell 3</td>
    </tr>
    <tr>
        <td>Row 3, cell 1</td>
        <td>Row 3, cell 2</td>
        <td>Row 3, cell 3</td>
    </tr>
    <tr>
        <td>Row 4, cell 1</td>
        <td>Row 4, cell 2</td>
        <td>Row 4, cell 3</td>
    </tr>
</table>
```

<img src="https://gitee.com/ababa-317/image/raw/master/images/image-20220402205931440.png" alt="image-20220402205931440" style="zoom:67%;" />

The table element defines the table.

The tr element defines the row

The td element defines a data cell, **these must be enclosed in tr tags**.

### Forms

> **Forms** are used to collect data inputted  by a user. They can be used as an interface for a web application, for example, or to send data across the web.
>
> > On their own, forms aren’t usually especially helpful. They tend to be used in conjunction with a programming language to process the information inputted by the user. These scripts take all manner of guises that are largely outside of the remit of this website because they require languages other than HTML and CSS.
> >
> > Forms should be used with other languages.
>
> The basic tags used in the actual HTML of forms are [`form`](https://htmldog.com/references/html/tags/form/), [`input`](https://htmldog.com/references/html/tags/input/), [`textarea`](https://htmldog.com/references/html/tags/textarea/), [`select`](https://htmldog.com/references/html/tags/select/) and [`option`](https://htmldog.com/references/html/tags/option/).

#### $form$

> [`form`](https://htmldog.com/references/html/tags/form/) defines the form and within this tag, if you are using a form for a user to submit information (which we are assuming at this level), an `action` attribute is needed to tell the form where its contents will be sent to.
>
> The= `method`= attribute tells the form how the data in it is going to be sent and it can have the value `get`, which is default, and latches the form information onto a web address, or `post`, which (essentially) invisibly sends the form’s information.
>
> > `get` is used for shorter chunks of non-sensitive information - you might see the information you have submitted in a web site’s search to appear in the web address of its search results page, for example. `post` is used for lengthier, more secure submissions, such as in contact forms.

#### $input$

> The input tag is the daddy of the form world. It can take a multitude guises, the most common of which are outlined below.

- `<input type="text">` or simply `<input>` is a standard textbox. This can also have a `value` attribute, which **sets the initial text** in the textbox.

- `<input type="password">` is similar to the textbox, but the characters typed in by the user will be **hidden**.

- `<input type="checkbox">` is a checkbox, which can be toggled on and off by the user. This can also have a `checked` attribute (`<input type="checkbox" checked>` - the attribute doesn’t require a value), and makes the initial state of the check box to be switched on, as it were.

- `<input type="radio">` is similar to a checkbox, but the user can **only select one radio** button in a group. This can also have a `checked` attribute.

  You can use the "name" attributes to organize a radio button group section.

- `<input type="submit">` is a button that when selected will submit the form. You can control the text that appears on the submit button with the `value` attribute, for example `<input type="submit" value="Ooo. Look. Text on a button. Wow">`.

#### $textarea$

> textarea is , basically, a large, multi-line textbox. The anticipated number of rows and columns can be defined with rows and cols attributes, although you can manipulate the size to your heart's content with the **CSS**.
>
> Any text you choose to place between the opening and closing tags (in this case “a big load of text”) will form **the initial value of the text area**.

```html
<textarea rows="5" cols="20">A big load of text</textarea>
```

#### $select$

> The select tag works with the option tag to make drop-down select boxes
>
> When the form is submitted, the value of the selected option will be sent. **This value will be the text between the selected opening and closing tag unless ann explicit value is specified with the value attribute**.
>
> Similar to the `checked` attribute of checkboxes and radio buttons, an [`option`](https://htmldog.com/references/html/tags/option/) tag can also have a `selected` attribute, to start off with one of the items already being selected, eg. `<option selected>Rodent</option>` would pre-select “Rodent” from the items.

```html
<select>
    <option>Option1</option>
    <option>Option2</option>
    <option selected>Option3</option>
    <option value="Fourth Option">Option4</option>
</select>
```

#### $Names$

> All of tags metioned above will look very nice presented on the page but if you hook up your form to a form-handling script, they will all be ignored. This is because the form fields need **names**. So to all of the fields, the attribute name needs to be added, for example`<input type="text" name="talkingsponge">`

A contact form for Noah’s Ark, for example, might look something like the one below. (Note: *this form will not work unless there is a “contactus.php” file, which is stated in the action attribute of the form tag, to handle the submitted data*).

```html
<form action="contactus.php" method="post">

    <p>Name:</p>
    <p><input type="text" name="name" value="Your name"></p>

    <p>Species:</p>
    <p><input name="species"></p>
    <!-- remember: 'type="text"' isn't actually necessary -->

    <p>Comments: </p>
    <p><textarea name="comments" rows="5" cols="20">Your comments</textarea></p>

    <p>Are you:</p>
    <p><input type="radio" name="areyou" value="male"> Male</p>
    <p><input type="radio" name="areyou" value="female"> Female</p>
    <p><input type="radio" name="areyou" value="hermaphrodite"> An hermaphrodite</p>
    <p><input type="radio" name="areyou" value="asexual"> Asexual</p>

    <p><input type="submit"></p>

</form>
```



## Attributes

> Tags can alse have **attributes**, which are extra bits of information. But we should use CSS to help us process most attributes about apperences.
>
> `<tag attribute="value">Margarine</tag>`(for example)

### Global Attributes

> The generalists. You can use any of these attributes with any HTML tags.

#### $id$

> Identifies a unique element. The value of id can be used by CSS and JavaScript to reference that element. Links can also point directly to an element with a specific id.

#### $class$

> Used to reference elements, by CSS, for example. Any number of elements can have the same value.(unlike id)
>
> 



## Elements

>  Tags tend not to do much more than mark the beginning and end of an element. Elements are the bits that make up web paegs.