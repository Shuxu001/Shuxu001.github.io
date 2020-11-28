import pandas as pd
import numpy as np
读txt：
pd.read_csv(fpath,sep='\t',header=None,names=['a','b','c'])
sep是文件中的分隔，header是文件的标题行，names是指定列名

读excel：
pd.read_excel(fpath,skiprows=n) # skiprows可以跳过前n行

pandas数据结构：
DataFrame是一个二维表格,df.columns是列名,df.index是行名
Series是一个一维的行或列，类似字典
s1 = pd.Series([1,'a',5.2,7],index=['q','w','e','r']) # 用一个列表来创建Series
s1.index # 获取索引，上面index不指定时自动创建0 1 2 3的索引
s1.values # 获取数据，结果包括dtype属性
s2 = pd.Series(datadict) # 用字典创建，自动对应
获取特定一个值时，跟字典一样s2['q']
获取多个值时，s2[['q','w']]方括号里列表，得到结果Series类型

DataFrame可以看作由Series组成的字典
DataFrame用可以字典创建，键是列名，值是一个序列变成列
方法：df.dtypes;df.index;df.columns
从DataFrame中查询出Series：
查列：df['列名']得到Series；df[['列名1','列名2']]得到小DataFrame
查行：df.loc[1]根据行标签得到Series，多行df.loc[1:3]，得到小DataFrame，这里是1~3行，不是1~2行
查行：df.iloc[1]根据行数字位置得到Series，多行df.iloc[1:3]是第1~2行
查询数据高级方法：df.where,df,query，主要是df.loc可读可写
df.head(几) # 展示前几行数据
df.index    # 获取index
df.set_index('列名',inplace=True)　# 把特定列变成index
df.loc[a,b]  # 获取df的行a列b的数据，ab可以用列表[]来多选
可以用条件表达式来进行查询：
df.loc[df['yWendu']<-10, :] 
前是对行进行筛选，筛选时需要对某列进行条件判断，后面冒号表示这些行的所运作列都要
也可以多条件：df.loc[(列1判断)&(列2判断)&(列3判断), :]
还可以调用函数查询：
1. lambda表达式df.loc[lambda df : 对df的条件判断, :]
2. 传入函数名df.loc[不带()的函数名func, :]，其中def func(df): return 条件表达式，也就是返回一个True/False序列
注：lambda的用法：lambda x : f(x)

增加数据列：
1. 直接赋值：
df.loc[:,'新增列名']=新值
2. df.apply()方法：把一个函数应用于某个Series，参数axis=1时用于columns，axis=0时用于index
用法：某一新Series(columns/index) = df.apply(不带括号的函数名func,axis=1/0)，函数func是对数据进行处理的
3. df.assign()方法，可以同时添加多个列，不能行
用法：df.assign(新列名1=值/lambda式，新列名2=...)
4. 按条件选择分组分别赋值
先创建一个空列：df['新列名']=''
再对它取值：df.loc[判断,'新列名']='值1'，......

pandas统计数据
1. 汇总类
df.describe() # 包括行计数、均值、标准差、最大/小值等
可以单个列：df['列名'].mean()/max()/min()
2. 唯一去重和按值计数
df['列名'].unique() # 得到一共由哪些取值构成
df['列名'].value_counts() # 对数据按值计数
3. 相关系数和协方差
df.cov() # 协方差矩阵，结果是对称阵，变量之前的协方差
df.corr() # 相关系数矩阵，同上
Series1.corr(Series2) # 计算二者的相关系数/协方差

pandas对缺失值的处理
df.isnull() # 检测空值，返回一个等行等列DataFrame，值为True/False
df.notnull() # 同上，不过True代表非空值，这两个都可用于Series
df.dropna(axis,how,inplace) # 丢弃、删除缺失值N/A
-axis：默认为0；为0/'index'则对行进行操作，为1/'columns'则对列。
-how：默认'any'则有空就删，为'all'则全空才删
-inplace：默认False则返回一个新df，为True则修改当前df
df.fillna(value,method,axis,inplace)
-value：填充值，可以是单个值直接填充整个df，也可是一个字典按列填充{'列名1':'填充值1','列名2':'填充值2'}
-method：为'ffill'则用前一个值填充当前缺失值，为'bfill'则用后一个
-axis和inplace：和前面一样
保存excel：
df.to_excel('文件路径',index=False) # False表示不保存行标列0123

pandas的SettingWithCopyWarning报警
pandas不允许先筛选子表再修改写入，应该：
1. 用df.loc实现直接修改源df
2. 先.copy()一个子表再修改子表

pandas数据排序
排Series：
Series.sort_values(ascending,inplace)
-ascending：默认为True升序，False降序
-inplace：为True修改，为False新建
排DataFrame：
DataFrame.sort_values(by,ascending,inplace)
-by：='列名'或列名组成的列表(前位的优先)
-ascending/inplace：同上，by为列表时ascending列表对应
注：去重df/s.drop_duplicates()

