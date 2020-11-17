import pandas as pd
import numpy as np
from pyecharts.charts import Line,Bar,Pie,Map,Page
from pyecharts import options as opts

filepath='nbtq2019.xlsx'
df = pd.read_excel(filepath)
df.columns = ['date','tmax','tmin','tq','fg']
# 处理文本
df['date'] = pd.to_datetime(df['date'].str.slice(0,10))
df['tq'] = df['tq'].str.replace('阴天','阴')
df['fg'] = df['fg'].str.replace('微风','0级')
df['fx'] = df['fg'].str.slice(0,-2)                     # 风向
df['fl'] = df['fg'].str.slice(-2,-1).astype('int32')    # 风力
df.drop('fg',axis=1,inplace=True)
df['tmax'] = df['tmax'].str.replace('℃','').astype('int32')
df['tmin'] = df['tmin'].str.replace('℃','').astype('int32')
df.set_index('date',inplace=True)

def series2list(s):
    l=[]
    for name in s.index:
        l.append((str(name),int(s[name])))
    return l


# 温度
s_tmax_week = df.groupby(df.index.week)['tmax'].max().round(1)    # 每周最高温
s_tmin_week = df.groupby(df.index.week)['tmin'].min().round(1)    # 每周最低温
df['tdlt']=df['tmax']-df['tmin']    # 每天温差
s_tdlt_week = df.groupby(df.index.week)['tdlt'].mean().round(1) 
x_date = list('第{}周'.format(i) for i in range(1,53))

line = (
    Line(init_opts=opts.InitOpts(width="1300px",height="600px"))
    .add_xaxis(x_date)
    .add_yaxis('温差',s_tdlt_week.tolist())
    .add_yaxis('最高温',s_tmax_week.tolist())
    .add_yaxis('最低温',s_tmin_week.tolist())
    .set_series_opts(label_opts=opts.LabelOpts(is_show=False))
    .set_global_opts(
        title_opts=opts.TitleOpts(title='温度变化'),
        tooltip_opts=opts.TooltipOpts(trigger='axis',axis_pointer_type='cross'),
        xaxis_opts=opts.AxisOpts(axislabel_opts=opts.LabelOpts(rotate=45))
    ) 
)


# 天气、风向、风力统计
s_tq = df['tq'].value_counts()
s_fx = df['fx'].value_counts()
s_fl = df['fl'].value_counts().sort_index()
s_tq = s_tq.reindex(['晴','多云','阴','小雨','小到中雨','中雨','大雨','暴雨','大暴雨','雾'])
x_tq = s_tq.index.tolist()
y_tq = s_tq.values.tolist()
x_fx = series2list(s_fx)
x_fl = series2list(s_fl)

bar = (
    Bar(init_opts=opts.InitOpts(width="1000px",height="570px"))
    .add_xaxis(x_tq)
    .add_yaxis('天气:天数',y_tq)
    .set_series_opts(
        label_opts=opts.LabelOpts(formatter='{b}:{c}天') 
    )
    .set_global_opts(
        title_opts=opts.TitleOpts(title='天气统计',pos_left='left')
    )
)


pie1 = (
    Pie(init_opts=opts.InitOpts(width="1000px",height="570px"))
    .add('风向:天数',x_fx,radius=['30%','70%'])
    .set_series_opts(
        label_opts=opts.LabelOpts(formatter='{b}:{c}天') 
    )
    .set_global_opts(
        title_opts=opts.TitleOpts(title='风向统计',pos_left='left')
    )
)

for i in x_fl.copy():
    if i[0] == '0':
        x_fl[x_fl.index(i)]=('微风',i[1])
    else:
        x_fl[x_fl.index(i)]=(i[0]+'级',i[1])

pie2 = (
    Pie(init_opts=opts.InitOpts(width="1000px",height="570px"))
    .add('风力:百分比',x_fl,radius=['30%','70%'])
    .set_series_opts(
        label_opts=opts.LabelOpts(formatter='{b}:{d}%') 
    )
    .set_global_opts(
        title_opts=opts.TitleOpts(title='风力统计',pos_left='left')
    )
)


x_map = [
    ('',1),
    
]
map = (
    Map(init_opts=opts.InitOpts(width="1000px",height="570px"))
    .add('宁波',x_map,'宁波')
    .add('舟山',x_map,'舟山')
    .set_global_opts(
        title_opts=opts.TitleOpts(title='地图',pos_left='left')
    )
)
map.render_notebook()


page=Page()
page.add(line,bar,pie1,pie2)
page.render('nbtq2019.html')
