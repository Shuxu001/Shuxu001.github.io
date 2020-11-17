import random
from pyecharts import options as opts
from pyecharts.charts import *
from pyecharts.globals import ThemeType

x_list = ['a','b','c','d','e']
y_list1 = list(i*2+200 for i in range(5))
y_list2 = list(i*5+200 for i in range(5))
line=(
    Line(init_opts=opts.InitOpts(theme='dark',width="600px",height="500px",bg_color='blue'))
    .add_xaxis(x_list)
    .add_yaxis('y1',y_list1)
    .add_yaxis('y2',y_list2)
    .set_series_opts(label_opts=opts.LabelOpts(is_show=False)) #隐藏点的值
    .set_global_opts(
        title_opts=opts.TitleOpts(
            title='Line_chart主标题',
            subtitle='Line_chart副标题',
            pos_left='20%',
            pos_top='middle',
            item_gap=50,
            title_textstyle_opts=opts.TextStyleOpts(color='red'),   # 还有很多
        ),
        legend_opts = opts.LegendOpts(
            is_show = True,
            type_='scroll',
            selected_mode='multiple',# 只能选中一个显示            
            pos_left='center',
            pos_top='top',
            item_gap=20,
            orient='vertical',  # 竖的排列
            legend_icon='diamond',
            inactive_color='red'
        ),
        tooltip_opts=opts.TooltipOpts(
            formatter='{a},{c}',
            axis_pointer_type='cross',
            trigger='axis',
        ),
        xaxis_opts = opts.AxisOpts(
            is_show=True,
            type_='category', #一般自动会选，不需要自己写
            is_inverse= False, 
            name = '字母',
            axislabel_opts=opts.LabelOpts(
                rotate=45,
                color='yellow',
                font_size=20,
            ),
            axisline_opts=opts.AxisLineOpts(
                symbol = 'arrow',
                linestyle_opts = opts.LineStyleOpts(
                   width=5,
                   color='yellow',
                ),
            ),
            axistick_opts=opts.AxisTickOpts(
                is_inside=False,
            ),
            splitline_opts=opts.SplitLineOpts(
                is_show=True
            ),
            splitarea_opts=opts.SplitAreaOpts(
                is_show=True,
                areastyle_opts=opts.AreaStyleOpts(
                    opacity=0.5,color='green'
                )
            )
            
        ),
        yaxis_opts = opts.AxisOpts(
            is_scale=True,
            splitline_opts=opts.SplitLineOpts(
                is_show=True
            ),
        ),
        datazoom_opts=opts.DataZoomOpts(
            orient='vertical',
            range_start=20,
            range_end=80
        )
    )
    .set_series_opts(
        markpoint_opts=opts.MarkPointOpts(
            data=[
                opts.MarkPointItem(coord=['a',209],name='坐标点',value='点1'),
                opts.MarkPointItem(x=200,y=100,name='像素点',value='点2')
            ]
        ),
        markline_opts=opts.MarkLineOpts(
            data=[
                opts.MarkLineItem(y=205),
                opts.MarkLineItem(x='c')
            ]
        ),
        markarea_opts=opts.MarkAreaOpts(
            data=[
                opts.MarkAreaItem(x=('d','e'),y=(210,212))
            ]
        )
    )
    
)
line.render_notebook()