pandas字符串处理
1. 先获取Series的str属性，再在属性上调用方法
2. 只能在字符串列上使用，一般是df.dtypes为object的数据
3. DataFrame上没有str属性和处理方法
4. Series.str不是python的原生字符串，是pandas自己的一套方法
 
部分Series.str的方法：
.replace('被替换的','替换成的')，前者默认开启正则模式
.isnumeric() 判断是不是数字
.len() 长度
.slice(m,n) 切片，相当于str[0:6]
.startswith('xx') 是不是xx开头，得到bool值的Series
.contains('xx') 同上，都可以用于条件查询df[condition]子df
.astype('int32') 改变类型
...很多

pandas的axis参数
-0：单行操作时就是某一行，聚合操作时，指跨行，实际是每列一次操作
-1：单列操作时就是某一列，聚合操作时，指跨列，实际是每行一次操作
单行单列：df.drop('行/列名',axis=0/1)
df.mean(axis=0)：指跨行取均值(对每个columns均值)，不是每行取均值，保留columns标识

pandas索引index用途
1. 更方便的数据查询：把要用于添加筛选的放到索引位置
df.set_index('列1',inplace,drop=False) drop=False表示列1变成索引之后在数据中仍然保留
df.loc['被筛选的值/范围']
2. 查询性能提升
index唯一O(1)，不唯一但有序O(log(N))，不唯一又无序O(N)
df.sort_index() 按index排序，增序
df.index.is_monotonic_increasing    检查是否递增
3. 数据自动对齐
Series1+Series2这种操作时，会寻找index一样的行，然后执行+
4. 更多数据结构支持：后面

pandas实现DataFrame的Merge
pd.merge(left,right,how,on,left_on,right_on,left_index，right_index,sort,suffixes,copy,indicator,validate)
left,right：被merge的表，为dataframe/有name的series
how：'left/right/inner/outer'，保留key列的值在'左/右/交/并'集里的项
on,left_on,right_on：指定key，on是一起指定，后两个是分别指定(列名不一样而内容一样的时候)
left_index，right_index：取True/False，为True表示不用columns作key而直接用index列
suffixes('_x','_y')：左右表的非key列重名(比如都有列A)，会得到两列A_x,A_y

pandas实现vlookup
1. 直接用pd.merge(left,right,how,on...)合并
2. 调成列的顺序：df.reindex(columns=new_columns_list)提供新顺序


pandas数据合并连接concat
1. pd.concat(objs,axis,join,ignore_index)
objs：一个列表，项是要合并的dataframe/有name的series，顺序无所谓
axis：默认0，跨行连接(连接到行尾)；为1跨列连接(连接到列尾)
join：默认outer，全保留；为inner保留交集(跨行连接则保留都有的列名)
ignore_index：默认False，为True忽略原来的索引index
2. df.append(other,ignore_index)
一般用于一行一行添加到行尾，每次都复制一次，性能不如concat但比较简单

pandas拆分和合并excel
拆分：
可以用iloc按行的序号拆，再dfi.to_excel(file_name,index=False)
合并：
读文件夹：os.listdir('文件夹路径')可以得到所有文件名；读excel：pd.read_excel

pandas分组数据统计
df.groupby('A'),根据A列进行分组，
-结果不可见但可以遍历两个属性：name(原A列的值)和group(分出来的小df)，可用ans.get_group(name)来得到某小df
df.groupby(['A','B'],as_index)，根据AB两列分组，as_index默认True多级索引，为False时不作为索引
-此时分组的name是一个元组('Ai','Bi')，分布式AB两列的值组成的对，此时用ans.get_group(('Ai','Bi'))得小df
df.groupby('A').sum() 单个统计函数的操作
df.groupby('A').agg([np.sum,np.mean,np.std]) 多个操作
df.groupby('A').agg({'C':np.sum,'D':np.mean}) 不同列不同操作
用Series/DataFrame画图：df.plot()，只能是数值不能字符串

pandas分层索引
实现更高维度、更高效筛选
1. 多层索引的Series
s.unstack()：二层索引的Series转变为DataFrame，二级索引变成了列
s.reset_index()：两层索引都变成了列
查询：s.loc[('Ai','Bi')]，筛一级直接s.loc['Ai']，筛二级用s.loc[:,'Bi']此处不要()
注：s.loc['Ai']和s.loc['Ai',:]得到的结果不同，前者得到的只有1级索引，后者仍然2级
-关于()和[]：元组是多层索引；列表是多key并列筛选(行均可)，二者可嵌套
2. 多层索引的DataFrame(比上面的多了列)
语法：df.loc[(一级,二级),列] 得到的结果还是两级索引
df.loc[(slice(None),['二索1','二索2']),:] 一索全要(不能用:)
注：当出现多个逗号的时候注意有时候":"不能省，下面假设AB是两个索引,CD是两个列
例：d.loc[(['A1','A2'],['B1','B2']),:] 如果把“,:”去掉，会把['B1','B2']当成列，就报错了
总结：用()元组索引时，要总是带上列的选择； 只有只用一级索引和Series场合可以简化

