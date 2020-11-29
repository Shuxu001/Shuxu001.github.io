%% 返回范围内的bz(尺寸n*4)
% 参数：文件夹,起始点,结束点(可不)
% function bz_all = openbz(fpath_bz_str,n_start,n_end)
if nargin<3
    n_end = n_start;
end
fname_bz_str = '/%d.txt';
bz_all = zeros(n_end-n_start+1,4);
for i =[n_start:n_end]
    f_dat = sprintf([fpath_bz_str,fname_bz_str],i);
    data = importdata(f_dat);
    bz_all(i-n_start+1,:) = data(1:4)+[1 1 0 0];
end    
% end


%%  返回范围内的dat(尺寸r*c*n)
% 参数：文件夹,起始点,结束点(可不),[行，列，跳]
% function data_all = opendat(fpath_dat_str,n_start,n_end,data_arg)
if nargin<3
    n_end = n_start;
end
if nargin<4
    data_arg = [64,1024,90];
end
dat_hang = data_arg(1);
dat_lie = data_arg(2);
dat_skip = data_arg(3);
fname_dat_str = '/%d.dat';
data_all = zeros(dat_hang,dat_lie,n_end-n_start+1);
for i =[n_start:n_end]
    f_dat = sprintf([fpath_dat_str,fname_dat_str],i);
    f = fopen(f_dat,'rb');
%     data = fread(f, [dat_hang,dat_lie], 'double',dat_skip);
    data = fread(f, 'double');
    data=reshape(data([1+dat_skip:dat_hang*dat_lie+dat_skip]),dat_lie,dat_hang)';
    fclose(f);
    data_all(:,:,i-n_start+1) = data;
end    
% end



%% 1.去周期背景；2.整合train的标注
close all

dtest1 = opendat('./test1/dat',1,300,[64 1024 90]);
dtrain = opendat('./train/dat',1,2500,[64 1024 90]);
dtest1_wbj = zeros(64,1024,300);
dtrain_wbj = zeros(64,1024,2500);
gap = ones(1,1024);

fpng = './test1/%d.png';
for i =[1:300] 
    fpngi = sprintf(fpng,i);
    di = dtest1(:,:,i);
    zq1 = di(:,1:125);       zq2 = di(:,126:250);
    zq3 = di(:,251:375);     zq4 = di(:,376:500);
    zq5 = di(:,501:625);     zq6 = di(:,626:750);
    zq7 = di(:,751:875);     zq8 = di(:,876:1000);
    zq0 = (zq1+zq2+zq3+zq4+zq5+zq6+zq7+zq8)/8;
    zqall = horzcat(repmat(zq0,1,8),zq0(:,1:24));
    di1 = di-zqall;
    di2 = di1.*(di1>0)/max(max(di1));   % 得到的无周期背景的结果图
    dtest1_wbj(:,:,i) = di2;
%     pi = vertcat(gyh(di),gap,di2);
%     imwrite(di2,fpngi);
    if mod(i,100)==0
        disp(i);toc
    end
    tic;
end

fpng = './train/%d.png';
for i=[1:2500] 
for i =1
    fpngi = sprintf(fpng,i);
    di = data(:,:,i);
    q1 = di(:,1:125);       q2 = di(:,126:250);
    q3 = di(:,251:375);     q4 = di(:,376:500);
    q5 = di(:,501:625);     q6 = di(:,626:750);
    q7 = di(:,751:875);     q8 = di(:,876:1000);
    q0 = (q1+q2+q3+q4+q5+q6+q7+q8)/8;
    q = horzcat(repmat(q0,1,8),q0(:,1:24));
    di1 = di-q;
    di2 = di1.*(di1>0)/max(max(di1));  
    dtrain_wbj(:,:,i) = di2;
%     pi = vertcat(gyh(di),gap,di2);
%     imwrite(di2,fpngi);
    if mod(i,100)==0
        disp(i);toc
    end
    tic;
end
disp('..........Over..........');


%% 提取周期
% Ts = zeros(2500,1);
% for i =1:2500
% 
% Ts = zeros(700,2);
% for i = num_of_timg'
% for i = 120
%     if mod(i,50)==0
%         disp(i)
%     end
%     if i<=500 && i>400
%         continue
%     end
    i=1;
    di=gyh(dtest2(:,:,i));
    imshow(di);title('1.dat 原图')
    di=imfilter(di(:,101:700),ones(3,3)/9);
    dsize = size(di);
    xm=mean(di);
    
    k=10;    
    x=interp1([1:dsize(2)],xm2,[1:1/k:dsize(2)],'linear');    
    fw=abs(fft(x));
