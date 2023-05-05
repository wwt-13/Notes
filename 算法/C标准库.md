[toc]

# C标准库

## ctype.h

|                             函数                             |                   描述                   |
| :----------------------------------------------------------: | :--------------------------------------: |
| [int isalnum(int c)](https://www.w3cschool.cn/c/c-function-isalnum.html) |  该函数检查所传的字符是否是字母和数字。  |
| [int isalpha(int c)](https://www.w3cschool.cn/c/c-function-isalpha.html) |     该函数检查所传的字符是否是字母。     |
| [int islower(int c)](https://www.w3cschool.cn/c/c-function-islower.html) |   该函数检查所传的字符是否是小写字母。   |
| [int ispunct(int c)](https://www.w3cschool.cn/c/c-function-ispunct.html) | 该函数检查所传的字符是否是标点符号字符。 |
| [int isspace(int c)](https://www.w3cschool.cn/c/c-function-isspace.html) |   该函数检查所传的字符是否是空白字符。   |
| [int isupper(int c)](https://www.w3cschool.cn/c/c-function-isupper.html) |   该函数检查所传的字符是否是大写字母。   |
| [int isxdigit(int c)](https://www.w3cschool.cn/c/c-function-isxdigit.html) | 该函数检查所传的字符是否是十六进制数字。 |
| [int tolower(int c)](https://www.w3cschool.cn/c/c-function-tolower.html) |     该函数把大写字母转换为小写字母。     |
| [int toupper(int c)](https://www.w3cschool.cn/c/c-function-toupper.html) |     该函数把小写字母转换为大写字母。     |

## math.h

|                             函数                             |                             描述                             |
| :----------------------------------------------------------: | :----------------------------------------------------------: |
| [double acos(double x)](https://www.w3cschool.cn/c/c-function-acos.html) |                返回以弧度表示的 x 的反余弦。                 |
| [double asin(double x)](https://www.w3cschool.cn/c/c-function-asin.html) |                返回以弧度表示的 x 的反正弦。                 |
| [double atan(double x)](https://www.w3cschool.cn/c/c-function-atan.html) |                返回以弧度表示的 x 的反正切。                 |
| [double atan2(double y, double x)](https://www.w3cschool.cn/c/c-function-atan2.html) | 返回以弧度表示的 y/x 的反正切。y 和 x 的值的符号决定了正确的象限。 |
| [double cos(double x)](https://www.w3cschool.cn/c/c-function-cos.html) |                    返回弧度角 x 的余弦。                     |
| [double cosh(double x)](https://www.w3cschool.cn/c/c-function-cosh.html) |                     返回 x 的双曲余弦。                      |
| [double sin(double x)](https://www.w3cschool.cn/c/c-function-sin.html) |                    返回弧度角 x 的正弦。                     |
| [double sinh(double x)](https://www.w3cschool.cn/c/c-function-sinh.html) |                     返回 x 的双曲正弦。                      |
| [double tanh(double x)](https://www.w3cschool.cn/c/c-function-tanh.html) |                     返回 x 的双曲正切。                      |
| [double exp(double x)](https://www.w3cschool.cn/c/c-function-exp.html) |                    返回 e 的 x 次幂的值。                    |
| [double log(double x)](https://www.w3cschool.cn/c/c-function-log.html) |            返回 x 的自然对数（基数为 e 的对数）。            |
| [double log10(double x)](https://www.w3cschool.cn/c/c-function-log10.html) |           返回 x 的常用对数（基数为 10 的对数）。            |
| [double pow(double x, double y)](https://www.w3cschool.cn/c/c-function-pow.html) |                      返回 x 的 y 次幂。                      |
| [double sqrt(double x)](https://www.w3cschool.cn/c/c-function-sqrt.html) |                      返回 x 的平方根。                       |
| [double ceil(double x)](https://www.w3cschool.cn/c/c-function-ceil.html) |              返回大于或等于 x 的最小的整数值。               |
| [double fabs(double x)](https://www.w3cschool.cn/c/c-function-fabs.html) |                      返回 x 的绝对值。                       |
| [double floor(double x)](https://www.w3cschool.cn/c/c-function-floor.html) |              返回小于或等于 x 的最大的整数值。               |
| [double fmod(double x, double y)](https://www.w3cschool.cn/c/c-function-fmod.html) |                    返回 x 除以 y 的余数。                    |

## stdio.h

|                             序号                             |                         函数 & 描述                          |
| :----------------------------------------------------------: | :----------------------------------------------------------: |
| [int fclose(FILE *stream)](https://www.w3cschool.cn/c/c-function-fclose.html) |              关闭流 stream。刷新所有的缓冲区。               |
| [int feof(FILE *stream)](https://www.w3cschool.cn/c/c-function-feof.html) |             测试给定流 stream 的文件结束标识符。             |
| [int fflush(FILE *stream)](https://www.w3cschool.cn/c/c-function-fflush.html) |                 刷新流 stream 的输出缓冲区。                 |
| [int fgetpos(FILE *stream, fpos_t *pos)](https://www.w3cschool.cn/c/c-function-fgetpos.html) |       获取流 stream 的当前文件位置，并把它写入到 pos。       |
| [FILE *fopen(const char *filename, const char *mode)](https://www.w3cschool.cn/c/c-function-fopen.html) |       使用给定的模式 mode 打开 filename 所指向的文件。       |
| [size_t fread(void *ptr, size_t size, size_t nmemb, FILE *stream)](https://www.w3cschool.cn/c/c-function-fread.html) |       从给定流 stream 读取数据到 ptr 所指向的数组中。        |
| [FILE *freopen(const char *filename, const char *mode, FILE *stream)](https://www.w3cschool.cn/c/c-function-freopen.html) | 把一个新的文件名 filename 与给定的打开的流 stream 关联，同时关闭流中的旧文件。 |
| [int fseek(FILE *stream, long int offset, int whence)](https://www.w3cschool.cn/c/c-function-fseek.html) | 设置流 stream 的文件位置为给定的偏移 offset，参数 *offset* 意味着从给定的 *whence* 位置查找的字节数。 |
| [int fsetpos(FILE *stream, const fpos_t *pos)](https://www.w3cschool.cn/c/c-function-fsetpos.html) | 设置给定流 stream 的文件位置为给定的位置。参数 *pos* 是由函数 fgetpos 给定的位置。 |
| [long int ftell(FILE *stream)](https://www.w3cschool.cn/c/c-function-ftell.html) |              返回给定流 stream 的当前文件位置。              |
| [size_t fwrite(const void *ptr, size_t size, size_t nmemb, FILE *stream)](https://www.w3cschool.cn/c/c-function-fwrite.html) |     把 ptr 所指向的数组中的数据写入到给定流 stream 中。      |
| [int rename(const char *old_filename, const char *new_filename)](https://www.w3cschool.cn/c/c-function-rename.html) |      把 old_filename 所指向的文件名改为 new_filename。       |
| [void rewind(FILE *stream)](https://www.w3cschool.cn/c/c-function-rewind.html) |          设置文件位置为给定流 stream 的文件的开头。          |
| [void setbuf(FILE *stream, char *buffer)](https://www.w3cschool.cn/c/c-function-setbuf.html) |                  定义流 stream 应如何缓冲。                  |
| [int fprintf(FILE *stream, const char *format, ...)](https://www.w3cschool.cn/c/c-function-fprintf.html) |                发送格式化输出到流 stream 中。                |
| [int printf(const char *format, ...)](https://www.w3cschool.cn/c/c-function-printf.html) |              发送格式化输出到标准输出 stdout。               |
| [int sprintf(char *str, const char *format, ...)](https://www.w3cschool.cn/c/c-function-sprintf.html) |                   发送格式化输出到字符串。                   |
| [int fscanf(FILE *stream, const char *format, ...)](https://www.w3cschool.cn/c/c-function-fscanf.html) |                 从流 stream 读取格式化输入。                 |
| [int scanf(const char *format, ...)](https://www.w3cschool.cn/c/c-function-scanf.html) |              从标准输入 stdin 读取格式化输入。               |
| [int sscanf(const char *str, const char *format, ...)](https://www.w3cschool.cn/c/c-function-sscanf.html) |                   从字符串读取格式化输入。                   |
| [int fgetc(FILE *stream)](https://www.w3cschool.cn/c/c-function-fgetc.html) | 从指定的流 stream 获取下一个字符（一个无符号字符），并把位置标识符往前移动。 |
| [char *fgets(char *str, int n, FILE *stream)](https://www.w3cschool.cn/c/c-function-fgets.html) | 从指定的流 stream 读取一行，并把它存储在 str 所指向的字符串内。当读取 **(n-1)** 个字符时，或者读取到换行符时，或者到达文件末尾时，它会停止，具体视情况而定。 |
| [int fputc(int char, FILE *stream)](https://www.w3cschool.cn/c/c-function-fputc.html) | 把参数 char 指定的字符（一个无符号字符）写入到指定的流 stream 中，并把位置标识符往前移动。 |
| [int fputs(const char *str, FILE *stream)](https://www.w3cschool.cn/c/c-function-fputs.html) |      把字符串写入到指定的流 stream 中，但不包括空字符。      |
| [int getc(FILE *stream)](https://www.w3cschool.cn/c/c-function-getc.html) | 从指定的流 stream 获取下一个字符（一个无符号字符），并把位置标识符往前移动。 |
| [int getchar(void)](https://www.w3cschool.cn/c/c-function-getchar.html) |      从标准输入 stdin 获取一个字符（一个无符号字符）。       |
| [char *gets(char *str)](https://www.w3cschool.cn/c/c-function-gets.html) | 从标准输入 stdin 读取一行，并把它存储在 str 所指向的字符串中。当读取到换行符时，或者到达文件末尾时，它会停止，具体视情况而定。 |
| [int putc(int char, FILE *stream)](https://www.w3cschool.cn/c/c-function-putc.html) | 把参数 char 指定的字符（一个无符号字符）写入到指定的流 stream 中，并把位置标识符往前移动。 |
| [int putchar(int char)](https://www.w3cschool.cn/c/c-function-putchar.html) | 把参数 char 指定的字符（一个无符号字符）写入到标准输出 stdout 中。 |
| [int puts(const char *str)](https://www.w3cschool.cn/c/c-function-puts.html) | 把一个字符串写入到标准输出 stdout，直到空字符，但不包括空字符。换行符会被追加到输出中。 |
| [int ungetc(int char, FILE *stream)](https://www.w3cschool.cn/c/c-function-ungetc.html) | 把字符 char（一个无符号字符）推入到指定的流 stream 中，以便它是下一个被读取到的字符。 |