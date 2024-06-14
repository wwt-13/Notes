# LFS-大文件存储

>   具体见：https://martinlwx.github.io/zh-cn/gitlfs/

总结：目前github不适合使用该方案，有1GB免费流量限制，付费50GB需要每月5美刀，贵得离谱

查找当前目录下所有文件大小超过100M的文件（也就是超出github限制的）

```bash
find . -type f -size +100M -exec ls -lh {} \; | awk '{printf("%s ",$5); for(i=9;i<=NF;i++)printf("%s ",$i) ; print("")}'
```

```bash
# 一行指令解决了
find . -type f -size +100M | sed -e 's/\.\///g' -e 's/ /\\ /g' > .gitignore
```

