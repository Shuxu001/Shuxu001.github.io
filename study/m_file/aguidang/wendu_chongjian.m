clear all 
close all
%% import data
ttt=xlsread('tmpe.xlsx','TOA5_2958.Table1','B2:H135516');
temp(:,1:6)=ttt(:,1:6); 
tref(:,1)=ttt(:,7);
len=length(tref);
x=[1:len]';

%% process tref curve
trlow=zeros(len,1);
foots=12*60/3;  % ±12h
for j_tr = 1:len
    if j_tr<=foots
        trlow(j_tr,1) = mean(tref(1:j_tr+foots,1));
    elseif j_tr>foots && j_tr<=len-foots
        trlow(j_tr,1) = mean(tref(j_tr-foots:j_tr+foots,1));
    else
        trlow(j_tr,1) = mean(tref(j_tr-foots:len,1));
    end
end

%% plot
% plot(x,tref);
% hold on
% for i=1:6
%     plot(x,temp(:,i))
% end
