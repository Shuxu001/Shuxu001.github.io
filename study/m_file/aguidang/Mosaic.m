clear all
close all
A=imread(uigetfile({'*.*'}));
q=A;
[y_max,x_max,diw]=size(A);
imshow(A);
[x,y]=ginput(2);
q(min(y):max(y),min(x):max(x),1)=0;
imshow(q);
while 1
    [x1,y1,bot]=ginput(1);
    if bot~=1
        break
    end
    q=A;
    dx=x1-(x(1)+x(2))/2;
    dy=y1-(y(1)+y(2))/2;
    q(min(max(min(y)+dy,1),y_max):min(max(max(y)+dy,1),y_max),min(max(min(x)+dx,1),x_max):min(max(max(x)+dx,1),x_max),1)=0;
    imshow(q);
end

% clear all;
% close all;
% %R=uigetfile;
% C=imread('BB22.png');
% B=rgb2gray(C);A=B;
% imshow(B);
% bot=1;
% while 1
% [h1,l1,bot]=ginput(1);
% if bot == 3 
%     break
% end
% [h2,l2,bot]=ginput(1);
% if bot == 3
%     break
% end
% if h1>h2
%     t=h1;h1=h2;h2=t;
% end
% if l1>l2
%     t=l1;l1=l2;l2=t;
% end
% [h,l]=size(B);t=10;
% for x=l1:t:l2
%     for y=h1:t:h2
%         me=uint8(mean(uint8(mean(A(x:x+t-1,y:y+t-1)))));
%         A(x:x+t-1,y:y+t-1)=me;
%     end
% end
% imshow(A);
% end