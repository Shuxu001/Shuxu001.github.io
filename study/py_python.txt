NPP_SAVE
cmd /k D:\python3\python3.exe "$(FULL_CURRENT_PATH)" & ECHO. & PAUSE & EXIT
NPP_CONSOLE 0


import module
//用b=a赋值字典虽然a is b，这是指a修改时b会改，但是a不再是字典时，b不变

例 import math再math.floor(); math.ceil()
abs, round不用import
不从不同模块导入同名函数时，可以使用变种，from math import sqrt再sqrt(9)
nan = not a number
复数import cmath

str和repr
原文：str对人友好，repr对解释器友好

三引号，长字符串；用\换行继续写；字符串前面加r是原始字符串，串中不会把\n变回车，但是不能用\结尾，如果非要用\结尾，那就 r"前面的" '\\' 来手动加反斜杠

Unicode的用法：用\u加4位16进制或\U加8位16进制的UNICODE码或\N{name}

a = bytes("hello",encoding='utf-8')把字符串变成bytes对象
a = str(b'xxxxx'，encoding='utf-8')把bytes对象变成字符串

序列=列表、数组、字符串……
标准序列操作：索引、切片、乘法、成员资格、长度、最值

列表：python的主力
list：可以a = [ [1,2] , ['xyz',4] ]，然后a[1][0][1]='y'
索引-1是从后面开始
[ ]内部可以直接换行输入而不需要加\，不过加也可以，但是逗号不要忘记，然后会自动合并字符串，因为'a' 'b' = 'ab'
切片：形式[3:7]，同matlab，但是第二个序号不包含，即[首：末+1]，如果不写首就从头开始，不写末+1就倒尾结束，如果前一个在后一个的后面（跟序号大小无关，指的是实际位置），会返回一个空序列
需要用到步长时，为[首：末+1：步长(默认1)]，步长为负时，往左数，这时候前一个不能在后一个的前面，-1就是挨着拿
list('xyz')可以把'xyz'变成['x','y','z']
''.join(['x','y','z'])可以变回'xyz'
序列相加：用加号+只能是同类型的序列，但是把'xyz'加上[]成为list就可以了

空列表和乘法：a = [None] * 10

成员资格：用in判断某值是否在序列中，返回布尔运算符
长度len()，最小值min()，最大值max()

列表list操作：
修改：同matlab
删除：del name[2:6]，删了序号2到5的，长度缩短
替换：name[2:6]=[...]，...为空就是删除
增加：name[2:2]=[...]，在序号2前(即第2个后)添[...]
列表方法：
lst.append(某)，把某加到列表lst的末尾
lst.clear()，就地清空，变成空列表[]
lst.copy()，b=a.copy()不满足a is b！！！
lst.count(某)，返回某在lst中出现了几次
lst.extend(某)，效率比（lst=lst+某）高
lst.index(某)，返回某第一次出现的序号
lst.insert(序号，某)，在序号位置插入某
lst.pop(n)，删序号n的值并返回，默认末个
引申：append()和pop()等同于“栈”的操作
引申：队列时，可以用pop(0)来拿出最早那个
lst.remove(某)，把值=某的第一个值移除
lst.reverse()，就地倒序；别于reversed
lst.sort()，就地升序，要降序就再reverse
警告：b=a; a.sort()后，b也会被sort()
引申：可以先b=a.copy()或b=sorted(a)
高级排序，sort()的参数key和reverse
比如：key=len 和 reverse=True别true

元组：不可修改的序列，用圆括号( )
一般a=(1,2,3)，只有一个数时a=(1,)有逗号
元组的名字是tuple，用它可转list或str为tuple
方法：没有index和count，其余同列表

【设置字符串】
方法一：%s，转换说明符，指出把值插入到什么地方，s表示格式，同理还有f等，可以%6.1f
>>>format='xxx %s, %s xxx'
>>>values=('a','b');
>>>format % values
这里也可以print(format % values)
方法二：$xxx，模板字符串
>>> from string import Template 
>>> tmpl = Template("Hi $who! $what?") 
>>> tmpl.substitute(who="Tom", what="Oh") 
方法三：{ }，索引，含2种，可混用，把012的放前
>>>"{1} {0}, {2} {0}".format("jump", "i", "u") 
>>>"i {do}, u {do}".format(do='jump')
升级：
>>>ren = ['i','u']
>>>"{who[0]} jp, {who[1]} jp".format(who=ren)
注注注：这个太多了，以后再说。

