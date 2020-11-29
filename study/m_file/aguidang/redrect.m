% arg:data,bz,show_or_not
% 输入double图，输出带红框的double图
% 默认show_or_not=0,赋1时显示图像
function img_rk = redrect(data,bz,show_or_not)
    if nargin<3
        show_or_not=0;
    end
    if length(size(data))==2
        data = cat(3,data,data,data);
    end
    x = bz(1);
    y = bz(2);
    w = bz(3);
    h = bz(4);
    data(y       , x:x+w-1  , 1) = 1;
    data(y+h-1   , x:x+w-1  , 1) = 1;
    data(y:y+h-1 , x        , 1) = 1;
    data(y:y+h-1 , x+w-1    , 1) = 1;
    img_rk = data;
    if show_or_not~=0
        imshow(img_rk)
    end
end