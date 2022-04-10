[toc]

# Buaa数学建模模板使用说明——v1.0

## 更新说明(bug修复)以及本模板概述

> $tips:$目前本说明文档写的还有点乱，之后又时间会进行更加系统的整理。
>
> 建议的论文文件夹基本架构（**codes**放置所有代码文件、**figs**放置所有图片文件，**main.tex**放置文章内容）
>
> <img src="C:\Users\86188\AppData\Roaming\Typora\typora-user-images\image-20220408124843095.png" alt="image-20220408124843095" style="zoom:50%;" />

- 北航logo现已更新为高清pdf（居然是GitHub上找到的emmm）

- 模板已配置好Latex下的中文使用环境（默认设置语言为楷体，需要修改字体的话可以修改如下代码）

  ```latex
  \begin{CJK}{UTF8}{gkai} % 修改gkai为其他字体即可
  ```

- 行距、页距等文章基本格式已调整完善（如果需要特定格式的话可以自行添加相关的控制序列）

  **举例**

  ```latex
  \begin{abstract}
  \begin{spacing}{1.5} % 在摘要内部设置1.5倍词间距
  \end{spacing}{1.5}
  \end{abstract}
  ```

- 模板的首页格式已基本确定，不建议修改

  ![image-20220408195639433](https://gitee.com/ababa-317/image/raw/master/images/image-20220408195639433.png)

- 二度解决中文宋体不支持加粗的问题，更换渲染引擎未XeLaTeX

- 添加了子标题格式宏，现在子标题会默认加粗（想修改格式的话可以去最前面的宏定义区域进行修改）

- 优化了代码格式。代码块格式已基本确定，不建议修改（现已修复原代码块不支持**等宽字体**的问题）

  ```latex
  \lstset{
      columns=fixed,       
      numbers=left,                                        % 在左侧显示行号
      frame=none,                                          % 不显示背景边框
      basicstyle=\ttfamily,                                % 设置等宽字体(原本的lst宏包默认使用的是正文的字体，那样太难看了)
      backgroundcolor=\color[RGB]{245,245,244},            % 设定背景颜色
      keywordstyle=\color[RGB]{40,40,255},                 % 设定关键字颜色
      numberstyle=\footnotesize\color{darkgray},           % 设定行号格式
      commentstyle=\it\color[RGB]{0,96,96},                % 设置代码注释的格式
      stringstyle=\rmfamily\slshape\color[RGB]{128,0,0},   % 设置字符串格式
      showstringspaces=false,                              % 不显示字符串中的空格
  }
  ```

- 本说明文档中使用语法所需宏包已全部导入（总之用它就完了👻👻）

## 基本语法使用介绍

### 增强说明

> 一般来说：加粗高亮>高亮>加粗斜体>加粗>斜体>正常

1. 加粗：`\textbf{需要加粗的内容}`
2. 斜体：`\emph{需要斜体的内容}`
3. 高亮：`hl{需要高亮的内容}`
4. 强调段落（新增）：在宏定义中新增了`\paragraph{}`的格式配置，可以直接通过该格式块对整个段落实现加粗效果

### 目录、摘要以及关键词

> 所有目录由Latex自动生成，要添加相关目录只需使用`section{节名}`、`subsection{小节名}`、`subsubsection{小小节名}`即可，声明之后目录会自动添加到目录页中。

*目录示例*

```latex
\section{节1}
......
\subsection{节1.1}
......
\subsection{节1.2}
......
\subsubsection{节1.2.1}
```

---

> 关于摘要和关键词，他们的宏定义已经在最前面声明好了，只需要遵循定义好的格式书写即可
>
> $Attention:$格式规范！！==摘要页必须自成一页==，所以要在首尾添加`\newpage`保证换页

摘要+关键词基本格式范例

```latex
\newpage
\begin{abstract}                                % 摘要
\begin{spacing}{1.5}

此处放置你的摘要

\keywords{关键词1,关键词2,关键词3}
\end{spacing}
\end{abstract}
\newpage
```

### 公式块

> 在Latex中，可以通过多种方式来使用公式块，这里只讲最常用的一种（其余的以后有时间了再来添加）
>
> ==行内公式==：直接通过`$Latex公式$`即可，这种方法一般用于比较简单的符号（例：$\alpha$）和非常简短的公式说明
>
> ==行间公式==：更为正式的公式，这里只讲会进行自动编号的公式写法(如下)，注意这里都不需要给内部Latex公式套上$$

```latex
% 方法1
\begin{align}
	Latex公式
\end{align}
% 方法2
\begin{equation}
	Latex公式
\end{equation}
```

Plus：左对齐公式和右对齐公式（和上面的原理一致，只是需要套上$$）

```latex
\begin{left}
	$Latex公式$
\end{left}
\begin{right}
	$Latex公式$
\end{right}
```

## 表格

> 鉴于Latex屎一样的表格生成语法，我找了一个可以直接可视化生成Latex表格代码的网站
>
> 以后需要用表格啥的直接到这里生成再无脑复制粘贴即可
>
> [Tables Generator](https://www.tablesgenerator.com/)

下面来欣赏一下**屎**一样的Latex表格是怎么样的

```latex
\begin{table}[h]
    \centering
    \begin{tabular}{|c|c|c|c|c|c|c|c|}
        \hline
        \multirow{2}{*}{ } &
        \multirow{2}{*}{Group} &
        \multicolumn{6}{c|}{d Value} \\
        \cline{3-8} &
        \multicolumn{1}{c|}{} &
        $2\%$ & $5\%$ & $10\%$ & $15\%$ & $20\%$ & $30\%$ \\
        \hline
        \multirow{3}{*}{Final Income} &
        1 & 21423.43 & 14437.2 & 4673.83 & 1695.26 & 8235.46 & 10437.36 \\
        \cline{2-8} &
        2 & 18943.32 & 19436.46 & 6323.29 & 948.32 & 12438.26 & 8345.36 \\
        \cline{2-8} &
        3 & 20463.26 & 13672.63 & 8436.28 & 4261.25 & 7483.36 & 3738.72 \\
        \hline
    \end{tabular}
    \caption{Final returns under different disturbances}
    \label{tab:my_label}
\end{table}
```

这么一大坨Latex代码只能生成下面这个玩意.......😱😱😱

![image-20220408195455221](https://gitee.com/ababa-317/image/raw/master/images/image-20220408195455221.png)

## 基本列表语法

### 无序列表

```latex
\begin{itemize}
    \item 开始时此岸的商人数为 $a$，随从数为 $b$；
    \item 船的最多能同时载 $c$ 人，所有人均会划船；
    \item 过河时船上至少要有一个人；
    \item 任意一岸随从数量不能多于商人数量；
    \item 随从在船上不会杀人越货。
\end{itemize}
```

![image-20220408131519087](https://gitee.com/ababa-317/image/raw/master/images/image-20220408131519087.png)

### 有序列表

```latex
\begin{enumerate}
    \item {使用 Clion 进行代码编程}
    \item {使用 \href{https://www.geogebra.org/}{Geogebra} 进行绘图工作}
    \item {使用 draw.io 进行本文的流程图设计}
    \item {使用 \href{https://cn.overleaf.com/}{overleaf} 进行本文的全部编辑渲染}
\end{enumerate}
```

![image-20220408131454756](https://gitee.com/ababa-317/image/raw/master/images/image-20220408131454756.png)

## 文件引用语法

> 这里讲讲基本的文件引用语法，包括图像文件的插入以及代码文件的引入

### 引用图像文件

#### 单图插入

> 比较遗憾的是，如果要在文中别处进行引用图片的话，必须使用`\caption{pig_title}`这样的格式，如果采用下面的自定义图片标题会出现乱码
>
> ![image-20220408130435386](https://gitee.com/ababa-317/image/raw/master/images/image-20220408130435386.png)

```latex
Figure \ref{figs.pag1} is ababababababa.
\begin{figure}[h] 	% h表示就在此处插入
    \centering		% 设置图片居中显示
    \includegraphics[width=10cm]{figs/Fig1.png} % []中设置图像大小，{}中设置图像路径
    \caption*{图1.1：商人过河问题}	% *表示取消默认Latex为图片编号，全部采用{}中的图片标题(如果要设置引用的话，建议直接使用\caption)
    \label{figs.pag1}	% 设置用于文中引用的标签
\end{figure}
```

#### 多图横排插入

> 需要导入subfigure宏包（已导入）

```latex
\begin{figure}[H]
\centering  %图片全局居中
\subfigure[name1]{
\label{Fig.sub.1}
\includegraphics[width=0.45\textwidth]{DV_demand}}
\subfigure[name2]{
\label{Fig.sub.2}
\includegraphics[width=0.45\textwidth]{P+R_demand}}
\caption{Main name}
\label{Fig.main}
\end{figure}
```

### 引用代码文件

#### 直接引用代码片段

```latex
\begin{lstlisting}[
    language=c++, % 声明使用的语言
    caption=\textbf{代码片段},	% 代码片段标题
]
% 在这里放置你的代码
\end{lstlisting}
```

#### 间接引用代码文件

```latex
\lstinputlisting[
    language=c++,	% 同上
    caption={\bf q1\_dfs.cpp}	% 同上
] {codes/Q1_DFS.cpp}	% {}中放置代码文件的路径
```

## Latex高阶操作

> 没时间写了，先看软工去了~

