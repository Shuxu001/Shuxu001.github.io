clear all;
xy(1,:)=[0,0];
plot([1,2],[1,2]);
axis([0,5,0,2]);
hold off;
bot=1;
flg=0;
while bot==1
    [x,y,bot]=ginput(1);
    xy(2,:)=[x,y];
    if flg==1
        plot(xy(:,1),xy(:,2));
        axis([0,5,0,2]);
        hold on;
    end
    flg=1;
    xy(1,:)=xy(2,:)
end
