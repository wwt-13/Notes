# Java异常处理

- 异常处理

  - 允许用户及时保存结果
  - 抓住异常，分析异常内容
  - 控制程序返回安全状态

- try-catch-finally：Java提供的一种保护代码正常运行的机制

- 异常结构

  - try...catch（catch可以有多个）
  - try...catch...finally
  - try...finally

  try必须有，finally和catch至少要有一个

## 代码结构

- try：正常逻辑代码
- catch：当try发生异常的时候，将执行catch代码，若无异常，直接绕行
- finally：try或者catch执行结束后，必须要执行finally

注意，finally中的代码是==一定==会被执行的（即使catch中的代码再度发生异常）

## catch块异常匹配机制

- catch块可以有多个，每个都有不同的入口形参，当已发生异常和某一个catch块的形参类型一致，那么将执行catch块中的代码。如果没有一个匹配，catch也不会被触发。最后都进入finally块。
- 一个异常只能进入**一个**catch块
- catch块的异常匹配是顺序执行的
- 一般会将比较小而精确的异常写在前面，而一些大的（宽泛）异常则会写在末尾
- 像Exception这种最宽泛的异常一般就会写在catch的末尾

try-catch-finally结构是可以迭代的（但是这样会不会太乱了emmmm）

## 方法异常处理机制：throws

> 方法中存在可能的异常，但是不去处理，而是使用throws来声明这个异常

- 别人来调用带有throws的异常（checked exception）的方法，要么处理这些异常，或者继续向外throws，直到main函数里使用try-catch-finally处理这些异常
- 调用可能抛出异常的方法的时候要对外进行声明（如果以及对其进行了处理就不用了）
- 子类抛出异常应该是父类的子集（不能大于父类）