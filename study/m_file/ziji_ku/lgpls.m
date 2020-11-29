% 大数加法
function y0 = lgpls(a0,b0)
    a1=fliplr(a0);b1=fliplr(b0);
    ly=max(length(a1),length(b1))+1;
    a=zeros(1,ly);a([1:length(a1)])=a1([1:length(a1)]);
    b=zeros(1,ly);b([1:length(b1)])=b1([1:length(b1)]);
    y(1)=rem(a(1)+b(1),10);    f(1)=0;
    for t=2:ly
        f(t)=floor((a(t-1)+b(t-1)+f(t-1))/10);
        y(t)=rem(a(t)+b(t)+f(t),10);
    end
    if y(ly)==0
        y0=fliplr(y([1:ly-1]));
    else 
        y0=fliplr(y);
    end
end