%     plot(fw,'.')
    lenx = length(x);
    [~,idx]=sort(fw,'descend');
    for ii = idx(2:length(idx))
        if ii<100
            zqs=ii-1;
            break;
        end
    end
%     if zqs>100
%         continue;
%     end
    Tmax = min(ceil(lenx/(zqs-1)),lenx);
    Tmin = max(floor(lenx/(zqs+1)),5*k);
    tnum = Tmax-Tmin+1;
  	var_when_t = zeros(tnum,1);
    for t = Tmin:Tmax
        n_when_t = floor(lenx/t);
        newx = reshape(x(1:n_when_t*t),t,n_when_t);
        var_when_t(t-Tmin+1) = mean(var(newx,0,2));
    end
    [~,idxy] = sort(var_when_t);
    Tk=(idxy(1)+Tmin-1);
    T=Tk/k;
    Ts(i,1)=T;
    if T==31.2||T==31.3||T==15.6||T==62.5
        T=125;
    end
    Ts(i,2)=T;
% end


figure(1);hold on;
for i = [62.5 10 15 30 45 55]
%     if floor(i)-i==0
        plot(ones(700,1)*i,'g');
%     else
%         plot(ones(700,1)*i,'r');
%     end
end
for i = [15.6 31.2 31.3]
        plot(ones(700,1)*i,'r');
end
plot(Ts(:,1),'.b');hold off



%% m1106
% 读取30t的图和bz并拉伸
close all
bz = importdata('bz1106.txt');
bzhead = zeros(652,1);
% 取出每行对应的图片序号
for i = 1:652
    namei = bz.textdata{i};
    numi = str2double(namei(1:length(namei)-4));
    bzhead(i) = numi;
end
for i = num_of_30timg'
% for i = 26
    pi1 = gyh(dtest2(:,:,i));
    pi2 = dtest2_wbj_1103(:,:,i);
    numis = find(bzhead==i);
    for j = numis'
        bzj = bz.data(j,1:4);
        pi1 = redrect(pi1,bzj); 
        pi2 = redrect(pi2,bzj);
    end
    if length(size(pi1))==3
        gap=ones(10,1024,3);
    else
        gap = ones(10,1024);
    end
    pi = vertcat(pi1,gap,pi2);
    pi=fhda(pi,1,2);
    imwrite(pi,['./test2/',num2str(i),'.png']);
end

for i = num_of_30timg'
    q=imread(['./test2/图册/34t的拉伸/',num2str(i),'.png']);
    q=q(:,1024:2048,:);
    imwrite(q,['./test2/',num2str(i),'.png']);
end


%% m1103
% load('cjuu_of_timg.mat')
% load('dtest2.mat')
% dtest2_wbj_1103 = zeros(64,1024,700);
close all
% for i = [501:648]
    c=[1 125];
%     c=[i t_of_timg(i)];
    % di=dtrain(:,:,c(1));
    di=gyh(dtest2(:,:,c(1)));
    T=c(2);
%     if T==0
% %         imwrite(gyh(di),['./test2/',num2str(i),'.png']);
% %         dtest2_wbj_1103(:,:,i) = gyh(di,0);
%         continue;
%     end
    n=floor(1024/T);
    zq0=zeros(64,T);
    tail = 1024-n*T;    
%     if i>100 && i<=200
% %         start_oft = floor(tail/2);  
%         start_oft = tail;
%         end_oft = tail-start_oft;
%         for j = 2:n-1
%             zq0=zq0+di(:,1+(j-1)*T+start_oft:T*j+start_oft);
%         end
%         zq0=zq0/n;
%         bj=horzcat(zq0(:,T-start_oft+1:T),repmat(zq0,1,n),zq0(:,1:end_oft));        
%         di1= di-bj;
%         di2 = gyh(di1,0);
%         di2(:,1:20)=0;
%     %     imshow(di2)
%         imwrite(di2,['./test2/',num2str(i),'.png']);
%     else
        plustime = 0;
        for j = 1:n
            tou = 1+(j-1)*T;
            wei = T*j;
            if tou >= 100 && wei <= 900
                zq0=zq0+di(:,tou:wei);
                plustime = plustime+1;
            end
        end
        zq0=zq0/plustime;
        bj=horzcat(repmat(zq0,1,floor(1024/T)),zq0(:,1:mod(1024,T)));        
        di1= di-bj;
