% arg:img,kh,kw. output double 0-1.
function imgout = fhda(img,kh,kw)
% kh=1.56;     %高
% kw=1.56;    %宽
% img=imread(uigetfile({'*.*'}));
class_of_img = class(img);
if class_of_img(1)=='u'
    img = double(img)/255;
    disp('in uint8,to double.');
end
[h,w,dv]=size(img);
imgn=zeros(floor(h*kh),floor(w*kw),dv);
rot=[kh 0 0;0 kw 0;0 0 1];     %变换矩阵
for d=1:dv
for i=1:h*kh
    for j=1:w*kw
        pix=[i j 1]/rot;
        float_Y=pix(1)-floor(pix(1));
        float_X=pix(2)-floor(pix(2));   %边界处理
        if pix(1) < 1
            pix(1) = 1;
        end
        if pix(1) > h
            pix(1) = h;
        end
        if pix(2) < 1
            pix(2) =1;
        end
        if pix(2) > w
            pix(2) =w;
        end
        pix_up_left=[floor(pix(1)) floor(pix(2))];%四个相邻的点
        pix_up_right=[floor(pix(1)) ceil(pix(2))];
        pix_down_left=[ceil(pix(1)) floor(pix(2))];
        pix_down_right=[ceil(pix(1)) ceil(pix(2))];
        value_up_left=(1-float_X)*(1-float_Y);%计算临近四个点的权重
        value_up_right=float_X*(1-float_Y);
        value_down_left=(1-float_X)*float_Y;
        value_down_right=float_X*float_Y; %按权重进行双线性插值
        imgn(i,j,d)=value_up_left*img(pix_up_left(1),pix_up_left(2),d)+ ...
            value_up_right*img(pix_up_right(1),pix_up_right(2),d)+ ...
            value_down_left*img(pix_down_left(1),pix_down_left(2),d)+ ...
            value_down_right*img(pix_down_right(1),pix_down_right(2),d);
    end
end
end
imgout = imgn;
end