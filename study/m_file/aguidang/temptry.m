clear all 
close all
%% read the file
[aaa,bbb] = xlsread(uigetfile('*.xlsx'),'TOA5_2958.Table1','A1:H135516');
tc = aaa(:,1:6);
tr = aaa(:,7);
NAME_CH = bbb(1,2:7);
NAME_DATE = bbb(2:135516,1);

%% process the dates
x = [1:length(tr)]';       % the x axis
diff_tc=diff(tc);   % pick up the sampling point 
tcf=tc;             % copy for processing
for ch = 1:6
    d = 1+[0;find(diff_tc(:,ch) ~= 0)];   % find the location
    ld = length(d);     % loop ld-1 times
    for i = 1 : ld-1
        if d(i+1)-d(i) > 2
            y1 = tc(d(i),ch) - tr(d(i));
            y2 = tc(d(i+1),ch) - tr(d(i+1));
            for j = d(i)+1 : d(i+1)-1
                a=polyfit([d(i),d(i+1)],[y1,y2],1);
                tcf(j,ch) = tr(j) + polyval(a,j);
            end
        end
    end
end

%% write a file
xlswrite('温度重建.xlsx',NAME_CH,'B1:G1');
xlswrite('温度重建.xlsx',NAME_DATE,'A2:A135516');
xlswrite('温度重建.xlsx',tcf,'B2:G135516');

%% plot curves
plot(x,tr,'r')
title('参考曲线')
axis([0,140000,-10,25]);
figure
for i = 1:6
    subplot(2,3,i)
    plot(x,tc(:,i),'.y')
    hold on
    plot(x,tcf(:,i),'r')
    hold off
    axis([0,140000,-10,25]);
    switch i
        case 1
            title('CH1')
        case 2
            title('CH2')
        case 3
            title('CH3')
        case 4
            title('CH4')
        case 5
            title('CH5')
        case 6
            title('CH6')
    end
end

