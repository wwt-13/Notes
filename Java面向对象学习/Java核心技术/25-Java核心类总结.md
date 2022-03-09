[toc]

# Java核心类

## 字符串与编码

> 这里只记录我目前没了解过的内容

1. 大小写转换

   ```java
   String name="wwt";
   nameBig=name.toUpperCase(name);
   nameSmall=name.toLpperCase(name);
   ```

2. 忽略大小写比较

   ```java
   String name1="wwt";
   String name2="WWT";
   System.out,println(name1.equalsIgnoreCase());//忽略大小写比较
   ```

3. 字串的各种方法

   ```java
   String name="wwt";
   "HEllo".contains("llo");
   name.indexOf("HE");//HE字串的起始下标
   name.substring(statIndex,endIndex);//提取字串
   ```

4. 去除首尾空白字符：包括空格、`\t`、`\r`、`\n`

   ```
   " \tHello\r\n".trim();
   ```

5. 