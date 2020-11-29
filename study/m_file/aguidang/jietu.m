[filename, pathname] = uigetfile('*.png');
%没有图像
if filename == 0
    return;
end
src = imread([pathname, filename]);
[m, n, z] = size(src);
figure(1)
imshow(src)%显示原图像
h=imrect;%鼠标变成十字，用来选取感兴趣区域
pos=getPosition(h);
imCp = imcrop( src, pos );
figure(2)
imshow(imCp);