%         di2 = gyh(di1,0);
%         di2(:,1:20)=di2(:,1+T:20+T);
%         di2(:,986:1024)=di2(:,mod(986,T)+T:mod(986,T)+T+1024-986);
        
%         di3 = abs(di1).^1.3;
        di2=imfilter(di1,[-1 -1 -1;-1 9 -1;-1 -1 -1]);
        di3 = gyh(di2,0,1);
        di3 = di3.^2;
%         imwrite(di2,['./test2/',num2str(i),'.png']);
%         dtest2_wbj_1103(:,:,i)=di2;
%     end

%     lklk(di-bj,1)
% end
subplot(4,1,1);imshow(di)
subplot(4,1,2);imshow(di1);%imshow(di1,[]);
subplot(4,1,3);imshow(di2);
subplot(4,1,4);imshow(di3);
% 第10页
subplot(3,1,1);imshow(di);title('原图')
subplot(3,1,2);imshow(bj);title('背景')
subplot(3,1,3);imshow(di1);title('原图 减 背景')
% 第12页
qy=[15,60,660,750];
dd=di(qy(1):qy(2),qy(3):qy(4));
d1=di1(qy(1):qy(2),qy(3):qy(4));
d2=di3(qy(1):qy(2),qy(3):qy(4));
subplot(1,3,1);imshow(dd);title('原图目标区域')
subplot(1,3,2);imshow(d1);title('只是滤除背景')
subplot(1,3,3);imshow(d2);title('拉普拉斯锐化+非线性变换')
%% m1030
% 统计分析小周期的数据
close all
clear
% dtest1 = load('data_test1').data_test1;
fpng = './test1/%d.png';
zq0_all = load('zq0_all').zq0_all;

for i = 1:300
    fpngi = sprintf(fpng,i);
    a = imread(['./test1/hljz_mh/' num2str(i) '.png']);
    b = imread(['./test1/test1_zq0/' num2str(i) '.png']);
    fig=figure('visible','off','Position',[0 0 1360 650]);
    axes('position',[0 0 0.6 1]);imshow(a);
    axes('position',[0.7 0.2 0.2 0.5]);imshow(b);
%     pause
    frame = getframe(fig);
    img = frame2im(frame);
    imwrite(img,fpngi)
    close(fig)
end


% 保存均值
% for i = 1:300
%     
%     fpngi = sprintf(fpng,i);
%     zi = zq0_all(:,:,i);
%     zi = imfilter(zi,ones(3,3)/9);
%     shu = mean(zi,2);
%     hen = mean(zi);
%     fig=figure('visible','off','Position',[10 100 800 600]);
%     subplot(2,1,1);plot(shu);title('每行的均值');
%     subplot(2,1,2);plot(hen);title('每列的均值');
% %     print(fig,'-dpng',fpngi);
%     frame = getframe(fig);
%     img = frame2im(frame);
%     imwrite(img,fpngi)
%     close(fig)
% end
% % 'visible','off',



% 把小周期存成一张
% zq0_all = zeros(64,125,300);
% for i = [1:300]
%     di = gyh(dtest1(:,:,i));
%     zq1 = di(:,1:125);       zq2 = di(:,126:250);
%     zq3 = di(:,251:375);     zq4 = di(:,376:500);
%     zq5 = di(:,501:625);     zq6 = di(:,626:750);
%     zq7 = di(:,751:875);     zq8 = di(:,876:1000);
%     zq0 = (zq1+zq2+zq3+zq4+zq5+zq6+zq7+zq8)/8;
%     zq0_all(:,:,i) = zq0;
% end
% gap1 = ones(64,1);
% gap2 = ones(1,1261);
% for k = [1:30]
%     for j = [1:10]
%         i = 10*(k-1)+j;
%         zq0 = zq0_all(:,:,i);
%         if j == 1
%             y1 = zq0;
%         else
%             if j == 6
%                 y1 = horzcat(y1,gap1,gap1,gap1,zq0);
%             else
%                 y1 = horzcat(y1,gap1,zq0);
%             end
%         end
%     end
%     
%     if k==1
%         y = y1;
%     else
%         if mod(k,5) == 1
%             y = vertcat(y,gap2,gap2,gap2,y1);
%         else
%             y = vertcat(y,gap2,y1);
%         end
%     end
% end

