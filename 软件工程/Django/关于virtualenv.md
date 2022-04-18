# 关于virtualenv

> vertualenv类似与pycharm的每个项目，它就是用来创建不同项目之间不同的虚拟环境的（各个应用所需的Python运行环境不同，比如包的版本不兼容等等）

首先，安装virtualenv

```shell
pip install virtualenv
```

然后创建一个项目，并创建独立的python运行环境

```shell
mkdir myproject
cd myproject
virtualenv --no-site-packages venv # 参数--no-site-packages代表不复制系统Python环境中的第三方包(也就是能得到一个完全干净的Python运行环境)
# 此时新建的Python环境被放在了当前的venv目录下
source venv/bin/activate # Linux系统
./venv/bin/activate # win系统(如果脚本无法运行需要到powershell管理员模式下手动开启)
# 此时命令提示符会出现(venv)前缀，代表加入了一个名为venv的Python虚拟环境
# 此时在虚拟环境下执行各种pip就是在虚拟环境下安装各种依赖包
# 技巧1:可以新建一个requirements.txt文件，将所有依赖包放在requirements.txt文件下，然后再虚拟环境下直接执行pip install -r requirements.txt即可(省去了手动一个一个安装包的时间)
deactivate # 使用
```

