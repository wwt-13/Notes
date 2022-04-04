[toc]

# CSS Beginner Tutorial

> **CSS**, or **Cascading Styles Sheets**, is a way to style and present HTML. Whereas the HTML is the meaning or content, the style sheet is the presenetation of that document.
>
> Styles don't smell or taste anything like HTML, they have a format of '**property: value**' and most properties can be applied to most HTML tags.

## Applying CSS

> There are three ways to apply CSS to HTML: **Inline**, **Internal**, **External**

### Inline

> Inline styles are plonked straight into the HTML tags using the style attribute.

They look something like this:

```html
<p style="color: red;">text</p>
```

But what should be remembered is, the best-practice approach is that the HTML should be a stand-alone, presentation free document, and **so in-line styles should be avoided wherever possible.** 

### Internal

> Embedded, or internal, styles are used for the whole page. **Inside the head element**, the style tags surround all of the styles for the page.

```html
<!DOCTYPE html>
<html>
<head>
    <title>CSS Example</title>
    <style>
        p {
            color: red;
        }
        a {
            color: blue;
        }
    </style>
</head>
```

Although preferable to soiling our HTML with inline presentation, it is similarly usually preferable to keep the HTML and the CSS files separate, and so we are left with our savior…

### External

> External styles are used for the whole mutiple-page website. It is a separate CSS file, which will simply look something like this.
>
> ```css
> p{
>     color: red;
> }
> a{
>     color: blue;
> }
> ```

if this file is saved as "style.css" in the same directory as your HTML page then it can be linked to in the HTML like this:

```html
<html>
    <head>
        <link rel="stylesheet" href="style.css">
    </head>
</html>
```

## Selectors,Prepreties,and Values

> Whereas HTML has **tags**, CSS has **selectors**. Selectors are the names given to styles in internal and external style sheets. In this CSS Beginner Tutorial we will be concentrating on HTML selectors, which are simply the names of HTML tags and are used to change the sytle of a specific type of element.

### Lengths and Percentages

> There are many property-specific units for values used in CSS, **but there are some general units that are used by a number of properties** and it is worth familiarizing yourself with these before continuing.

- px (such as `font-size: 12px`)is the unit for pixels(that is a relative size)
- em (such as `font-size: 2em`)is the unit for the calculated size of a font.So "2em" is two times the current font size.
- pt (such as `font-size: 12pt`)is the unit for points, typically in printed media
- % (such as `width: 80%`)is the unit for .... wait for it ... percentages

we can just use 'px' as our default length unit for the browser will adjust the font size for their customers.

### Colors

> CSS brings 16,777,216 colors to your disposal. They can take the form of a name, an **RGB**(red/green/blue) value or a **hex** code
>
> the following values all produce the same result
>
> - red
> - rgb(255,0,0)
> - rgb(100%,0%,0%)
> - #ff0000
> - #f00

==Predefined color== names include `aqua`, `black`, `blue`, `fuchsia`, `gray`, `green`, `lime`, `maroon`, `navy`, `olive`, `purple`, `red`, `silver`, `teal`, `white`, and `yellow`. `transparent` is also a valid value.

> With the possible exception of `black` and `white`, color names have limited use in a modern, well-designed web sites *because they are so specific and limiting*.