字符串方法：以下a、b、c都是字符串
center：a.center(40,'*')，40总宽居中用*填充
find：a.find('某某')，返回某中首个某某的位置，没有则-1，而in只能找一个字符
join：a.join(b)，用a作连接符，合并b中的元素，比如a='+'，b=['1','2','3']，连接后是'1+2+3'
split：b.split(a)，以a为标记拆分b，上面的逆过程
lower：a.lower()，a中的大写字母全变小写
title：a.title()，a中的单词的首字母全变大写
replace：a.replace(b,c)，把a中的b全变c
strip：a.strip(b)，把a中头尾的b全删除，此处b中有的就删，而不是按b删，没有b时只删空格
translate：高效替换字符，用码点映射，用时再查
isspace、isdigit、isupper等：判断字符串是否满足条件

字典：当索引行不通时
利用映射，键：值，这称为一“项”
比如phonebook = {'A' : '1', 'B' : '2', 'C' : '3'}
dict：创建字典，从已有的映射关系或直接用实参
-从键值对：d=dict([对1,对2,...])  对=(键，值)
-直接实参：d=dict(键1=值1,键2=值2)，
-注：此处键名注意引号的使用，键名可以是整数小数，甚至可以用元组，但这里不能用dict(1=2)，而如果a=3，用dict(a=4)，是{'a':4}
方法：
len(d)：返回项数
d[键]：返回值
d[键]=值：增/改键值，这里要引号'a'，不然就是a的值对应的键，此外这个方法可以增加用数或元组表示的键
del d[键]：删除
a in d：查找键名，要注意的是，a in d和'a' in d的区别
-可以字典里面套字典：d={'a':{...},'b':{...},... }
-可以字符串里套字典："xxxx {A}".format_map(dict)，A是dict的键
d.clear()：清空d，但d还是字典，返回None值
-若有dd=d，那用d.clear()会把dd一并清空，而d={}不会
dd=d.copy()：相比于dd=d，替换d的东西时，copy()者不变，=者变，因为此copy()不满足dd is d
-就地修改(remove/extend/append/reverse/insert等方法)时，用dd=d.copy()和dd=d都变，尽管copy不满足is，而=满足is，这一点不同于list中，list用这些函数，copy()出来的也不会变，这是因为copy()是浅复制，其字典中的“值”仍然是原件，就地修改时会被跟随，因此利用copy模块中的deepcopy()，这个会一并复制一份值，然后就地修改就不会dd一起变了
d=dict.fromkeys(['a','b'])或者d={}..fromkeys(['a','b'])，创建新字典，默认值None，如果要改默认值就（[...]，默认值）
d.get(键名,默认值)，如果键名有，=d[键名]，如果没有则返回默认值
d.items()：一个包含所有键值对的格式，叫字典视图，可以用来做成list或dict，（直接list(d.items())即可），可用以确认长度和资格检查
d.keys()：返回一个包含所有键(不带值)的字典视图
d.values()：返回一个包含所有值(不带键)的字典视图，值会重复
d.pop(键)：提取键的值，并删除项
d.popitem()：随机弹出一个项(元组形式)，并删除，没啥软用的方法
d.setdefault(键，值)：键存在则返回当前值，不修改；不存在则更新字典并返回设定值（如果默认值是[]就可接.function来操作）
d.update(dd)：用dd的项来更新d的同(键)名的项，无则添，有则改