'''
# x_list = list(range(5))
y_list3 = [23,28,26,25,27] # 对应x的数量
y_list4 = [12,5,2,6,1]
bar = (
    Bar()
    .add_xaxis(x_list)
    .add_yaxis('y3',y_list3,yaxis_index=1)  #双y轴加yaxis_index=1
    .add_yaxis('y4',y_list4,yaxis_index=1)
    .set_global_opts(
        title_opts=opts.TitleOpts(title='Bar_chart',pos_left='right')
    )
)
#bar.render_notebook()

# 双y轴
line.extend_axis(yaxis=opts.AxisOpts(is_scale=True))
line.overlap(bar)
line.render_notebook()


overlap = (
    Overlap()
    .add(bar)
    .add(line,yaxis_index=1,is_add_yaxis=True)
)
overlap.render_notebook()

x = [(1,10) # (值,取值数)
    ,(2,34)
    ,(3,20)
    ,(4,30)
    ,(5,6)
    ]
pie = (
    Pie(init_opts=opts.InitOpts(width="1000px",height="570px"))
    .add('x',x,radius=['30%','70%'])
    .set_series_opts(
        label_opts=opts.LabelOpts(formatter='{b}:{c}') 
    ) # {b}表示当前值,{c}表示当前取值数
    .set_global_opts(
        title_opts=opts.TitleOpts(title='Pie_chart',pos_left='')
    )
)
pie.render_notebook()

# 散点图
x = ['a','b','c']
y = [1,2,3]
scatter = (
    Scatter()
    .add_xaxis(x)
    .add_yaxis('y',y)
)
scatter.render_notebook()
# 带涟漪效果的散点图
effectscatter = (
    EffectScatter()
    .add_xaxis(x)
    .add_yaxis('y',y)
)
effectscatter.render_notebook()

# K线图
x = ['d1','d2']
y = [
    [2,3,1,4],
    [5,3,2,6]
] # 开盘，收盘，最低，最高
kline = (
    Kline()
    .add_xaxis(x)
    .add_yaxis('y',y)
)
kline.render_notebook()

# 热力图
data = [[i, j, random.randint(0, 100)] for i in range(5) for j in range(3)]
x = [str(i) for i in range(5)]
y = ['周日', '周一', '周二']
heat = (HeatMap()
        .add_xaxis(x)
        .add_yaxis("", y, data)
)
heat.render_notebook()


## 地图 ##
province = ['浙江','北京','湖北','广东']
data = [(i,random.randint(1,100)) for i in province]
geo = (
    Geo()
    .add_schema(maptype='china')
    .add('geo图',data)
)
geo.render_notebook()
# 上面这个没懂，反正用下面这个就好了
map = (
    Map()
    .add('map图',data,'china')
)
map.render_notebook()

## 其它图 ##
# 节点图
nodes = [
    {'name':'点1','symbolSize':1},
    {'name':'点2','symbolSize':2},
    {'name':'点3','symbolSize':3},
    {'name':'点4','symbolSize':4}
]
links = [
    {'source':'点1','target':'点2'},
    {'source':'点1','target':'点3'},
    {'source':'点1','target':'点4'},
    {'source':'点2','target':'点3'},
    {'source':'点3','target':'点4'}
]
graph = (
    Graph() 
    .add('',nodes,links)
)
graph.render_notebook()

# 雷达图
data_radar = [  
    tuple(random.randint(1,5) for i in range(6)),
    tuple(random.randint(1,5) for i in range(6)),
    tuple(random.randint(1,5) for i in range(6))
]
radar = (
    Radar()
    .add_schema(
        schema=[
            opts.RadarIndicatorItem(name='item1',max_=5),
            opts.RadarIndicatorItem(name='item2',max_=5),
            opts.RadarIndicatorItem(name='item3',max_=5),
            opts.RadarIndicatorItem(name='item4',max_=5),
            opts.RadarIndicatorItem(name='item5',max_=5),
            opts.RadarIndicatorItem(name='item6',max_=5)
        ]
    )
    .add('',data_radar)
)
radar.render_notebook()

# 词云图
words = [
    ('a',1),
    ('b',2),
    ('c',3)
]
wordcloud = (
    WordCloud()
    .add('WordCloud图',words)
)
wordcloud.render_notebook()

# 表格
from pyecharts.components import Table
headers = ['A','B','C']
rows = [
    ('A1','B1','C1'),
    ('A2','B2','C2'),
    ('A3','B3','C3')
]
table = (
    Table()
    .add(headers,rows)
)
table.render_notebook()

# 时间轴
begin_time = datetime.date(2020,1,1)
end_time = datetime.date(2020,1,7)
cate = ['A','B','C']
def random_data(n):
    return [random.randint(1,100) for i in range(n)] 
timeline = Timeline()
timeline.add_schema()
for i in range((end_time - begin_time).days + 1):
    day = begin_time + datetime.timedelta(days=1)
    bar = (Bar()
        .add_xaxis(cate)
        .add_yaxis('',random_data(len(cate)))
    )
    timeline.add(bar,day)
timeline.render_notebook()

# Tab选项卡
tab = Tab()
for c in cate:
    #...
    tab.add(line,c) # .add(图,tab标签名)

# 顺序多图
page = (
    Page()
    .add(bar1,line1,bar2,line2)
)
# 并列多图
grid = (
    Grid()
    .add(bar,grid_opts=)
    .add(line,grid_opts=)
)

parallel = (
    Parallel() # 多轴平行，具体略
)
tree = (
    Tree() # 树状图
)


# 主题的选择
theme_list = ['chalk','dark','essos',
    'infographic','light','macarons',
    'purple-passion','roma','romantic',
    'shine','vintage','walden',
    'westeros','white','wonderland']
# 创建图表时，Bar(init_opts=opts.InitOpts(theme='dark'))

一、全局配置项：
1.初始化配置项init_opts=opts.InitOpts()
width, height, theme, page_title(网页的标题)
bg_color(背景色), class_id(此用于多图时区分)
2.标题配置项title_opts=opts.TitleOpts()
title, title_link=url, title_target='self/blank'
subtitle, subtitle_link, subtitle_target
pos_left, pos_right = '20/20%/left/center/right'
pos_top, pos_bottom = '20/20%/top/middle/bottom'
item_gap = 10 #主副标题之间的间距
title_textstyle_opts=opts.TextStyleOpts(color='red') #主标题字体样式
3.图例配置项legend_opts=opts.LegendOpts()
type_='plain/scroll' # 滚动图例
select_mode = 'false/single/multiple' #不控制，单选，多选
is_show = False #是否显示图例 
pos_left, pos_right, pos_top, pos_bottom 同上
orient = 'horizontal/vertical' # 图例的朝向
item_gap #图例间距
item_width宽, item_height高, inactive_color关闭图例时的颜色
legend_icon = 'circle/rect/roundRect/triangle/diamond/pin/arrow'
textstyle_opts = opts.TextStyleOpts(color='red') # 图例字体
4.提示框配置项tooltip_opts=opts.TooltipOpts()
formatter=''模板变量:{a}系列名称,{b}数据名,{c}数值,{d}百分比不带%
textstyle_opts = opts.TextStyleOpts(color='red') # 字体
axis_pointer_type = 'line/shadow/none/cross'指示器类型
trigger = 'axis/item/none'
5.坐标轴配置项xaxis_opts=opts.AxisOpts()
type_='value/category/time/log' 数值轴/类目轴/时间轴/对数轴
is_scale = True #不包含0刻度，按实际的范围来刻度
name轴名称, is_show是否显示轴, is_inverse是否反向
min,max定义数值轴的最大最小值
字体设置:嵌套axislabel_opts=opts.LabelOpts(color,font_size,rotate)
轴线显示:嵌套axisline_opts=opts.AxisLineOpts(is_show=False,symbol='arrow')
 轴线样式:嵌套linestyle_opts=opts.LineStyleOpts(width=2, color='red')
轴线刻度和朝向:嵌套axistick_opts=opts.AxisTickOpts(is_show=True,is_inside=True)
6.视觉映射配置项visualmap_opts=opts.VisualMapOpts(), 用于热力图
is_show=False 关闭比色卡，min/max指定最大最小值，超过范围用边界色
range_color=['green','yellow','red'] 自定义过渡颜色
orient='horizontal/vertical'比色卡横竖
pos_left,pos_right,pos_top,pos_bottom比色卡位置
is_piecewise=Tree 不平滑过渡，而是一个区间给一个颜色,默认5段
split_number=4 分成4段，默认时5
自定义区间pieces=[{'max':50},{'min':50,'max':99},{'value':100,'color':'black'}]
7.区域缩放配置项datazoom_opts=opts.DataZoomOpts()
这像是一个过滤器,orient='horizontal/vertical'过滤横轴和纵轴
range_start,range_end，控制过滤的范围，取值0到100，表示轴的百分比范围

二、系列配置项
1.图元样式配置项itemstyle_opts=opts.ItemStyleOpts()
color填充颜色,border_color描边轮廓颜色,opacity透明度0~1
2.文本样式配置项TextStyleOpts()这个上面出现了，
用于嵌套到别的里，除主副标题title_前缀外，直接用textstyle_opts属性
color颜色，font_style='normal/italic/oblique'字体风格
font_weight='normal/bold/bolder/lighter'字体粗细
font_family=字体名字/'serif/monospace/Microsoft YaHei'等
font_size=字体大小，line_height行高
align水平对齐方式，vertical_align垂直对齐方式
background_color文字块背景色，border_width文字块边框宽度
width文字块宽度，height文字块高度
3.标签(当前值)配置项label_opts=opts.LabelOpts()
放.set_series_opts中，is_show=True/False显示/关闭
position='top/left/right/bottom/inside等'显示在哪儿
4.线样式配置项linestyle_opts=opts.LineStyleOpts()放在.add_yaxis里
width线宽，type_='solid实线/dashed短横/dotted点'线型,color颜色
5.分割线(网格)配置项splitline_opts=opts.SplitLineOpts()
嵌套在坐标轴opts.AxisOpts里，is_show,linestyle_opts分割线样式
6.分隔区域(色块分隔)splitarea_opts=opts.SplitAreaOpts()
嵌套在坐标轴opts.AxisOpts里，is_show,areastyle_opts色块样式
7.区域填充areastyle_opts=opts.AreaStyleOpts()
嵌套在坐标轴opts.SplitAreaOpts里，opacity=0~1
8.标记点markpoint_opts=opts.MarkPointOpts(),放set_series_opts里
data=[opts.MarkPointItem(标记点信息1),...,...]
标记点信息：标记点名字name='xxx',自定义标记点值value=?
标记特殊点type_='max/min/average',配合value_index=0/1找x/y轴的特殊点，默认1
标记像素值x=?,y=?
标记坐标coord=[横坐标，纵坐标]
9.标记线markline_opts=opts.MarkLineOpts(),放set_series_opts里
data=[opts.MarkLineItem(线信息1),...,...]，name,value
特殊线type_='max/min/average'
坐标线x=?或者y=?，因为是线，不需要两个一起
像素线x=?或者y=?，同上，一个即可
10.标记区域markarea_opts=opts.MarkAreaOpts()，同上
data=[opts.MarkAreaItem(区域信息1),...,...]，name,value
标记方式：x=(左边界,右边界),y=(下边界,上边界)

'''
