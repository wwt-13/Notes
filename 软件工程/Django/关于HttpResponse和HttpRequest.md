# 关于HttpResponse和HttpRequest

## HttpRequest

HttpRequest是django接受用户发送来的的请求报文后，将所有报文数据封装到HttpRequest**对象**中去（注意HttpRequest是一个对象，所有请求的所有数据都可以通过对象的属性访问到）

比较常用的属性有如下几个

1. method：请求方法（GET、POST）

2. path：请求的路径（不包括域名）

3. GET：GET请求方式的数据（类字典对象）

4. POST：POST请求方式的数据（类字典对象）

5. FILES：包含了所有上传的文件（类字典对象）

6. COOKIES：一个标准的Python字典（包含所有的cookie）

7. session：表示当前的会话，可读可写的类字典对象（只有django启动会话的支持时才可用）

   [关于session的解释](https://www.liaoxuefeng.com/wiki/1252599548343744/1328768897515553)

   在Web应用程序中，我们经常要跟踪用户身份。**当一个用户登录成功后，如果他继续访问其他页面，Web程序如何才能识别出该用户身份？**

   因为HTTP协议是一个**无状态协议**，即Web应用程序无法区分收到的两个HTTP请求是否是同一个浏览器发出的。为了跟踪用户状态，服务器可以向浏览器分配一个唯一ID，并以Cookie的形式发送到浏览器，浏览器在后续访问时总是附带此Cookie，这样，服务器就可以识别用户身份。

   我们把这种基于唯一ID识别用户身份的机制称为Session。每个用户第一次访问服务器后，会自动获得一个Session ID。如果用户在一段时间内没有访问服务器，那么Session会自动失效，下次即使带着上次分配的Session ID访问，服务器也认为这是一个新用户，会分配新的Session ID。

## HttpResponse

HttpResponse 返回的是一个应答的数据报文。render 内部已经封装好了 HttpResponse 类

1. content：表示返回的内容
2. charset：表示response采用的编码字符集（默认utf-8）
3. status_code：响应的HTTP状态码

一个基础的示例

```python
response = HttpResponse('<h2>微信公众号【孤寒者】</h1>',content_type='text/plain;charset=utf-8')    
# 注意：一般在使用‘text/plain'时，都会添加‘charset=utf-8'，否则是会乱码的。
return response
```

可以以多种方式返回数据

1. HttpResponse 只是返回简单的字符串对象
2. render 渲染模板
3. redirect 重定向
4. JsonResponse 返回json数据，结合前端Ajan等技术可以实现后端向前端传数据，前端接收后实现注册登录等的JS效果功能！！！



Django框架的基本处理流程

![](https://wwt13-images-1305051431.cos.ap-beijing.myqcloud.com/img/20220324111612.png)