==章节==语句==
print设置分隔符用sep='_'，不换行用end=' '
import不要无脑全导入，可能有重名函数，要module1.open(...)和module2.open(...)，最好from somemodule import somefunc
as：给module新名字，import math as shuxue；给function新名字，from math import sqrt as kaifang
序列解包：
-可以用tuple元组来给等长度的变量赋值，变量不足时用*rest来装剩下的值（得到一个列表），*rest可以在前中后任意位置
-可以用来迭代：x,y=y,x
链式赋值：x=y=f()，等价于y=f();x=y，但不等价于x=f();y=f()
增强赋值：x+=某，数则加，符则串
代码块：用缩进表示
条件语句：
作为判断时，False/None/0/""/()/[]/{}都是表示假，其他都是真
-但是，[] != ""，尽管bool([]) == bool("")
变量 = 选项1 if 判断语句 else 选项2
elif是else if的缩写
比较运算符：除了常见的，还有is not 和not in，关于大小，用ord可以得到符号的顺序值，用chr可以用顺序值得到符号（只限单符号），另外在python里可以链式比较：1<a<10
断言（assert）： assert 判断句，'提示'。核实失败时会报错并提示

---循环：
while循环：判断语句		for循环：遍历
while 条件:		numbers=[0,1,2,3...]
(缩进)	语句块		for number in numbers:
			(缩进)	语句块
迭代字典：
可以在for中，对items的元组解包：
for key,value in d.items()
(缩进)	语句块
遍历键，直接d；遍历值，用d.values()；遍历项，用d.items()
一些迭代工具：
函数zip(a,b)：(返回)把两个序列缝合起来list( zip(a,b) )、tuple、dict
函数enumerate(a)：(返回)给把(0,1,2,3...)和序列a缝合
函数reversed和sorted：(返回)反序和升序
函数range(首,末(不含),步长)，可大往小，步长为负
函数break：跳出当前循环
函数continue：结束目前迭代，后面的都不看了，开始下次循环，但没有跳出循环
实例：while True + break：死循环中用if来break
简单推导：list/tuple( f(x) for x in range(5) )
-升级：2个for，后面if condition
-可以用列表和字典推导，但是不能元组（它会创建生成器）

三人行：
语句pass：什么都不做，不知道写什么时写这个
语句del：del a，删除a这名称，不删a原来等于的值，因此原有b=a的话，虽然a is b，但是b不删除，也可以用a = None
语句exec("某")：将字符串作为代码执行，此处如果将函数名作为变量名，会污染函数而不可用
-解决方法：放到另一个命名空间里
-作法：exec("sqrt=1",scope)，scope是一个命名空间，是字典式存储，也是用字典的方式调用
函数eval：返回用字符串表示的表达式的值，也可以给他一个命名空间：eval('x+y',scope)，在scope中有{'x':2, 'y':3}，当然也有别的自带的。


抽象：
callable：判断是否可调用（是否为函数）
用def定义函数：
def function_name(parameter):
	xxx
	return xxx
给函数编写文档：在def的下一行（也就是语句块的第一行）添加一段字符串'i am doc'，然后可以用function_name.__doc__来返回这个字符串。
如果不返回想要的东西，就在return后面什么都不加，系统自动返回None
关于函数：
-在函数内部替换(而非就地修改)形参(变量)的值，对实参(值)没有影响(同C语言)
--注：用函数时，第一步是相当于把原来的值(实参)用“=”赋值给形参，所以跟a=b在替换(而非就地修改)是一样的，如：a=1;b=a;b=2;仍a=1。而就地修改是用“方法（.append()）”或肉眼可见的修改（lst[2]=1）。注意字符串、数、元组都是只能替换的，列表和字典是可以就地修改的。
--对列表和字典来说，赋值是“修改了关联”，所以就地修改会影响到原来值，为了避免而达到字符串、数、元组的效果，可以用a=b[:]来创建相等但不同(is为False)的列表。

在python中没有类似C语言的指针那样可以直接修改函数外部变量的手段，为了实现，要么用列表来传递进去（上面说了，列表赋值时是修改关联，达到类似指针的效果），要么返回想要改变的值并赋给想要改变的量。

关键字参数：直接用 形参=实参 放在函数的括号里，这样就不用管顺序了，这挺好的。优点1：因为有时候一堆都是数，不知道哪个数是什么意思；优点2：定义函数时候可以用这个来指定默认值。

