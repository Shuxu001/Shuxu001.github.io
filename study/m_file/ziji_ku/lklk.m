% lklk(x)归一化显示,lklk(x,0)先负数置0
function lklk(x,xmin)
    if nargin == 1
        xmin=min(min(x));
    end
    xmax=max(max(x));
    x1=(x-xmin)/(xmax-xmin);
    imshow(x1)
end