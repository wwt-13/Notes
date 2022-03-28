# Django项目规范

## 命名规范

- 模块名
  尽量全小写，也可以使用下划线 `module` `django_module`

- 全局变量\常量
  全大写+下划线式驼峰 `GLOBAL_VAR`

- 类名
  首字母大写式驼峰 `ClassName()`

- 函数命名
  全小写+下划线驼峰 `is_valid_data()`

- 局部变量/属性
  全小写+下划线式驼峰 `this_is_var`

- 模型

  大驼峰式命名

## 基本代码格式规范

使用pep8解决

## 包导入顺序规范

使用isort解决

```shell
isort .
```