参数收集：在def时用f(*param)，这样所有的参数会以原顺序归成一个元组。
上一次用星号*：a,*b,c,d=(1,2,3,4,5)后b=[2,3]。注意单长元组为(某,)有个逗号
但在函数中想把*放中间如f(a,*b,c,d)，要调用时用关键字参数指定后续(即c和d)
-单星号不会收集关键字参数，双星号可以，并用字典来存，而非元组；
-以上所有（位置参数，关键字参数，单双星号收集参数）可并存

作用域
全局变量放在一个字典中，用函数vars()可以返回这个字典
用def定义函数，是新建一个作用域，不影响全局，但是如果重名，在函数内调用时，会默认用局部变量（若想用全局变量，可globals()['变量名']来访问），如果局部变量没有遮盖，那全局变量可以直接拿来用。
-此外可以在函数内用global x来定义全局变量x

可以用 return fuction 不带括号来返回一个“函数名”，解释：
def f():			
      def function():
            return xxx
      return function		此处如果有括号，就直接运行了，a为xxx	
a=f()			从而就可以b=a()，这里a后面别忘括号

递归，函数一定条件下返回“运行自己的值”，所以return的函数名后需要()

map、filter、reduce：进行函数式编程的函数，举例说明
map(func,seq)：对seq的每个值用一次func
例：list( map( str,range(10) ) ) 等价于 [ str(i) for i in range(10) ]
filter(func,seq)：根据func的返回值的真假，来过滤出运算结果为真的元素
def func(x):
      return x.isalnum()	#判断，返回布尔值
list( filter( func,seq) )		#得到过滤完了的列表
等价于 [ x for x in seq if x.isalnum() ]
lambda表达式：filter(lambda x:x.isalnum(),seq)
所以，map和filter不如直接列表推导
reduce(双输入func,seq)：将seq前两个元素操作，再把得到的值同第三个元素操作，直到都操作完

第七章：对象、类、方法、
issubclass(a,b)：检查a是否为b的子类
isinstance(a,b)：检查a是否为b的实例
多态：对不同类型的对象执行相同的操作，"+"也是
方法：与函数属性相关联的函数
封装：向外部隐藏不必要的细节
类：定义如下，对象a=Xxxx()，注意有“括号”
class Xxxx:		#注意没“括号”
    def xxx(self,...):
        ....
类中的方法可以用a.xxx = yyy来修改，也可以用yyy=a.xxx来“关联”，注意没有“括号”
隐藏：在函数或属性前面加上“双下划线：__”，如def __xxx(self)，但仍然可以用在函数前面加“单下划线和类名”，比如a._Xxxx__xxx()来访问。
类的命名空间：特殊的作用域，在类中定义的变量，所有成员都能访问它
-类变量和self变量的区别：1.类变量定义在类中，用“类名.变量名”在方法中访问，所有实例共用；2.self变量要用到时直接“self.变量名”；3.创建了实例在调用方法时没什么区别；4.如果又直接用self.变量名给类变量名赋值，这个实例会“遮盖（访问不到）”的类变量。
继承（超类和子类）：可以重写方法，
class Yyy(Xxx):	#Yyy是Xxx的子类
子类的直接实例是超类的间接实例，用isinstance都是True，不过不知道是不是直接实例，所以可以用type(x)来知道所属的类。
多个超类：class Zzz(Xxx,Yyy):	#Zzz是Xxx和Yyy的子类。
hasattr(a,'b')：对象a是否存在属性b（比如一个方法或类变量），类中定义的xxx=x可True，但是在方法里的self.xxx=x不True。
getattr(a,'b','c')，返回a的属性b，没有时为'c'，用callable判断可否调用。
setattr(a,'b','c')，把a的属性b设置为'c'
抽象基类：在模块abc中，抽象类不应是实例化的类
from abc import ABC, abstractmethod
class Xxxx(ABC):
    @abstractmethod		#装饰器，将方法标记为抽象
    def xxx(self):
        pass
然后继承Xxxx并实现(重写)其方法xxx

