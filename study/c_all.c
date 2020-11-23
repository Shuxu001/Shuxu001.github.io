///////////////数组和指针///////////////
数组作为形参会退化为指针,应该一起传入元素个数
数组作为形参和实参本质性质不一样
typedef和结构体struct结合使用可以少打几个字
因为定义结构体变量需要加上struct这个单词

void f(void);//可以
void a;//不行，因为不能确定分配空间的大小
void *p;//可以，万能指针，因为总是4或8字节
防止头文件重复包含
#pragma once
让c代码在c++编译器里可以用
#ifdef __cplusplus
extern "C"{
#endif
//内容
#ifdef __cplusplus
}
#endif

int b[10];
b和&b的数据类型不一样
b，数组首元素，一个元素4字节
&b，整个数组的首地址，一个数组4*10=40


内存四区
堆区(heap)Malloc/new,free/delete，操作系统管理 
栈区(stack)程序局部变量
全局区(global)文字常量区(char *p="asd"的asd,内容不可变)+静态变量区(static)+全局变量区(要在函数外面，静态变量在内部不一定是全局变量)，操作系统管理；  
代码区(code)操作系统管理

形参和实参中的指针
用n个*的指针(形参)去间接修改n-1个*的指针所指内容的值。
不要直接用形参，用临时变量。

const int a =100; //const修饰一个变量后不能直接修改，但可以用指针修改，只是不能a=10;
//从左往右看，跳过类型关键词，看修饰什么东西;
//如修饰*，表示指向的内存的内容不能变;
//如修饰p，表示指针的指向不能变，即指针的值;
const char *p = buf;//等价于char const *p1 = buf; 不能p[1]='2'修改buf，可以p="asd"重新指向
char * const p2 = buf;//只能指buf，但指的buf可以变，可以p[1]='2';
const char * const p3 = buf;//都不能变，只读;

在同目录的另一个文件里读上面的a：
extern const int a;//不能在赋值，只能声明


二级指针作输入，接收的是一级指针的地址，然后用*p来修改p指向(作为输出)。
指针数组 char *p[] = {"aaa","bbb","ccc"}; //p[0]是指向"aaa"的指针
形参char p[]换char *p，形参char *p[]换char **p就能跟上面一样使用"aaa"
char a[4][7]={0};//首行地址 和 首行的首元素地址 值一样意义不一样
a[i]和*(a+i)都表示第i行(共4行)的元素
//不写第1个[]的条件是必须要初始化，不能char a[][10];
p+1跳的长度=sizeof(*p)：a[4][7]的a+1跳7字节，&a+1跳28字节；b[28]的b+1跳1字节，&b+1跳28字节
但a作为形参**a传入的时候，就是个普通地址，a+1是跳4字节(指针本身的字节数)

二级指针
char **buf = (char **)malloc(n*sizeof(char *)); //n个一级指针的空间
//buf里保存n个 一级指针的地址,buf[i](或*buf)是一个指针，保存其它东西的地址
buf[i] = (char *)malloc(m*sizeof(char)); //buf[i]里保存m个 char的地址，即buf[i]指向一个m长的char数组
char str[m]="asd"; strcpy(buf[i],str); //因为buf[i]本身是一个地址，所以可以这么把整个str拷过去

sizeof(a) = 元素个数*元素类型
假如是int a[10]; a是首元素地址，结果是10*4字节,a[]一定要初始化
假如是int a[5][6]; a是首行地址，结果是5*24字节
p+1 = p的地址+p的元素(*p)的大小，+1个元素的意思

二维数组int a[5][6]
 	     &a	：整个数组 的地址，&a+1跳120
    a		：第０行 的地址，a+1跳24
    a+i 	-> &a[i]	：第ｉ行 的地址，a+1跳24
  *(a+i) 	-> a[i]	：第ｉ行第０个元素 的地址，+1跳4
  *(a+i)+j 	-> &a[i][j]	：第ｉ行第ｊ个元素 的地址
*(*(a+i)+j)	-> a[i][j]	：第ｉ行第ｊ个元素 的值
行地址->元素地址加*；符号*(a+i)和a[i]效果一样，但*优先级高，但指针和数组名是有区别的
注：当a用(int*)a传给形参int*a时，会把a当成一维数组，空间上还是连续的，a+1跳4字节，
	不传递“二维数组”这个信息，当成普通指针，传入元素个数用sizeof(a)/sizeof(a[0][0])

指针数组：指针作为元素的数组，如char *a[]={"aa","bb","cc"}
数组指针：指向一个数组的指针，假如已经有int a[10]; 
　方式1：typedef int A[10]; A *p=NULL; p=&a; //*p就当数组名用，取值用(*p)[2]
　方式2：typedef int (*P)[10]; P p; p=&a; //常用，()和[]优先级一样，左往右；
　方式3：int (*p)[10]; p=&a; //直接定义，但要注意那个10不要越界，否则可能会出错
二维数组b[5][6]时，p=b; //因为此时b是一个行地址，表示让p指向第0个长6的数组，p+1跳6*4字节
二维数组用p=&b时是指向整个
//argc：传入参数个数，含自己的程序名字
//argv：指针数组，每个元素是传入参数的指针
int main(int argc,char*argv[]){...}
二维数组传给形参时，可以把二维数组变量名传给一个数组指针
int a[5][6]; fun(a); 定义void fun(int (*p)[6]){}  
上面p是指向一个长6的一维数组，可以用p[i][j]来取值。