# 用到()时，得到的df不会变成s，保留‘只有一个项的索引’
d.loc['a1',:] # =d.loc['a1']  取单a全部，索引a丢弃
d.loc[('a1',slice(None)),:] # 取单a全部，索引a保留
d.loc[['a1','a2']]          # 取多a全部，索引总保留
d.loc[['a1','a2'],:]        # 同上

#  用()别省列：取ab同单/单列为series，三个都取为value
d.loc[('a1','b1'),'c']               # 单a单b单列 value
d.loc[('a1','b1'), : ]               # 单a单b多列 s2idx
d.loc[('a1',['b1','b2']),'c']        # 单a多b单列 s2idx 
d.loc[('a1',['b1','b2']), : ]        # 单a多b多列 d2idx
d.loc[(['a1','a2'],'b1'),'c']        # 多a单b单列 s2idx
d.loc[(['a1','a2'],'b1'), : ]        # 多a单b多列 d2idx
d.loc[(['a1','a2'],['b1','b2']),'c'] # 多a多b单列 s2idx
d.loc[(['a1','a2'],['b1','b2']), : ] # 多a多b多列 d2idx

d.loc[(['a1','a2'],'b1')]   # 这里b1被视为列名了，报错

pandas数据转换函数map,apply,applymap
1. map：只能用于Series
s.map(dict) dict里包含了转换前后的映射关系
s.map(func) func可以是lambda x:f(x)，func的参数是值
2. apply：用于Series，DataFrame
s.apply(func) 用于Series，和map一样，func的参数是值
df.apply(func) 用于DataFrame，func的参数是Series，会自动对每个值应用函数
3. applymap：用于DataFrame所有值的转换
df.applymap(func) func的参数是值，把df所有值都应用函数

pandas对“每个分组”应用apply函数
知识：pandas的GroupBy遵从split、apply、combine模式
即groupby分组就是这个split，然后自动对各个组apply，再自动combine
df.groupby('列名').apply(func)  相比上面多了.groupby('列名')
func的第一个参数是DataFrame类，返回结果可以是任意，一般是df
func的第二个参数aggr传入方式：.apply(func,aggr)


pandas数据透视(三列变二维交叉)stack和pivot
df.stack(level=-1,dropna=True)：把二维交叉变两层索引,-1表示列变成最内层索引
s.unstack(level=-1,fill_value=None)：跟上面相反，一般是用于已groupby之后的对象
df.pivot(index,columns,values)：指定透视后的3个参数对一个未groupby的df进行透视

pandas日期处理
日期字符串->pd.to_datetime->Timestamp对象
日期字符串列表->pd.to_datetime->DatetimeIndex对象(是上者的列表)
pd.to_datetime('data_series') 把一个日期列变成DatetimeIndex格式
此类型的显示方式：'2020-08-23'，(不是字符串)
更好的查询：df.loc['2020-01':'2020-07'] 可以只有年(月)，自动挑所有的(月)日
DatetimeIndex.week 提取周数(今天是今年的第几周)，周1是第一天
还有month月数、quarter季度数、dayofweek、days_in_month、weekday_name、
hour、minute、second、is_month/quarter/year_start/end等等
上面这些一般用于结合groupby分组来筛选，然后处理(取max,mean之类的)

pandas处理日期索引缺失
1. df.reindex(new_index_list,fill_value=0)重建索引，需要两个索引类型一样
把字符串日期pd.to_datetime后，再df.reindex，新索引是pd.date_range(start,end)
2. pd.resample(arg).aggr() 可以是日->月变大(一个采样点多个数据)，也可以时->分变小(一个数据被采样多次) 
arg参数是'D','M','H'等，aggr()是聚合函数即怎么处理采样到的值，比如sum()
完成日期索引后，比如df.resample('D').mean().fillna(0)，
-表示重新按天采样后，每个采样点的数据们里取平均，没有采样到的用0填充

pandas画图
from pyecharts.charts import Line,Bar,Pie
from pyecharts import options as opts
line=Line()
line.add_xaxis(x_list)可以用Series.to_list()得到
line.add_yaxis('线名1',y1_list)，同上
line.add_yaxis('线名2',y2_list)，同上
line.set_global_opts(
    title_opts=opts.TitleOpts(title='图名')
    tooltip_opts=opts.TooltipOpts(trigger='axis',axis_pointer_type='cross')
    ) # 第2行是两个实用的功能，可以一直加上


pandas机器学习，只限数值形式的数据
1. 输入：表示模型的df和表示结果的s
2. 训练：
from sklearn.linear_model import LogisticRegression
logreg = LogisticRegression()
logreg.fit(df,s)
3. 预测：eee为包含模型数据的df或list
logreg.predict_probe(eee) 返回list->[p_no,p_yes],df->([],[],[])
logreg.predict(eee) 返回哪个可能性大