第8章：异常
每个异常都是一个类
-常见异常：Exception通用(大多数异常从它派生)
(Exception、Systemexit和KeyboardInterrupt有同一个超类BaseException)
AttributeError引用属性或赋值失败	SyntaxError代码不正确
OSError	关于操作系统		IndexError	序列中不存在的索引
KeyError	映射中不存在的键		NameError找不到变量名称、
TypeError	函数用于类型不对的对象	ZeroDivisonError除数为0
ValueError函数用于类型对但值不合适的对象
raise 异常类型('提示语句')：手动引发异常；在except中可无参数(后文有)
自定义异常：class 异常名(Exception):pass 继承自通用异常
捕获异常：try/except语句
try:
    原本的语句
except 异常(类型)名:
    出现异常时的操作语句块A
抑制异常：针对A进行修改
...except 异常名:
    if 条件:		#抑制异常时
        操作
    else:		#关闭抑制时
        raise		#重新引发异常，可不带参数，也可引发别的异常
【这个没懂：raise xxxError from None】
捕获多个异常：
1.多个except 异常名：直接并列在后面
2.excep (异常名1,异常名2,异常名3……)：用一个元组把异常括起来
捕获对象：把异常的输出信息给 某 ，这个某可以后面进行操作，比如print(某)
except 异常名 as 某:
    语句块
一网打尽：except后面不写异常直接冒号；但更建议接“Exception as 某”
else/finally可以和try/except并列，表示：无异常时会怎么做/最后总会怎么做。
while True:
    try:
        操作
    except 异常 as 某:
        操作
    else:
        操作(break)
    finally:
        操作
异常和函数：异常会沿着调用函数的路径向外传播。
异常的好处：效率会高于if/else之类的，比如不用先检查存在与否，尽量用异常。
警告（没有异常那么严重）：from warnings import warn，后文warn('xxx')。


第9章：（魔法方法、特性、迭代器）
构造函数：__xxx__命名；在创建对象之后会自动调用。
在构造函数中，可以添加参数，对于必须输入的参数，在创建对象时放在类名后面的括号里：f=Foobar(参数)
重写方法时，一般就直接覆盖前面的，为了关联原来就有的：
1、可以在子类的构造函数中运行一次超类的构造函数：超类名.构造函数名(self)。这样在自动运行子类的这个构造函数时，会先运行一次超类的构造函数名，这样那里面初始化的东西就保存下来了。
2、函数super：子类的构造函数中，super().构造函数名；用super()代替'超类名'。一方面更直观，另一方面可能有多个超类能更方便。

元素访问：
1.基本的序列和映射协议：要给不可变对象实现2个方法，可变对象4个：（就用这个名字不能换）__len__(self)、__getitem__(self,key)、__setitem__(self,key,value)、__delitem__(self,key)
2.继承于list、dict、str：补充/重写

特性（property，亦是函数名）：这是一个神奇的函数；
用法：size = property(get_size, set_size)注意要获取在前，设置在后；
作用：然后size就成为了一个“属性”，本来是一个中间变量(假象属性)，只有用函数才能存取，现在可以像实际属性weight、height一样使用。但仍然受制于存取函数的执行的计算，只是说看起来像普通属性。
关于property的参数：无参数(不读不写)、一个(只读)、三个(删除)、四个(fget、fset、fdel、doc四个选择，指定一个文档字符串)。

（这些没懂？？）
静态方法：装饰器@staticmethod，后面的函数不需要参数
类方法：装饰器@classmethod，后面函数需要参数cls（表示自身类）
-作用：可以不实例化就用这些后面一行跟着的方法
__getattr__和__setattr__：也没看懂

迭代器：逐一返回值
包含三个构造函数：__init__()、__next__()、__iter__()
__init__()：用来初始化，在创建对象时只有这个会被自动调用；
__next__()：用来计算下一个值(也就是展现逻辑)，调用时返回下一个值
__iter__()：返回一个迭代器(自己return self)，不用给参数
也就是一个类包括上面三个方法，然后就是可以产生一个序列(不是list)
当前值时a.value（value是里面定义的），下一个是a.__next__()，a就是一个迭代的序列。
-表示迭代完了的异常：StopIteration