%% 10.19平滑+画图
clear
fname = './truu1h/dat/%d.dat';
fpng = './truu1h/%d.png';
% fname = './test1/%d.dat';
qishi = 501;
mowei = 600;
offst = qishi-1;
d_hh = 64;
d_ll = 1024;
d_tt = 90;
data = zeros(d_hh,d_ll,mowei-qishi+1);
for i = [1:mowei-qishi+1]
    fnamei = sprintf(fname,i+offst);
    f = fopen(fnamei,'rb');
    drd = fread(f,'double');
    data(:,:,i) = reshape(drd(d_tt+1:d_hh*d_ll+d_tt),d_ll,d_hh)';
    fclose(f);
end

h2 = [1 4 9 25 9 4 1]/53;
h1 = h2';
% for i =[1:mowei-qishi+1]
for i = [1:100]

    fpngi = sprintf(fpng,i+offst);
    di = data(:,:,i);
%     [sort_di,xuhao] = sort(reshape(di,65536,1),'descend');
%     idx_max = [mod(xuhao(1),d_hh),ceil(xuhao(1)/d_hh)];
%     select = di(idx_max(1),[max(1,idx_max(2)-65):min(1024,idx_max(2)+65)]);

% 保存成png

    max_i = max(max(data(:,:,i)));
    min_i = min(min(data(:,:,i)));
    img = (data(:,:,i)-min_i)/(max_i-min_i);
    imwrite(img,fpngi);

 
% 画局部正负65的
%     fig = figure('Position',[1 100 1000 800]);
%     subplot(2,1,1)
%     plot(select)
%     title([num2str(i+offst),'的高亮左右的±65'])
%     subplot(2,1,2)
%     plot(imfilter(select,[1 1 1]/3))
%     title('上面的图用111平滑')
%     pause
%     close(fig)
% 画max的
%     fig = figure('Position',[1 100 1920 800]);
%     subplot(2,1,1);
%     plot([1:64],max(di,[],2),'-')
%     title(['max',num2str(i+offst)]);
%     subplot(2,1,2);
%     plot([1:1024],max(di),'-')
%
%     pause(0.1)
%     frame = getframe(fig);
%     img = frame2im(frame);
%     imwrite(img,fpngi)
%     close(fig)
    
end

%% m1020
close all
n1 = 1;
n2 = 700;
i_oft = n1-1;
data = opendat('./test2/dat',n1,n2,[64 1024 170]);
% data = opendat('./truu1h/dat',n1,n2);
% bz = openbz('./truu1h/bz',501,600);
% fpng = './truu1h/%d.png';
fpng = './test2/%d.png';
d_hh=64;
d_ll=1024;
% ck = 100;   % 窗宽
% sfin=zeros(100,1);  %

for i =[1:700]
% for i=1
%     fig = figure('Position',[1 40 1800 405]); 
    di=data(:,:,i);
%     bi=bz(i,:);

% 均值滤波
    mh = zeros(d_hh,d_ll);
    mean_1=mean(di,2);
    for j=1:d_ll
        mh(:,j)=mean_1;
    end
    di1=di-mh;  % 减所在行的均值
    
    mean_2=mean(di1,2);
    for j=1:d_ll
        mh(:,j)=mean_2;
    end
    di2=di1-mh;  % 用的是di1带负
    
    di1_gui0=di1.*(di1>0);
    mean_3=mean(di1_gui0,2);
    mh = zeros(d_hh,d_ll);
    for j=1:d_ll
        mh(:,j)=mean_3;
    end
    di3=di1_gui0-mh;  % 用的是di1负数置0

%     subplot(4,1,1)
%     lklk(di)
%     title(['原图',num2str(i+i_oft)])
%     subplot(4,1,2)
%     lklk(di1,1)
%     title('减所在行的均值,负数置0')
%     subplot(4,1,3)
%     lklk(di2,1)
%     title('第一次负数不置0，第2次负数置0')
%     subplot(4,1,4)
%     lklk(di3,1)
%     title('连续两次减均值并负数置0')

    di3=di3/max(max(di3));
    fpngi=sprintf(fpng,i+i_oft);
    imwrite(di3,fpngi)
    
