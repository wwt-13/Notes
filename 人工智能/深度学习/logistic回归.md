# logistic回归

>   logistic回归是一种用于二分分类问题的算法（比如说输入一张图片，输出该图片中是否含有某物（cat:1 or non cat:0））

## 常见notation

|                           notation                           |                          含义                          |                        附加                         |
| :----------------------------------------------------------: | :----------------------------------------------------: | :-------------------------------------------------: |
|    $(x,y)\\ x\in \mathbf{R}^{nx},y\in \left\{0,1\right\}$    | 代表一个单独的样本，其中$x$是$nx$维的特征向量，y是0或1 |                                                     |
|                             $m$                              | 训练集由m个训练样本构成，$(x^{i},y^{i})$代表第i个样本  | 一般使用$m_{test}$表示测试集，$m_{train}$表示训练集 |
| $X=\begin{bmatrix}x^1&x^2&\cdots&x^m\end{bmatrix},X\in \mathbf{R}^{nx\times m}$ |                     整体的输入集合                     |                                                     |
| $Y=\begin{bmatrix}y^1&y^2&\cdots&y^m\end{bmatrix},Y\in \mathbf{R}^{1\times m}$ |                     整体的输出集合                     |                                                     |

## 二分分类问题

输入为x，期望得到的输出是$\hat{y}=P(y=1|x)$，也就是说输入x，要给出该输入是否含有所需物的概率大小（比如判断一张图像是否含有狗）
$$
\hat{y}=\sigma(w^Tx+b)\\
\sigma=\frac{1}{1+e^{-x}}
$$
$\sigma$是sigmod函数，其目的是为了将数据映射到0~1这个区间上

损失函数：用于衡量算法在单个训练样本上表现的函数，在logistic回归中，损失函数为👇🏻
$$
L(\hat{y},y)=-\left[ylog(\hat{y})+(1-y)log(1-\hat{y})\right]
$$
成本函数：用于衡量算法在整体训练上表现的函数
$$
\begin{align}
J(w,b)
&=\frac{1}{m}\sum\limits^{m}_{i=1}L(\hat{y}^i,y^i)\\
&=-\frac{1}{m}\sum\limits^{m}_{i=1}\left[y^ilog(\hat{y}^i)+(1-y^i)log(1-\hat{y}^i)\right]
\end{align} 
$$
梯度下降法：重复做$w:=w-\alpha\frac{dJ(w)}{dw}$以及$b:=b-\alpha\frac{dJ(b)}{db}$，其中$\alpha$代表的是学习率，用于控制每次迭代或者梯度下降法中的步长，同时我们约定俗成$dw=\frac{dJ(w)}{dw},db=\frac{dJ(b)}{db}$，由于$J(w,b)$始终为凹函数，所以可以保证是梯度下降的（其实就是求偏导）

重定义👇🏻
$$
\begin{align}
z&=w^Tx+b\\
\hat{y}&=a=\sigma(z)\\
L(a,y)&=-(ylog(a)+(1-y)log(1-a))
\end{align}
$$
  计算图求导得👇🏻（这里是对logistic回归的**一个特定样本**使用梯度下降方法）
$$
\begin{align}
da&=\frac{dL(a,y)}{da}=-\frac{y}{a}+\frac{1-y}{1-a}\\
dz&=\frac{dL(a,y)}{dz}=\frac{dL(a,y)}{da}\frac{da}{dz}=a-y\\
dw_i&=\frac{dL(a,y)}{dw_i}=x_idz\\
db&=dz
\end{align}
$$
如果要对整体使用梯度下降呢，同理，只要将$dwi$求和即可
$$
\frac{dJ(w,b)}{dw_i}=\frac{1}{m}\sum\limits^{m}_{i=1}\frac{dL(a^i,y^i)}{dw_i}
$$

## 向量化

>   是一种用于消除代码中显式for循环语句的手段

不要使用秩为1的矩阵

```python
a=np.random.randn(5) # 这种得到的就是秩为1的矩阵
# 应该使用下面这种方法
b=np.random.randn(5,1) # 显式指定矩阵的高宽
```

## cost函数证明

$$
因为y\in\left\{0,1\right\}\\
if\ y=1: p(y|x)=\hat{y}\\
if\ y=0: p(y|x)=1-\hat{y}\\
根据伯努利分布，这种0-1分布可以化简为一个式子\\ 
p(y|x)=\hat{y}^y(1-\hat{y})^{1-y}\\
因为损失函数是用来优化参数的嘛，我们不需要知道它的具体值是多少，只要有一个增长趋势就可以了\\ 所以可以使用一个对数函数ln来进行化简，同时不改变其单调性\\ 
有因为损失函数优化时，一般要求最小化，所以又添加了负号，最终得到👇\\
L(\hat{y},y)=-\left[ylog(\hat{y})+(1-y)log(1-\hat{y})\right]
$$

