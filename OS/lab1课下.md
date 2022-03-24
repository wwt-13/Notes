# lab1课下

程序基本入口（暂定）

```c
void printf(char *fmt,...){//这里传入的是调用printf.c是输入的参数
    va_list ap;//定义参数指针
    va_start(ap,fmt);//借助固定参数初始化参数指针
    lp_Print(myoutput,0,fmt,ap);//???暂时还没看懂(关于lp_Print函数的定义在print.c文件中)
    va_end(ap);//重置参数指针为0
}
```

myoutput函数

```c
static void myoutput(void *arg,char *s,int l){
    int i;
    
    if((l==1)&&(s[0]=='\0'))return;
    
    for(i=0;i<l;i++){
        printcharc(s[i]);//输出一个字符？(定义位于console.c文件中)
        if(s[i]=='\n')printcharc('\n');
    }
}
```

首先注意,myoutput函数是没问题的，需要补全的就是lp_Print函数！

