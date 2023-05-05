- 五种基本变量类型：nil、Boolean、string、Number、table

  - 可以通过`type(value)`查看变量类型 

- table数组`a={1,2,3,4,5}`，并且**数组下标从1开始**

- 条件控制语句

  ```lua
  a=3
  if a>3 then
      print("a>3")
  elseif a>1 then
      print("a>1")
  else
      ...
  end
  ```

- while循环

  ```lua
  aa = 0
  while aa <=4 do
      print("aa<4")
      aa = aa+1
  end
  print("aa>4")
  
  -- 输出
  --aa<4
  --aa<4
  --aa<4
  --aa<4
  --aa<4
  --aa>4
  ```

- for循环(注意5是可以取到的)

  ```lua
  for i=0,5 do print(i) end
  for i=0,5,1 do print(i) end
  -- 0 :初始值
  -- 5 :终点值
  -- 1 :变量每次自加值
  
  -- 输出：
  -- 0
  -- 1
  -- 2
  -- 3
  -- 4
  -- 5
  ```

- repeat-until循环

  ```lua
  aa = 1
  repeat         
      print(aa)   -- 打印aa 的值
      aa=aa+1     -- aa 自加一
  until aa>3      -- 判断aa的值是否大于 3 ，大于则结束
  
  -- 输出:
  -- 1
  -- 2
  -- 3
  aa = 10
  repeat         
      print(aa)   -- 打印aa 的值
      aa=aa+1     -- aa 自加一
  until aa>3      -- 判断aa的值是否大于 3 ，大于则结束
  ```

- break语句可以从循环控制结构中强制退出。*用户不能在循环外使用*，而且它**必须在程序块的最后**（通常是if-then 语句）

- 拼接符`..`，比如`print("a="..a)`,可以将变量值和字符串拼接起来

- 函数function

  ```lua
  function f1(arg1,arg2)
      print(arg1,arg2)
  end
  f1(123,123)
  -- 可以定义不定长参数，使用...代替参数列表，lua会自动创建一个局部的名字为arg的table
  function f2(...)
      local arg={...} -- 这里必须显示定义arg
      print(arg,#arg,arg[1]) -- 通过#table_name获取table长度
  end
  ```

- 语句之间可以通过`;`隔开，如果多个语句写在同一行的时候，建议使用

- Lua中 and 和 or 与C语言区别特别大。

  在这里，请记住，**在Lua中，只有false 和 nil 才计算为false,其他任何数据都计算为true,0也是true!**

  and 和or 的运算结果不是true 和false，而是和它的两个操作数相关。

  a and b ：如果 a 为false,则返回a; 否则返回 b

  a or b :如果a 为true,则返回a; 否则返回b.

- lua可以对调赋值：`x,y=1,2`,函数返回值也可以同理接收

  ```lua
  function a()
  end
  
  function b()
      return 1
  end
  
  function c()
      return 2,3
  end
                  -- 可以发现只要一拼接，那么函数无论有多少个值返回，就只返回一个值，与其他值拼接
  print(a())
  print(b())
  print(c())
  print(b().."q")
  print(c().."q")
  print("q"..b())
  print("q"..c())
  
  -- 输出:
  -- 1
  -- 2    3
  -- 1q
  -- 2q
  -- q1
  -- q2
  
  print(6+b())   --返回:7
  print(  6+c(), c()+6,    c()) 
  -- 返回:8       8         2       3
  
  
  aa = {c()}  --定义一个数组,里面填的是c() ,相当于aa = {2,3}
  print(aa[1])
  print(aa[2])
  
  -- 输出:
  -- 2
  -- 3
  ```

- table:lua中对于数组下标没有那么严格，哪怕是字符串也可以作为数组下标

  ```lua
  a = {}      --创建一个table...数组
  a[1] = 1;
  a[2] = 3;
  a[3] = 5;
  print(#a)   -- 返回数组的大小
  -- 输出:
  -- 3
  
  
  -- 不过，看下面
  a = {}      -- 重新创建一个table 数组
  --a[1] = 1; -- 屏蔽掉   由于a[1] 是nil,"#" 一开始会检测a[1]因为是nil 所以就不往下了，就输出 0 
  a[2] = 3;
  a[3] = 5;
  print(#a)   -- 返回数组大小
  -- 输出:      
  -- 0
  
  -- 再看下面
  a = {}      -- 重新创建一个table 数组
  a[1] = 1;   
  -- a[2] = 3;--屏蔽掉   #检测到a[1],检测到一个，然后再遇到a[2]是nil，所以停了，就是1 啦
  a[3] = 5;
  -- 输出:
  -- 1
  
  -- 再看
  a = {}      -- 重新创建一个table...数组
  a[0] = 1;   -- 仔细一看哈是a[00000000]
  a[2] = 3;   -- 屏蔽掉
  a[3] = 5;
  print(#a)   -- 返回数组大小
  -- 输出:
  -- 0        -- Lua 是从1 开始索引，因为1 没有，是nil 所以就输出 0 
  
  -- 有时候
  a = {}      -- 创建一个table...数组
  a[1] = 1;
  a[2] = 2;
  a[3] = 3;
  a[4] = 4;
              -- 中间空一个
  a[6] = 6; 
  print(#a)   -- 返回数组的大小
  print(table.getn(a))    -- 和 #a 功能一样
  print(table.maxn(a))    -- 这个可以检测到空隙,看下面（该函数已取消使用）
  -- 输出:
  -- 6
  -- 6
  -- 6
  
  a = {}      -- 创建一个table...数组
  a[1] = 1;
  a[2] = 2;
  a[3] = 3;
  a[4] = 4;
  
  a[7] = 6;
  print(#a)   -- 返回数组大小
  print(table.getn(n))
  print(table.maxn(n))
  -- 输出:
  -- 4
  -- 4
  -- 7
  ```

- 