# Linux基础课-4.1 ssh

> 输入`homework 4 getinfo`即可看到AcWing为我们新分配的ssh配套服务器

>  ssh有什么用？
>
>  在未来开发的时候，使用的肯定不止一台服务器
>
>  像AcWing：web服务器（多个），评测器（多个），AcServer（AcTermainl服务器）......
>
>  <u>以上的服务器都是Linux服务器</u>
>
>  而未来开发的时候，就需要登录到不同的服务器上去进行不同的操作，这种时候就需要使用到ssh
>
>  ```mermaid
>  graph LR
>  ACTermainl--ssh-->Web服务器
>  ACTermainl--ssh-->评测服务器
>  ACTermainl--ssh-->ACS服务器
>  ```



## ssh登录

> 如何从一个服务器登录到另外一个服务器里面？
>
> ssh应用领域：自动化运维

- user：用户名
- hostname：ip地址
- password：密码
- plus：以后租云服务器的时候获取到的也是这三个东西

```shell
AcTermainl服务器参数
User:acs_3588
Hostname:123.57.47.211
Password:x'x'x'x'x'x
```

### 基本用法

1. 远程登录服务器

   ```shell
   ssh user@hostname
   ```

   第一次登录会出现`The authenticity of host .....can't be established...`，大致意思就是这个服务器我们之前没有见过它（公钥hash值），询问我们要不要登录它？

   输入yes，在接着输入password即可登录到你的云服务器

   ![](https://gitee.com/ababa-317/image/raw/master/images/20220306131054.png)

2. 退出登录状态：输入`logout`或者`ctrl+d`即可

3. 记录登录信息（下次登录的时候就不会出现一大串提示信息了）：

   ```shell
   cd .ssh # 进入到ssh文件夹
   vim known_hosts # 记录登录过的服务器信息(貌似是hash值)
   ```

4. 修改登录端口

   ssh中默认的登录端口号是22，如果想要从其他端口登录，执行如下指令即可

   ```shell
   ssh user@hostname -p port
   ```

最新连接上的服务器，完全是“毛坯”的状态，举个例子，tmux和vim都处于未配置状态，默认不支持鼠标操作（此时可以使用==scp==向服务器端口**传输文件**）

### 配置文件

> 每次登陆的时候，要输入user、hostname、password三个东西，这些东西都很难背.....，此时就可以通过配置文件来给其起一个别名

创建文件`~/.ssh/config`，然后在config配置文件中输入

```shell
Host myserver1 # 服务器名字自己取
	Hostname IP地址 or 域名
	User 用户名

Host myserver2
	Hostname ...
	User ...
....
```

这样配置完成后，就可以直接使用别名`myserver1`来访问对应服务器

![](https://gitee.com/ababa-317/image/raw/master/images/20220306132744.png)

但是这样设置好了之后每次登录还是需要手敲一遍password（还是很麻烦），下面说说如何设置免密登录（rsa公钥）

### 密钥登陆

> 通俗的来说，就是设置免密码登录
>
> 原理：rsa密钥（原理之类的就不说了）
>
> **具体流程**
>
> 1. 客户端生成证书：私钥和公钥，然后私钥放在客户端，妥当保存，一般为了安全，防止有黑客拷贝客户端的私钥，客户端在生成私钥时，会设置一个密码，以后每次登录 ssh 服务器时，客户端都要输入密码解开私钥（如果工作中，你使用了一个没有密码的私钥，有一天服务器被黑了，你是跳到黄河都洗不清）。
>
> 2. 服务器添加信用公钥：把客户端生成的公钥，上传到 ssh 服务器，添加到指定的文件中，这样，就完成 ssh 证书登录的配置了。
>
>    假设客户端想通过私钥要登录其他 ssh 服务器，同理，可以把公钥上传到其他 ssh 服务器。
>
> 真实的工作中:员工生成好私钥和公钥（千万要记得设置私钥密码），然后把公钥发给运维人员，运维人员会登记你的公钥，为你开通一台或者多台服务器的权限，然后员工就可以通过一个私钥，登录他有权限的服务器做系统维护等工作，所以，员工是有责任保护他的私钥的，如果被别人恶意拷贝，你又没有设置私钥密码，那么，服务器就全完了，员工也可以放长假了。

1. 创建密钥，通过命令`ssh-keygen`，然后一直回车即可

   创建完毕后，会在`.ssh`文件夹下看到两个密钥文件`id_rsa`、`id_rsa.pub`

   `id_rsa`：私钥，一定不能给其他人看

   `id_rsa.pub`：公钥，可以随便给别人看

2. 免密登录：如果想要免密登录那个服务器，就直接将公钥传递给那个服务器就行了（github的本质和这个类似）

   假设我想免密登录我的`myserver`服务器，那么就直接将公钥中的内容，复制到`myserver`中的`~/.ssh/authorized_keys`文件里即可。

   当然也可以使用如下指令一键添加公钥

   ```shell
   ssh-copy-id myserver
   ```

   ![](https://gitee.com/ababa-317/image/raw/master/images/20220306142356.png)

### 拓展

> 假设此时你有一台服务器，需要这台服务器去执行一个命令，那么很简单，`ssh server`+执行命令+`logout`，完事了，但是如果你需要100台服务器去执行100条相同的命令呢？太麻烦了吧！其实可以利用ssh服务器自动执行命令（我也不知道具体叫啥反正就随便起了一个名字）来完成这些操作

```shell
ssh server ls -a # 这样就自动跑在服务器里了(并且这个可以支持非常复杂的指令)
# 然后如果要在100台服务器执行的话，写一个类似的脚本就行了
```

比方说这样.....（注意单引号是为了防止服务器误解这不是一整条指令，并且单引号可以求值\$i）

![](https://gitee.com/ababa-317/image/raw/master/images/20220306143645.png)

## scp传文件

> 这里讲解如何在本地和服务器之间互传文件
>
> 服务器和服务器之间的文件传输一般先从服务器传输到本地，再从本地传输到服务器

### 基本用法

**命令格式：**将source路径下的文件复制到destination中

```shell
scp source destination
scp source1 source2 destination # 一次性复制多个文件
# 示例
scp ~/tmp.txt myserver1: # 默认是家目录
# 将myserver1云端服务器的test.sh复制到本地当前文件夹下
scp myserver1:test.sh ./ 
```

**复制文件夹**：在基本命令==前==添加`-r`即可（注意一定是前面）

**指定服务器端口号**

```shell
scp -P 8080 tmp.txt myserver1:tmp
```



> 远程账号的地址是相对于家目录下来说的

服务器和服务器之间也可以互传，一般步骤是先服务器传到本地，再从本地传到服务器（当然服务器之间也是可以直接传的，但是往往需要事先声明好完善的权限，所以一般传本地比较方便）

使用`scp`配置其他服务器的`vim`和`tmux`：非常方便

```shell
scp ./.vimrc ./tmux.conf myserver1:
```

# 作业

> 创建好作业后，先进入文件夹/home/acs/homework/lesson_4/，然后：
> (0) 进入homework_0文件夹，要求：
>     [1] 该文件夹内容为空
>     [2] 配置服务器账号的密钥登陆方式。服务器信息可以通过如下命令获得：
>         homework 4 getinfo
>         将服务器账号的名称（Host）配置成：myserver
> (1) 进入homework_1文件夹，下列描述中的“本地”均表示当前文件夹。要求：
>     [1] 在myserver服务器上创建并清空文件夹：~/homework/lesson_4/homework_1/
>     [2] 将本地的main.cpp文件上传到myserver中的~/homework/lesson_4/homework_1/目录中。
>     [3] 在本地创建文件夹dir。
>     [4] 将myserver中的/etc/lsb-release文件复制到dir中。
> (2) 进入homework_2文件夹，下列描述中的“本地”均表示当前文件夹，要求：
>     [1] 在myserver服务器上创建并清空文件夹：~/homework/lesson_4/homework_2/
>     [2] 将本地的dir文件夹上传到myserver中的~/homework/lesson_4/homework_2/目录中。
> (3) 进入homework_3文件夹，下列描述中的“本地”均表示当前文件夹，要求：
>     [1] 在本地创建文件夹dir。
>     [2] 将myserver中的/var/lib/locales/supported.d文件夹下载到本地dir文件夹中。
> (4) 进入homework_4文件夹，编写脚本remote_mkdir.sh和remote_rmdir.sh，要求：
>     [1] 在myserver服务器上创建并清空文件夹：~/homework/lesson_4/homework_4/
>     [2] 本地目录下仅包含remote_mkdir.sh和remote_rmdir.sh
>     [3] remote_mkdir.sh和remote_rmdir.sh具有可执行权限
>     [4] remote_mkdir.sh接收一个传入参数。格式为 ./remote_mkdir.sh directory_name
>         该操作可以在myserver服务器上的~/homework/lesson_4/homework_4/目录下，创建一个名为directory_name的文件夹
>     [5] remote_rmdir.sh接收一个传入传输。格式为 ./remote_rmdir.sh directory_name
>         该操作可以将myserver服务器上的~/homework/lesson_4/homework_4/目录下的名为directory_name的文件夹删掉。
>     [6] 注意：传入的文件参数可能包含空格。两个脚本均不需要判断传入参数的合法性。

# 后序内容初涉

git：项目版本回滚工具

thrift：多服务器之间信息交互

前端不难，只要使用一些比较友好的框架就行（boothstrap框架等等）

数据库、安全方面：有Django来进行负责
