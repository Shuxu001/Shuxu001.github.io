import requests
from lxml import etree
import json
import pandas

class Nbtq():
    def __init__(self):
        self.myurl =   "http://lishi.tianqi.com/ningbo/2019{}.html"    
        self.month_list = ['01','02','03','04','05','06','07','08','09','10','11','12']
        self.days_dict = {'01':31,'02':28,'03':31,'04':30,
                    '05':31,'06':30,'07':31,'08':31,
                    '09':30,'10':31,'11':30,'12':31
                    }
        self.myheaders = {"User-Agent":"Mozilla/5.0 (Windows NT 10.0; WOW64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/80.0.3987.163 Safari/537.36"
             }
        
    def url_respond(self,url):
        print('responding')
        response = requests.get(url,headers=self.myheaders)
        #with open('respond.txt',"w",encoding="utf-8") as f:
        #    f.write(response.content.decode())
        return response.content.decode()
    
    def get_content(self,html_str):
        html_element = etree.HTML(html_str)
        #print(type(html_element))
        no_process = html_element.xpath("/html//ul[@class='thrui']//li//div/text()")
        length = int(len(no_process)/5)
        print('get element:',length)
        date_list=[]
        max_list=[]
        min_list=[]
        tq_list=[]
        feng_list=[]
        for i in range(length):
            date_list.append(no_process[5*i].strip())
            max_list.append(no_process[5*i+1])
            min_list.append(no_process[5*i+2])
            tq_list.append(no_process[5*i+3])
            feng_list.append(no_process[5*i+4])
        return date_list,max_list,min_list,tq_list,feng_list
  
    def save_content(self,tq_dict):
        txtwrite = '{0},{1},{2},{3},{4}\n'
#        with open("nbtq2019.txt","w",encoding="utf-8") as f:
#            f.write(txtwrite.format('日期','最高温','最低温','天气','风'))
#            for i in range(365):
#                f.write(txtwrite.format(tq_dict['date'][i],tq_dict['wd_max'][i],tq_dict['wd_min'][i],tq_dict['tianqi'][i],tq_dict['feng'][i]))
        df = pandas.DataFrame(tq_dict)
        df.to_excel('nbtq2019.xlsx',index=False)        
        print('saved')
    

    def run(self):
        date_list=[]
        max_list=[]
        min_list=[]
        tq_list=[]
        feng_list=[]
        for i in range(12):
            #1.确定url
            url = self.myurl.format(self.month_list[i])
            #2.发送请求，获取响应
            html_str = self.url_respond(url)
            #3.提取数据
            date_list_i,max_list_i,min_list_i,tq_list_i,feng_list_i = self.get_content(html_str)
            print('length_{}:'.format(i+1),len(date_list_i),len(max_list_i),len(min_list_i),len(tq_list_i),len(feng_list_i))
        
            #4.添加到原来的列表后面
            date_list += date_list_i
            max_list += max_list_i
            min_list += min_list_i
            tq_list += tq_list_i
            feng_list += feng_list_i
        #5.用一个字典输出
        nbtq={}
        nbtq["date"] = date_list
        nbtq["wd_max"] = max_list
        nbtq["wd_min"] = min_list
        nbtq["tianqi"] = tq_list
        nbtq["feng"] = feng_list
        #print('length:',len(date_list),len(max_list),len(min_list),len(tq_list),len(feng_list))
        #6.保存到记事本
        self.save_content(nbtq)

        return nbtq

if __name__ == '__main__':
    nbtq = Nbtq()
    nbtq2019_dict=nbtq.run()