生成器：(可以完全不使用，但是用了会很好)
{生成器是有yield的函数；被调用时不会执行函数体内代码(而是返回一个迭代器)，但请求值会执行，直至遇到yield(生成一个值，暂停执行，直至再次被请求值)或return(停止执行、不再生成值)}
1.简单生成器：遍历元素，再逐个生成，每查到一个元素，yield 它，而不是return或print，然后函数暂停，等下一次被调用(比如循环中)时，yield 下一个元素。(实现一个个提取，类似于“操作 for i in 某序列”
2.递归式生成器：（功能：把一个嵌套序列的序列展开成纯数序列）
-若输入为单个数，直接展开(直接生成就好了，对它用in迭代会TypeError)；若输入为序列(可迭代对象)，遍历元素并逐一展开再逐一生成。
-但要注意的是，如果基本元素是个字符串，这个会被当成一个序列，它的子序列是一个个单一的字符串（因为单一字符串也是序列），会无限循环。【如下操作：将它和一个字符串拼接。如果不能拼会自动发生异常，说明不是字符串，就pass此异常而继续“展开”环节；如果能拼，说明它是字符串，这时候引发个一个类型异常(跟“数字不是序列”是同一个异常)，跳到“直接生成”环节】
def flatten(A):		# 把A展开成序列
    try:
#######判断A是字符串的部分###############
        try:			# 为了排除字符串的可能
            A + ' '		# 试试拼接
        except TypeError:	# 拼接失败时会引发这个错误
            pass		# 失败是想要的结果，所以pass
        else:
            raise TypeError	# 若是字符串就引发这个异常
#####################################
        for subA in A:		# 若A可迭代(非单一数)，遍历A
            for k in flatten(subA):	# 把元素subA展成序列(可迭代)并遍历
                yield k		# 逐一返回展开后序列中的值
    except TypeError:		# 若A不可迭代(单一数)会引发此异常
        yield A		# 此时就直接生成

3.通用生成器：包括生成器的函数(def定义，包含yield)+生成器的迭代器(函数返回的结果)。
4.生成器的方法：
send(某)和next(对象)：send(某)用来向生成器内部发送一个消息“某”，是yield表达式的返回值；next用来得到生成器的下一个“生成”的值(注意这里不是return“返回”的)，而因为yield在生成器内部时可能用作“表达式”（在用next时，yield返回None，在用send(某)时返回某）
throw：让yield表达式引发异常throw(异常)
close：停止生成器，不需参数
5.模拟生成器：用一个result=[]列表来逐一存放值，最后return result

八皇后问题：：
迭代思路：对于末行，直接逐个位置验证，成立后返回即可；对于非末行，在逐个验证成立的基础下，再组合上后行的可行解
def conflict(state, nextX):		# X列数Y行数
    nextY = len(state)			# 下一行
    for i in range(nextY):		# 验证跟前几行矛盾与否
        if abs(state[i] - nextX) in (0, nextY - i):   # 同列或对角线为矛盾
            print(state,nextY,'行; ',nextX,'列','矛盾')
            return True
    print(state,nextY,'行; ',nextX,'列','不矛盾')
    return False

def queens(num=8, state=()):	    # 迭代返回下面行的可行位置
    for pos in range(num):	    # pos是当前行的列数(位置)
        if not conflict(state, pos):	    # 当前行位置不能跟已有状态矛盾
            if len(state) == num-1:     # 如果是最后一行
                print('末',(pos,))
                yield (pos,)
            else:		    # 如果不是最后一行
                for result in queens(num, state + (pos,)):	
	# 生成的是后行的可行解
                    print('result=',result,'非末',(pos,) + result)
                    yield (pos,) + result    
# 当前行的位置与后行位置组合就是在已有位置条件下可以成立的总位置
list(queens(4))

////////////////////////////////////////////////
///////////////////第十章：模块///////////////
导入自定义模块：import sys; sys.path.append(绝对路径); import 模块名
importlib.reload(模块名)：重新导入，模块名不带引号。
dir(模块名无引号)：列出模块包含的东西。
help(函数/模块名) 和 函数/模块名.__doc__：帮助文档。
函数/模块名.__file__：列出源文件路径。

标准库：
库sys：访问与python解释器相关的变量和函数：sys.xxx：
-argv不懂、exit([arg])退出并返回输入的参数、modules一字典 将模块名映射到加载的模块、path一列表 能查找模块的目录、platform平台标识符如win32、stdin/stdout/stderr不懂 标准输入/输出/错误流 类似文件的对象。

库os：访问操作系统服务：os.xxx
-environ包含系统环境变量的映射的字典、system(command)不懂、sep路径中用的分隔符'\\'、pathsep分隔不同路径用的分隔符';'、linesep行分隔符'\r\n'、urandom(n)返回n个加密的随机数据

库fileinput：读写文件：
-input(files=文件名，inplace=True/False，...)、filename()返回当前文件名默认None、lineno()返回累计行数、filelineno()返回当前文件行数、isfirstline()检查是否为首行、isstdin()检查末行是否来自sys.stdin、nextfile()关闭当前文件进下一个(计数忽略被跳过的行)、close()关闭文件链

集合set：用set(序列)来创建，用花括号{1,2,3}罗列，
-不能用{}创建空集合，因为是空字典；自动去掉重复元素，没有排列顺序一说，主要用于成员资格检查&集合数学操作(交集&并集|差集-，两者各自有的集^，等)；集合的集合a.add(frozenset(b))；

库heapq，堆heap：具有“堆特征”的优先队列，任意顺序添加对象，并随时找出最小元素。二叉树上，每个数都比它的叉上的数要小。
-不是独立的类，用列表来表示，用库heapq中的特定函数来操作；heappush(a,x)把x放到堆a中；heappop(a)弹出a的最小值；heapify(a)让列表a具有堆特征；heapreplace(a,x)弹出a最小者，再压入x；nlargest(n,iter)返回iter中n个最大者；nsmallest(n,iter)返回iter中n个最小者（两个iter的算法高于先排序再切片）

库collections，双端队列：按添加顺序来删除，库中的deque类
-创建：q=deque(序列)；q.append(x)右添x；q.appendleft(x)左添x；q.pop()右删；q.popleft()左删；q.rotate(x)循环右移x次，负左；

库time：获取和处理时间信息
-用元组(年,月,日,时,分,秒,星期,儒略日,夏令时)表示时间，其中星期中0为星期一，儒略日为今天是今年的第几天；夏令时是0/1/-1；函数asctime(a)将时间元组变字符串；mktime(a)将时间元组变成总秒数；localtime(b)把总秒数变成日期元组；sleep(x)休眠x秒；strptime(a,f)把字符串变时间元组，f可选，为设置格式；time()返回当前时间(总秒数的形式)

库random：伪随机数
-random()返回一个0~1随机数；getrandbits(n)长整数方式返回n个随机二进制位(看到的已转十进制)；uniform(a,b)返回a~b的随机数；randrange(start,stop,step)随机选择一个数；choice(seq)序列seq中随机选一个；shuffle(seq)打乱序列seq；sample(seq,n)序列seq中随机选n个不同元素；

库shelve和json：【这个没懂】
-模块shelve中，函数open(文件名有引号)打开文件，返回一个Shelf对象，用来存储数据，也是字典但键须为字符串。如果不在open中将参数writeback设置为True，则一个元素被赋值后会存储而修改后不会，这时候需要一个中间变量来保存修改后的值再赋值给这个元素；如果为True则会先保存再缓存中等close了再一次性存储。

库re：
正则表达式：
通配符：小数点“.”能匹配单个任意字符，换行符除外。
转义特殊字符：目标中有特殊字符(. * ? ] 空格等)时，需表示为多一个反斜杠'a\.b'，但实际需要输入'a\\.b'因为第一个\用来解释器转义第二个\，把'\.'传递给模块re；或用原始字符串r'a\.b'。
字符集：在方括号中挑一个匹配[abc]表示匹配a b c中的一个。若表示排除abc在[]中用脱字符开头，即[^abc]，还可以用[a-zA-Z0-9]这样范围的形式。在字符集中特殊字符可以转义也可以不转义，但不能引起误解，比如找^时不能放在首位
二选一和子模式：abc(qwe|zxc)匹配abcqwe或qbczxc
可选模式和重复模式：在()后，放?表示()里可0/1次、放*可0/1/多次、放+可1/多次、放{m,n}可m~n次。
字符串开头和结尾：用脱字符开头'^abc'匹配abc开头的；用$结尾匹配abc结尾的