The hex number is prefixed with a hash character (**#**) and can be three or six digits in length. Basically, the three-digit version is a compressed version of the six-digit (`#ff0000` becomes `#f00`, `#cc9966` becomes `#c96`, etc.). The three-digit version is easier to decipher (the first digit, like the first value in RGB, is red, the second green and the third blue) but the six-digit version gives you more control over the exact color.

#### color and background-color

### Text

> You can alter the size and the shape of the text on a web page with a range of properties.

- font-family

  This is the font itself, such as ==Times New Roman==, Arial, or Verdana.

  The user’s browser has to be able to find the font you specify, which, in most cases, means it needs to be on **their(users')** computer so there is little point in using obscure fonts that are only sitting on **your** computer. There are a select few “**safe**” fonts (the most commonly used are *Arial, Verdana and Times New Roman*), but you can specify more than one font, separated by **commas**. **The purpose of this is that if the user does not have the first font you specify, the browser will go through the list until it finds one it does have.** This is useful because different computers sometimes have different fonts installed. So `font-family: arial, helvetica, serif`, will look for the Arial font first and, if the browser can’t find it, it will search for Helvetica, and then a common serif font.

  ==Attention==： if the name of a font is more than one word, it should be put in quotation marks, such as `font-family: "Times New Roman"`.

- font-size

  [`font-size`](https://htmldog.com/references/css/properties/font-size/) sets the size of the font. Be careful with this — text such as headings should not just be an HTML paragraph ([`p`](https://htmldog.com/references/html/tags/p/)) in a large font - you should still use headings ([`h1`](https://htmldog.com/references/html/tags/h1h2h3h4h5h6/), [`h2`](https://htmldog.com/references/html/tags/h1h2h3h4h5h6/) etc.) even though, in practice, you could make the font-size of a paragraph larger than that of a heading (not recommended for sensible people).

- font-weight

  [`font-weight`](https://htmldog.com/references/css/properties/font-weight/) states whether the text is ==bold== or not. Most commonly this is used as `font-weight: bold` or `font-weight: normal` but other values are `bolder`, `lighter`, `100`, `200`, `300`, `400` (same as `normal`), `500`, `600`, `700` (same as `bold`), `800` or `900`.

- font-style

  [`font-style`](https://htmldog.com/references/css/properties/font-style/) states whether the text is ==italic== or not. It can be `font-style: italic` or `font-style: normal`.

- text-decoretion

  [`text-decoration`](https://htmldog.com/references/css/properties/text-decoration/) states whether the text has got a line running under, over, or through it.

  - `text-decoration: underline`, does what you would expect.
  - `text-decoration: overline` places a line above the text.
  - `text-decoration: line-through` puts a line through the text (“strike-through”).

  This property is usually used to decorate links and you can specify no underline with `text-decoration: none`.

  ==Attention==：Underlines should only really be used for links. They are a commonly understood web convention **that has lead users to generally expect underlined text to be a link.**

- text-transform

  [`text-transform`](https://htmldog.com/references/css/properties/text-transform/) will change the case of the text.

  - `text-transform: capitalize` turns the first letter of **every word** into **uppercase**.
  - `text-transform: uppercase` turns **everything** into uppercase.
  - `text-transform: lowercase` turns everything into lowercase.
  - `text-transform: none` I’ll leave for you to work out.

#### Text spacing

> Before we move on from this introduction to styling text, a quick look at how to space out the text on a page.

The [`letter-spacing`](https://htmldog.com/references/css/properties/letter-spacing/) and [`word-spacing`](https://htmldog.com/references/css/properties/word-spacing/) properties are for spacing between letters or words. The value can be a length or `normal`.

The [`line-height`](https://htmldog.com/references/css/properties/line-height/) property **sets the height of the lines in an element**, such as a paragraph, without adjusting the size of the font. It can be a number (which specifies a multiple of the font size, so “2” will be two times the font size, for example), a length, a percentage, or `normal`.

The [`text-align`](https://htmldog.com/references/css/properties/text-align/) property will align **the text inside an element** to left, right, center, or justify.

The [`text-indent`](https://htmldog.com/references/css/properties/text-indent/) property will **indent the first line of a paragraph**, for example, to a given length or percentage. This is a style traditionally used in print, but rarely in digital media such as the web.

### Margins and Padding

> [`margin`](https://htmldog.com/references/css/properties/margin/) and [`padding`](https://htmldog.com/references/css/properties/padding/) are the two most commonly used properties for spacing-out elements. A margin is the space **outside** something, whereas padding is the space **inside** something.

Change the CSS code for h2 to the following

```css
h2 {
    font-size: 1.5em;
    background-color: #ccc;
    margin: 20px;
    padding: 40px;
}
```

This leaves a 20-pixel width space around the secondary header and the header itself is fat from the 40-pixel width padding.

==So what's the difference between margin and padding in CSS ?==

> In CSS, **a margin is the space around an element’s border**, while **padding is the space between an element’s border and the element’s content**. Put another way, the margin property controls the space *outside* an element, and the padding property controls the space *inside* an element.

Let’s explore margins first. Consider the element illustrated below, which has a margin of 10 pixels:

![an illustration of the margins around a page element](https://blog.hubspot.com/hs-fs/hubfs/Google%20Drive%20Integration/Update%20css%20margin%20vs%20padding-1.png?width=400&name=Update%20css%20margin%20vs%20padding-1.png)



This means that there will be at least 10 pixels of space between this element and adjacent page elements — the margin “pushes away” its neighbors. If we put multiple of these elements together, we see how margins create whitespace between them, giving them room to breathe:

![an illustration of the margins around multiple page elements](https://blog.hubspot.com/hs-fs/hubfs/Google%20Drive%20Integration/Update%20css%20margin%20vs%20padding.png?width=500&name=Update%20css%20margin%20vs%20padding.png)

On the other hand, padding is located inside the border of an element. The element below has padding of 10px on the left and right sides, and padding of 15px on the top and bottom sides:

![an illustration of the padding inside a page element](https://blog.hubspot.com/hs-fs/hubfs/Google%20Drive%20Integration/Update%20css%20margin%20vs%20padding-4.png?width=400&name=Update%20css%20margin%20vs%20padding-4.png)

#### The Box Model

> Margins, padding and borders (see [next page](https://htmldog.com/guides/css/beginner/borders/)) are all part of what’s known as **the Box Model**. The Box Model works like this: in the middle you have the content area (let’s say an image), surrounding that you have the padding, surrounding that you have the border and surrounding that you have the margin. It can be visually represented like this:
>
> <div id="boxmodel" style="color: #a06700; margin: 20px 0; overflow: auto; padding: 10px 20px 20px 20px; background-color: #e90;">
>     Margin box
>     <div style="padding: 10px 20px 20px 20px; margin: 10px 20px 20px 20px; background-color: #f4bb55;">
>         Border box
>         <div style="padding: 10px 20px 20px 20px; margin: 10px 20px 20px 20px; background-color: #f9ddaa;">
>             Padding box
>             <div style="padding: 20px; margin: 10px 20px 20px 20px; background-color: #fff;">
>                 Element box
>             </div>
>         </div>
>     </div>
> </div>
