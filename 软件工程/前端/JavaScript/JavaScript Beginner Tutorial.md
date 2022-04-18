# JavaScript Beginner Tutorial

> There’s a few ways to try out JavaScript, and when learning it’s best to try them out to see what works for you. But first, how does JavaScript relate to HTML and CSS?

## HTML,CSS and JavaScript

> Mostly, JavaScript runs in your web browser **alongside HTML and CSS**, and can be added to any web page using a [`script`](https://htmldog.com/references/html/tags/script/) tag. The [`script`](https://htmldog.com/references/html/tags/script/) element can either contain JavaScript directly (**internal**) or link to an external resource via a `src` attribute (**external**).
>
> A browser then runs JavaScript line-by-line, starting at the top of the file or [`script`](https://htmldog.com/references/html/tags/script/) element and finishing at the bottom (unless you tell it to go elsewhere).

### Internal

> You can just put the JavaScript inside a script element
>
> ```javascript
> <script>
> 	alert("Hello, world.");    
> </script>
> ```

### External

> An external JavaScript resource is a **text file** with a **.js** extension, [just like an external CSS resource with a **.css** extension](https://htmldog.com/guides/css/beginner/applyingcss/).
>
> To add a JavaScript file to your page, you just need to use a script tag with a src attribute pointing to the file. So, if your file was called script.js and sat in the same directory as your HTML file, your [`script`](https://htmldog.com/references/html/tags/script/) element would look like this:
>
> ```javascript
> <script src="script.js"></script>
> ```
>
> and here is your scipt file (remember, you don't need to use script tags in the js file)
>
> ```javascript
> alert("Hello, javascript!");
> ```

You might also come across another way on your view-source travels: inline. This involves event attributes inside HTML tags that look something like `<a href="somewhere.html" onclick="alert('Noooooo!');">Click me</a>`. Just move along and pretend you haven’t witnessed this aberration. We really, really, really want to separate our technologies so it’s preferable to avoid this approach.

### Console

> The last way is great for getting instant feedback, and it’s recommend if you just want to try a line out quickly.
>
> In a modern browser you’ll find some developer tools - often you can right click on a page, then click “inspect element” to bring them up. Find the console and you’ll be able to type JavaScript, hit enter and have it run immediately.
>
> In a modern browser you’ll find some developer tools - often you can right click on a page, then click “inspect element” to bring them up. Find the console and you’ll be able to type JavaScript, hit enter and have it run immediately.
>
> ![image-20220404195755719](https://gitee.com/ababa-317/image/raw/master/images/image-20220404195755719.png)

## Variables and Data

> Storing data so we can use it later is one of the most important things when writing code. Fortunately, JavaScript can do this! If it couldn’t, it’d be pretty darn useless.
>
> By the way, this assumes **you’ve jumped into a browser and are typing into your console.**

```javascript
var surname=prompt('Greetings friend, may I enquire as to your surname?');
```

A little box will pop-up, asking (very courteously if I may say) for your surname. Type your surname in and hit ‘OK’.

![image-20220404200135785](https://gitee.com/ababa-317/image/raw/master/images/image-20220404200135785.png)The surname you entered is now saved, and it can be referred to as surname.

You've created a variable.

### Varibables

> There are two parts to creating a variable; *declaration* and *initialization*. Once it’s created, you can *assign* (or set) its value.

#### Declaration

> Declaration is *declaring* a variable to *exist*. To return to the shelf metaphor, it’s like picking an empty shelf in a massive warehouse and putting a name on it.

As above, to declare a variable, use the `var` keyword followed by the variable name, like this:

```javascript
var surname;
var age;
```

#### Initialization

> *Initialization* is giving a variable its *value* for the *first time*. The value can change later, but it is only initialized once.
>
> ```javascript
> var name = "Tom";//"Tom" is a string
> var age = 20;//20 is just a number
> var name="Tom",age=20;
> ```

### Doing Math

```javascript
var piecesOfFruit = apples + pears;
```

## Logic

> A really important part of programming is being able to compare values in order to make decisions in code. When a comparison is made the outcome is either true or false; a special kind a of data called a *boolean*. This is *logic*.

### Equality

> To find out when two values are equal, use the *triple equals* operator (“**===**”).

```javascript
12.123===12.123;//true
14.123!==12.123;//false
```

## Conditional

> Logic is used to make decisions in code; choosing to run one piece of code or another depending on the comparisons made. This requires use of something called a *conditional*. There are a few different conditionals that you might want to use, but we’ll just focus the one used most commonly: `if`.

```javascript
if (10 > 5) {
    // Run the code in here
}
if (43 < 2) {
    // Run the code in here
} else {
    // Run a different bit of code
}
```

## Looping

> *Loops* are a way of repeating the same block of code over and over. They’re incredibly useful, and are used, for example, to carry out an action on every item in an array ([we will come to arrays later](https://htmldog.com/guides/javascript/beginner/arrays/)) or in searching.
>
> Two of the most common loops are *while* loops and *for* loops. They combine a conditional and a block, running the block over and over until the logic of the conditional is no longer true, or until you force them to stop.

```javascript
var i = 1;
while (i < 10) {
    alert(i);
    i = i + 1;//i++;
}
// i is now 10
for (var i = 1; i < 10; i++) {
    alert(i);
}
```

## Functions

> Functions are reusable blocks of code that carry out a specific task. To *execute* the code in a function you *call* it. A function can be passed *arguments* to use, and a function may *return* a value to whatever called it.

```javascript
var add=function(a,b){
    return a+b;
}
var result=add(1,2);
```

##  Objects

> JavaScript objects are like **a real life objects**; they have properties and abilities. A JavaScript object is, in that sense, a collection of named *properties* and *methods* - a function. An object can be stored in a variable, and the properties and methods accessed using the *dot syntax*.
>
> 类比Java面向对象
>
> A human, for example, has a name and an age, and could talk, move or learn JavaScript. Name and age are *properties* of the human, and are essentially pieces of data. Talking, moving and learning are more like functions - there’s some complex behavior involved. When a JavaScript object has such an ability, it is called a *method*.

Variables can hold objects, and creating an object is done using a special syntax signified by ==braces==:

```javascript
var people={
    name: "wwt",
    age: 889,
    talk: function(){
        alert("Hello, I am"+this.name+"I am "+this.age+" years old.");
    }
};
```

![image-20220404202719300](https://gitee.com/ababa-317/image/raw/master/images/image-20220404202719300.png)

Properties can be any kind of data including objects and arrays. Adding an object as a property of another object creates a *nested object*(嵌套对象)

```javascript
var person = {
    age: 122
};
person.name = {
    first: "Jeanne",
    last: "Calment"
};
```

Creating an empty object and adding properties and methods to it is possible too:

```javascript
var dog = {};
dog.bark = function () { alert("Woof!"); };
```

## Arrays

> **Arrays** are lists of any kind of data, including other arrays. Each item in the array has an **index** — a number — which can be used to retrieve an **element** from the array.

```javascript
var emptyArray = [];

var shoppingList = ['Milk', 'Bread', 'Beans'];

shoppingList[0];//Milk
shoppingList.length;//3
shoppingList.push('A new car.');
shoppingList.pop();//use push and pop methods to add and remove elements from the end of the array.

var helloFrom = function (personName) {
    return "Hello from " + personName;
}

var people = ['Tom', 'Yoda', 'Ron'];
people.push('Bob');
people.push('Dr Evil');
people.pop();
for (var i=0; i < people.length; i++) {
    var greeting = helloFrom(people[i]);
    alert(greeting);
}
```









