 % ´óÊý³Ë·¨
 function y0 = lgmul(a0,b0)
    a=fliplr(a0); b=fliplr(b0);
    ly=length(a)+length(b);    
    y=zeros(1,ly);
    jr=conv(a,b);jr(ly)=0;
    y(1)=rem(jr(1),10);
    f(1)=0;
    for t = 2 : ly
        f(t)=floor((f(t-1)+jr(t-1))/10);
        y(t)=rem((f(t)+jr(t)),10);
    end
    if y(ly) == 0
        y0=fliplr(y([1:ly-1]));
    else y0=fliplr(y);
    end
 end