////////////结构体//////////////////
【结构体类型和变量】
结构体是复合类型，自定义类型
struct Abc{
    char a[10];//定义的时候不要赋值
    int b;//此时只是类型，还没分配空间
}; //注意分号，一般定义在main()的外面。
struct Abc x1= {"qwer",1234}; //常用
struct Abc {}x2={"qwe",1},x3; //偶尔用
struct {}x4,x5; //不常用
typedef改变类型名struct Abc成ABC
typedef struct Abc{}ABC; //常用
使用：x1.a; x1.b; //点运算符
指针法：
ABC *p = NULL;p=&x1;//不指定&x1会报错
strcpy(p->a,"qwe");p->b=123;
或者(*p).a;(*p).b;//*p就是这个结构体
结构体变量里的值相互赋值
ABC x1 = {"qwer",1234};
ABC x2 = x1;//x1成员的值拷给x2，本身无关
ABC x3; memset(&x3,0,sizeof(x3));
copyAbc(&x3,&x1); //直接x1,x3不可以

【静态数组】
ABC x[3]={{"a",1},{"b",2},{"c",3}};
ABC x[3]={"a",1,"b",2,"c",3};//中间{}省
//两种情况下x+1都是跳一个结构体
【动态数组】
ABC *p=(ABC*)malloc(3*sizeof(ABC));
使用均p[1].a;//动态中p是地址，p[1]是元素

【结构体嵌套一级指针】
typedef struct Abc{
    char *a; int b;
}ABC;
【方法一：直接定义变量，再动态malloc
ABC x1;x1.a=(char*)malloc(30);
strcpy(x1.a,"qwer");x1.b=1234;
【方法二：指针法+2次malloc
ABC *p=NULL;p=(ABC*)malloc(sizeof(ABC));
p->a=(char*)malloc(30);//先释放p->a
strcpy(x1.a,"qwer");x1.b=1234;
【方法三：结构体数组中
ABC *p=NULL;p=(ABC*)malloc(3*sizeof(ABC));
p[i].a=(char*)malloc(30);//p[i]是元素

【结构体作为形参】
操作元素先取地址：&x1
操作数组用变量名：p
生成数组也取地址：&p

【结构体套二级指针】
typedef struct Abc{
    char **a; int b;
}ABC;
假设a指向n个指针，每个都指l长的字符数组。
【对于ABC x1;静态方式
一般先char **a = NULL;再二次malloc：
x1.a=(char**)malloc(n*sizeof(char*));
x1.a[k]=(char*)malloc(l*sizeof(char));
此时把a换成x1.a就好了。
【对于ABC *p=NULL;动态方式，假设就1个
先 p=(ABC*)malloc(sizeof(ABC));
再 p->a=(char**)malloc(n*sizeof(char*));
末 p->a[k]=(char*)malloc(l*sizeof(char));
【对于ABC *p=NULL;且指向m个ABC，
先 p=(ABC*)malloc(m*sizeof(ABC));
再 对p[i]用上面的方式操作 m 次
i=0~m-1，j=0~n-1，注意p[i].a[j]的意义
p[i].a=(char**)malloc(n*sizeof(char*));
p[i].a[j]=(char*)malloc(l*sizeof(char));
三层malloc分别是m个ABC,n个a,l个char
【再1个ABC时没有p[0].a，只能p->a或(*p).a

【结构体深拷贝和浅拷贝】
假设x1.a已经malloc了
浅拷贝：直接x2=x1;指向同一堆区内存，只能free一次
深拷贝：人为增加内容，重新拷贝，需要free两次
先x2.a进行malloc，再strcpy(t2.a,t1.a);
一般是结构体嵌套指针且malloc且=赋值才发生

【结构体的偏移量】
结构体定义好时，内存分配方式就确定了。
内部从低向高地址连续分配内存
字节对齐按最长的那个成员来对齐
嵌套结构体要考虑其中最长,char a[9]也是1
若char e[2];int f;double g;short h;
再嵌套有int a;double b;short c;的结构体
先确定最长的是8字节，再依次找空位放
e e * * f f f f	放f由4*1有空，*为空位
g g g g g g g g	放g由8*1有空
h h * * * * * *	放嵌套结构体前填满前面的
a a a a * * * *	嵌套的从对齐点开始
b b b b b b b b	
c c c c * * * *	最后补满
#pragma pack(2) //指定对齐单位为2字节
int a;char b;short c;char d;
a a //指定后大于2的用2来算起始，a为2*0=0
a a
b *
c c
d *
#pragma pack(8) 
//超过最长的按原最长那个来对齐
int a;char b;short c;char d;
a a a a
b * c c
d * * *








