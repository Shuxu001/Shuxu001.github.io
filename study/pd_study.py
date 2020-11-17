import pandas as pd
import numpy as np

# pandas数据结构：DataFrame和Series
# DataFrame可pd.DataFrame(dict)得到(值为列表)，Series可pd.Series(list)得到
# DataFrame属性:index,columns,dtypes,values
# Series属性:index,name,dtypes,values
df = pd.DataFrame({'a':['a1','a1','a1','a2','a2','a2','a3','a3','a3'],
    'b':['b1','b2','b3','b1','b2','b3','b1','b2','b3'],
    'c':[1,2,3,4,5,6,7,8,9],
    'd':[2,3,4,5,6,7,8,9,0]
    })
d=df.groupby(['a','b']).mean()
s=d['c']
# 在df中查询:df['列'],df.loc['行'],df.iloc[1]
df.loc['index','columns'] 
# 条件查询
df.loc[df['c']<5,:]  # 多条件:df.loc[(列1?)&(列2?),:]
df.loc[lambda df:df['c']<5 ,:]  # lambda x:f(x)
df.loc[func,:] # def func(df): return df['c']<5
# 增加列
df['新列名']=data_list_or_Series # 或df.loc[:,'新列名']=...
df.assign(新列名=data_list_or_Series) # 此处不要引号
df.loc[对某列值判断,'新列名']='值'    # 按条件赋值
# df['c']==0，此会输出Series，值True/False，用于筛选行

## DataFrame的一些方法：
df.set_index(list,inplace=False) # 设定index
df.reindex(list)    # 按list里的顺序重排整个df,新项用NaN,缺项丢掉
df.set_columns(list,inplace=False)
df.describe()   # 汇总属性：计数、均值、标准差、最值等等
df['c'].max()   # 得到单列的属性
df['c'].unique()    # 这列一共由哪些值组成
df['c'].value_counts() # 按值计数
df.cov()    # 协方差阵
df.corr()   # 相关系数阵
s1.corr(s2) # 计算相关系数，协方差同理
df.isnull() # 检测空值，等行等列布尔值阵，
df.notnull() # 非空为True，同上
# 关于参数axis=0：单行操作即某行;聚合操作则跨行，实际是每列一次操作
df.drop('行/列名',axis=0) # 默认行名,指定axis=1时列名
df.mean(axis=0) # 跨行取均值(取每列均值)，保留columns标识
df.dropna(axis=0,how='any',inplace=False) # 1,'all',True，下同
df.fillna(value,method,axis,inplace) # method='ffill/bfill'用前/后值填充
df.to_excel(filepath,index=False) # True保存index:0,1,2,3...
s.sort_values(ascending=True,inplace=False) # 升序，新建
df.sort_values(by,ascending=True,inplace=False) # by='列名'或['列1','列2']
s.drop_duplicates() # 删掉重复的行，df.drop_duplicates()没搞懂?
df.sort_index() # 按index升序排序
df.index.is_monotonic_increasing    # 检查index是否升序
# 关于index:如s1+s2操作时，会寻找index一样的行，然后执行+

# 字符串的处理和方法：
# 只能获取(数据类型为object的)Series的str属性，再调用方法
# 不能DataFrame,不能直接对字符串调用方法,Series.str非python原生字符串
s.str.replace('a','b') # 把'a'替换成'b'，默认开启正则功能
s.str.isnumeric() # 判断是否为数字
s.str.len() # 长度
s.str.slice(m,n) # 切片，相当于str[m:n]
s.str.startswith('x') # 判断是不是x开头，得到bool值的Series
s.str.contains('x') # 同上
s.str.astype('int32') # 改变类型


####    多层索引 总结   ####  
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

####################################################################
####    EXCEL   ####    EXCEL   ####    EXCEL   ####    EXCEL   ####
####################################################################
filepath = '' # 路径字符串
# 读txt：header是标题行(列名行)，names指定列名
df = pd.read_csv(filepath,sep='\t',header=False,names=['a','b'])
# 写txt：header是标题行(列名行)，index是行标
df.to_csv(filepath,sep='\t',header=False,index=False)
# 读excel：skiprows=3可以跳过3行
df = pd.read_excel(filepath,skiprows=3)
# 写excel:
df.to_excel(file_name,index=False,header=False)
# 拆分excel:用iloc按行的序号拆，再df_i.to_excel(file_name,index=False)
# 合并excel:用os.listdir('文件夹路径')可以得到所有文件名,读->连接->写

# merge函数，可以实现合并、vlookup等，比如增加每个人的信息
# 实现了根据相同列(如学号)，把数据从两个表合并成一个表的功能
pd.merge(left,right,how,on,left_on,right_on,left_index，right_index,sort,suffixes)
# left,right：被merge的表，为dataframe或者(有name的)series
# how：'left/right/inner/outer'，保留key列的值在'左表/右表/交集/并集'里的项
# on,left_on,right_on：指定key，on一起指定，后二者用于分别指定(列名异而内容同)
# left_index，right_index：默认False，为True表示不用columns而直接用index作key
# suffixes('_x','_y')：左右表的非key列重名(比如都有列A)，会得到两列A_x,A_y

# append和concat函数，可以实现连接，比如增加新的人员
pd.append(other,ignore_index) # 用于逐行添加，性能不ok
pd.concat(objs,axis,join,ignore_index)
# objs：一个列表，含被准备连接的dataframe或(有name的)series，顺序无所谓
# axis：默认0,跨行连接(连接到行尾,同列名的列上下接一起，不同的错开);取1则跨列
# join：默认outer全保留;取inner保留交集(跨行连接则保留共有列名)
# ignore_index：默认False，为True忽略原来的索引index，重新0,1,2,3...
# 当axis=1,两个输入index相同时，可以实现跟merge类似的功能



# DataFrame.groupby()方法，实现分组，见pd_groupby.py
df.groupby('A') # 结果2个属性:ans.name,ans.get_group(name)
df.groupby(['A','B']) # 此时name是元组('ai','bi')
df.groupby.sum() # 单个聚合函数
df.groupby.agg([np.sum,np.mean]) # 多个聚合函数
df.groupby.agg({'c':np.sum,'d':np.mean}] # 不同列不同聚合函数

# map,apply,applymap方法，实现数据转换
# 1. map：只能用于Series
s.map(dict) # dict里包含了转换前后的映射关系
s.map(func) # func的参数是s的values,也可以是lambda x:f(x)
# 2. apply：用于Series，DataFrame
s.apply(func) # 用于Series，和map一样，func的参数是s的values
df.apply(func) # 用于DataFrame，func的参数是Series，会自动对每个value应用函数
# 3. applymap：用于DataFrame所有值的转换
df.applymap(func) # func的参数是df的values，把df所有值都应用函数
# pandas对“每个分组”apply函数；pandas遵从split、apply、combine模式
# groupby分组实现split、pandas自动对各组apply、再自动combine
df.groupby('a').apply(func) # func的第一个参数总是DataFrame，输出随意
df.groupby('a').apply(func,aggr) # func的其它参数放aggr

# stack和pivot方法,实现数据透视(三列变二维交叉)
df.stack(level=-1,dropna=True) # 把二维交叉变两层索引,-1表示列变成最内层索引
s.unstack(level=-1,fill_value=None) # 跟上面相反，一般是用于已groupby之后的对象
df.pivot(index,columns,values) # 指定透视后的3个参数对一个未groupby的df进行透视