re的函数：
compile(式)：将正则表达式的字符串转换为模式对象，以提高匹配效率
search(式,string)：在字符串string中查找正则式
match(式,string)：在字符串开头匹配正则式
split(式,string)：根据正则式来分割字符串，若式含()则将()中内容插入分割处
findall(式,string)：返回1个列表，包含字符串中与正则式匹配的子串
sub(式,xxx,string)：把字符串中匹配的都替换为xxx
escape(string)：对字符串中所有正则表达式的特殊字符进行转义

匹配对象：上述查找和匹配函数在找到时返回的东西（MatchObject对象），具体的结果需要用匹配对象的方法来得到。
编组：匹配对象中包含的信息，表示哪些部分匹配，用0,1,2...99，看(的顺序
re的方法：下面x可选，不填默认为0
group(x)：返回与第x编组匹配的子串
start(x)：返回与第x编组匹配的子串的起始位置
end(x)：返回与第x编组匹配的子串的终止位置(实际序号+1)
span(x)：返回与第x编组匹配的子串的起始和终止位置

替换中的组号和函数：
用于re.sub(正则式,替换成啥,被替换者)，在"替换成啥"中类似\\x(或r'\x')的转义序列会被替换成匹配到的结果的第x组。文中例子的正则式是r'\*([^\*]+)\*'，被搜索的到是'*asd*'，所以\1表示的组1就是asd字符串，它将被代入“替换成啥”中去。
贪婪和非贪婪模式：重复运算符(+,*,?等)默认是贪婪的，如上面的正则在*a*b*c*中，将匹配从第1个到第4个*；破解方式：在重复运算符后面再加一个?，即成+?这样就是非贪婪的了，即匹配到2个，一个是*a*，另一个是*c*。

模板系统：没看懂


【第11章】文件
f=open(文件名,mode=参数)，mode取值：r只读(默认)、w在不seek时在文末写入(已存在文件直接删除再新建)、x独占写入(已存在时报异常)、a附加(续写)、b二进制模式、t文本模式(默认)、+读写模式
f.write(x)写入x并返回字符数、f.read(x)读x个字符(不指定就是余下全部)、f.close()关闭文件、f.tell()返回当前位置
f.seek(x,y)：x是偏移量，y可选是参考位置(不给是文头，io.SEEK_CUR(0)是当前，io.SEEK_CUR(1)是文尾)
整行读写：
f.readline(x)不给x时读整行(然后光标到下一行开头)，给x时读当前行光标位置始的x个字符；
f.readlines()从当前位置开始全读，返回一个列表，每行一个元素；
f.writelines(x)给一个序列或可迭代对象x，全写进去(换行符要自己加)
f.writeline()没有这个
with语句：结束语句体时自动关闭文件(不用手动f.close()了)
with open('D:\q.txt') as f:	把文件赋值给f(同上)
	do_something(f)	所有操作放在语句体中
with允许使用上下文管理器，支持两个方法：__enter__和__exit__
__enter__不接受参数，进入with时被调用，返回值赋值给as后面的f；
__exit__(异常类型,异常对象,异常跟踪)离开方法时调用，如果__exit__返回False，将抑制所有异常，也会关闭文件。
文件迭代器：
1.上面的f是可迭代的，用for line in f:操作，或用list(open(filename))；
2.用sys.stdin进行迭代，同上

先测试后编写代码：为了测试代码是否管用而不是找BUG

画图：
模块reportlab
from reportlab.lib import colors
from reportlab.graphics.shapes import *
from reportlab.graphics import renderPDF
from reportlab.graphics.charts.lineplots import LinePlot
from reportlab.graphics.charts.textlabels import Label
画布drawing=Drawing(width,height)
方式一：
drawing.add(PolyLine(每个项是一对坐标的列表))
drawing.add(String(X,Y,'内容',风格等)
方式二：
lp=LinePlot()
设定lp的x,y,height,width,data五个参数
lp.data是一个列表，每个项是一条折线，每个折线用以坐标对为项的列表描述。
drawing.add(lp)
导出到pdf：renderPDF.drawToFile(drawing,'文件名',图的标题)