% N(0,1)化
%     n_avg = mean2(di);
%     n_std = std2(di);
%     di_nor = (di-n_avg)/n_std;
%     di = di_nor;
%     subplot(2,1,1)
%     lklk(di)
%     title(['原图',num2str(i+i_oft)])
%     subplot(2,1,2)
%     lklk(di_nor)
%     title('正态')
%     pause
%     close all
% 取值滤波
%     di2 = di-ordfilt2(di,2,ones(3,3));
%     di3 = di-ordfilt2(di,2,ones(3,7));
%     subplot(4,1,1)
%     lklk(di)
%     title(['原图',num2str(i+i_oft)])
%     subplot(4,1,2)
%     lklk(di2,1)
%     title('减3x3中值')

%% 找最大值
%     [sort_di,xuhao] = sort(reshape(di1,d_hh*d_ll,1),'descend');
%     idx_max = [mod(xuhao(1),d_hh),ceil(xuhao(1)/d_hh)];
%     if idx_max(1)<bi(2)+bi(4)+5 && idx_max(1)>=bi(2)-5 && idx_max(2)<bi(1)+bi(3)+1 && idx_max(2)>=bi(1)-1
%         sfin(i)=1;  
%     end
%     select = di(idx_max(1),[max(1,idx_max(2)-ck):min(1024,idx_max(2)+ck)]);
%     subplot(4,1,1)
%     plot(select)
%     subplot(4,1,2)
%     plot(imfilter(select,[1 1 1]/3))
    
% 输出图像    
%     fpngi=sprintf(fpng,i+i_oft);
%     frame = getframe(fig);
%     img = frame2im(frame);
%     imwrite(img,fpngi)
%     pause
%     close(fig)
end
% sum(sfin);
disp('Over.')

%% m1027
close all
n1 = 1;
n2 = 300;
i_oft = n1-1;
data = opendat('./test1/dat',n1,n2,[64 1024 90]);
fpng = './test1/%d.png';
d_hh=64;
d_ll=1024;
% ck = 100;   % 窗宽
% sfin=zeros(100,1);  %
tic

for i =[1:300]
% for i=1
%     fig = figure('Position',[1 40 1800 405]); 
    di=data(:,:,i);
%     bi=bz(i,:);

% 均值滤波
%     mh = zeros(d_hh,d_ll);
%     mean_1=mean(di,2);
%     for j=1:d_ll
%         mh(:,j)=mean_1;
%     end
%     di1=di-mh;  % 减所在行的均值
%     
%     mean_2=mean(di1,2);
%     for j=1:d_ll
%         mh(:,j)=mean_2;
%     end
%     di2=di1-mh;  % 用的是di1带负
%     
%     di1_gui0=di1.*(di1>0);
%     mean_3=mean(di1_gui0,2);
%     mh = zeros(d_hh,d_ll);
%     for j=1:d_ll
%         mh(:,j)=mean_3;
%     end
%     di3=di1_gui0-mh;  % 用的是di1负数置0
%     di3=di3/max(max(di3));
%     di3=di3.*(di3>0);
    
%     subplot(4,1,1)
%     lklk(di)
%     title(['原图',num2str(i+i_oft)])
%     subplot(4,1,2)
%     lklk(di1,1)
%     title('减所在行的均值,负数置0')
%     subplot(4,1,3)
%     lklk(di2,1)
%     title('第一次负数不置0，第2次负数置0')
%     subplot(4,1,4)
%     lklk(di3,1)
%     title('连续两次减均值并负数置0')

    
%     fpngi=sprintf(fpng,i+i_oft);
%     imwrite(di3,fpngi)
    
% 取值滤波
%     di2 = di-ordfilt2(di,2,ones(1,15));
%     di3 = di-ordfilt2(di,2,ones(1,15));
%     subplot(4,1,1)
%     lklk(di)
%     title(['原图',num2str(i+i_oft)])
%     subplot(4,1,2)
%     lklk(di2,1)
%     title('')

%
    di0 = (di-min(min(di)))/(max(max(di))-min(min(di)));
%     q=vertcat(di0,ones(1,1024),di3);
%     for j = [3 5 7 9 13 17 23 33 45 61]
%         dij = di-imfilter(di,ones(1,j)/j);
%         dij = dij/max(max(dij));
%         dij = dij.*(dij>0);
%         q=vertcat(q,ones(1,1024),dij);
%     end
    q=vertcat(di0(:,501:1024),ones(1,524),di3(:,501:1024),ones(1,524),di0(:,501:1024)-di0(:,1:524));
    fpngi=sprintf(fpng,i+i_oft);
    imwrite(q,fpngi)
    if mod(i,20)==0
        toc
        tic
    end
end
% sum(sfin);
disp('Over.')

