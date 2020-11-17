###### date #########
import pandas as pd
# 关于日期处理的部分
# 日期字符串->pd.to_datetime->Timestamp对象,看起来一样实际不一样
pd.to_datetime('2020-08-08')

# 日期字符串列表->pd.to_datetime->DatetimeIndex对象(是上者的列表)
date_list = ['2020-08-01','2020-08-02','2020-08-03','2020-08-04',
            '2020-08-05','2020-08-06','2020-08-07','2020-08-08',
            '2020-08-09','2020-08-10','2020-08-11','2020-08-12',
            ]
pd.to_datetime(date_list)

# pd.to_datetime('data_series') 把一个日期列变成DatetimeIndex格式
s_date = pd.Series(date_list,name='dt')
pd.to_datetime(s_date) 

# 更好的查询功能：df.loc['2020-01':'2020-07'] 可以只有年(月)，自动挑所有的(月)日
df = pd.DataFrame({'dt':pd.to_datetime(date_list),'vl':range(12)})
df.set_index('dt',inplace=True)
df.loc['2020-08']   # 挑出所有8月
df.loc['2020-08-02':'2020-08-09']

# DatetimeIndex.xxx 提取xxx属性
df.index.microsecond
# week今年第几周、month、quarter季度数、dayofweek、days_in_month
# hour/minute/second/microsecond/nanosecond  此刻的时/分/秒/微秒
# is_month/quarter/year_start/end  判断用
# 上面这些一般用于结合groupby分组来筛选，然后处理(取max,mean之类的)

# pandas处理日期索引缺失
# 1. df.reindex(new_index_list,fill_value=0)重建索引，需要两个索引类型一样
# 把字符串日期pd.to_datetime后，再df.reindex，新索引是pd.date_range(start,end)
# 2. pd.resample(arg).aggr() 可以是日->月变大(一个采样点多个数据)，也可以时->分变小(一个数据被采样多次) 
# arg参数是'D','M','H'等，aggr()是聚合函数即怎么处理采样到的值，比如sum()
# 完成日期索引后，比如df.resample('D').mean().fillna(0)，
# -表示重新按天采样后，每个采样点的数据们里取平均，没有采样到的用0填充




###### group #########
import pandas as pd
import numpy as np
%matplotlib inline
# groupby,unstack,stack,pivot,map,apply,applymap

# 数据分组和聚合
df = pd.DataFrame({
    'a':['a1','a1','a1','a1','a2','a2','a2','a2'],
    'b':['b1','b2','b1','b2','b1','b2','b1','b2'],
    'c':[1,2,3,4,5,6,7,8],
    'd':[2,3,4,5,6,7,8,9]
    })
# 按a,b列分组，每组的数据们用mean()聚合成一个数据
# a,b是两层index
d1 = df.groupby(['a','b']).mean()  
# a,b是两个columns
d2 = df.groupby(['a','b'],as_index=False).mean() 
# 对每个列用多个聚合操作 
d3 = df.groupby(['a','b']).agg([np.sum,np.mean]) 
# 对不同列用不用聚合操作
d4 = df.groupby(['a','b']).agg({'c':np.sum,'d':np.mean})

# 分组后透视
df = pd.DataFrame({'a':['a1','a1','a1','a2','a2','a2','a3','a3','a3'],
    'b':['b1','b2','b3','b1','b2','b3','b1','b2','b3'],
    'c':[1,2,3,4,5,6,7,8,9],
    'd':[2,3,4,5,6,7,8,9,0]
    })
s = df.groupby(['a','b']).mean()['c'] # 只能由一列数据来透视
d5 = s.unstack(level=-1)  # -1表示内层index作为后来的columns
# unstack->fill_value=None 指定原空值透视后的值
ss = d5.stack(level=-1)   # 反透视
# stack->dropna=True 指定丢空值，然后那行就没有了
df.pivot('a','b','c') # df.pivot(index,columns,values)
# pivot相当于先groupby,再unstack

# 分组和数据转换
# 1.map：只能用于Series
s = pd.Series([0,2,'a',True])
dict = {0:False,2:'b','a':'A',True:1}
s1 = s.map(dict)    # 字典映射
s = pd.Series([1,2,3,4])
s2 = s.map(lambda x: 2*x)   # func的参数是s的values
# 2.apply：用于Series和DataFrame
s3 = s.apply(lambda x: 2*x) # 和map一样
d6 = df.apply(lambda x: 2*x) # func参数是values或Series?
# 3.applymap：用于DataFrame，对每个值处理一次
d7 = df[['c','d']].applymap(lambda x: (1 if x<5 else 0))



###### loc #########
import pandas as pd
df = pd.DataFrame({'a':['a1','a1','a1','a2','a2','a2','a3','a3','a3'],
    'b':['b1','b2','b3','b1','b2','b3','b1','b2','b3'],
    'c':[1,2,3,4,5,6,7,8,9],
    'd':[2,3,4,5,6,7,8,9,0]
    })
d=df.groupby(['a','b']).mean()
s=d['c']


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

###### sklenrn #########
from sklearn.linear_model import LogisticRegression
import pandas as pd

a = LogisticRegression()
x = pd.DataFrame(
    {'can_x':[1,2,3,4,5,6,7,8,9,10],
    'can_y':[10,9,8,7,6,5,4,3,2,1]}
)
y = pd.Series([0,1,0,1,0,1,1,0,1,1],name='result')

a.fit(x,y)
e = pd.DataFrame(
    {'can_x':[1,2,3,4],
    'can_y':[3,5,6,7]}
)

a.predict_proba(e)
# a.predict(e)

