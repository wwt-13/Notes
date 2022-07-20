[toc]

# tasks.json详解

> *Integrate with External Tools via Tasks*

## tasks.json的用途

官方原话：*Lots of tools exist to automate tasks like linting, building, packaging, testing, or deploying software systems. Examples include the [TypeScript Compiler](https://www.typescriptlang.org/), linters like [ESLint](https://eslint.org/) and [TSLint](https://palantir.github.io/tslint/) as well as build systems like [Make](https://en.wikipedia.org/wiki/Make_software), [Ant](https://ant.apache.org/), [Gulp](https://gulpjs.com/), [Jake](https://jakejs.com/), [Rake](https://ruby.github.io/rake/), and [MSBuild](https://github.com/microsoft/msbuild).*

**现在有很多工具可以自动化任务，比如对软件系统进行代码分析、构建、打包、测试或部署……**

*These tools are mostly run from the command line and automate jobs inside and outside the inner software development loop (edit, compile, test, and debug).*

**这些工具大多采用命令行运行，并自动化那些在内部软件开发的过程中不断重复的任务（编辑、编译、测试、调试）**

*Given their importance in the development life cycle, it is helpful to be able to run tools and analyze their results from within VS Code.*

**考虑到他们在软件开发周期中的重要性，能够直接在vscode中运行这些自动化工具并分析他们的结果是非常有帮助的**

*Code can be configured to run scripts and start processes so that many of these existing tools can be used from within VS Code without having to enter a command line or write new code.*

**可以将代码配置为运行脚本和启动进程，这样许多现有的工具就可以直接在vscode中使用，而无需打开命令行或编写新代码****

*Workspace or folder specific tasks are configured from the `tasks.json` file in the `.vscode` folder for a workspace.*

**特定于工作区或文件夹的任务是从工作区的. vscode 文件夹中的 tasks.json 文件配置的。**

## 自定义tasks.json

> *<font color="green">Ps:</font>使用cmd+shift+B来选择第三方工具构建任务*

- **label**: 用户界面使用的任务标签![image-20220719203654865](/Users/apple/Documents/Notes/assets/image-20220719203654865.png)

- **type**: 任务类型

  ![image-20220719203809667](/Users/apple/Documents/Notes/assets/image-20220719203809667.png)

- **command**: ==实际执行的指令==

- **windows**: 在windows操作系统上执行指令是的特定属性

- **group**: 定义任务所属的组（？不太理解）

- **presentation**: 定义如何在用户界面中处理任务输出。

- **options**: Override the defaults for `cwd` (current working directory), `env` (environment variables), or `shell` (default shell). Options can be set per task but also globally or per platform. Environment variables configured here can only be referenced from within your task script or process and will not be resolved if they are part of your args, command, or other task attributes.

- **runOptions**: 定义运行任务的时间和方式。

## 自定义第三方构建工具

> vscode可以自动识别大部分构建工具，但是如果想要自定义自动化任务处理器的话，需要。。。。