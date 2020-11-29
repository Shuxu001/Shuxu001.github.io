% arg:x,xmin,xmax,a,b
% xmin:xmax => a:b
% defalut:min(x),max(x),0,1 
function y=gyh(x,xmin,xmax,a,b)
    y=0;
    if nargin < 5
        b = 1;
    end
    if nargin < 4
        a = 0;
    end
    if nargin < 3
        xmax = max(max(x));
    end
    if nargin < 2
        xmin = min(min(x));
    end
    
    y = (x-xmin)/(xmax-xmin);
    y = y-(y-1).*(y>1);
    y = y.*(y>0);
    y = y*(b-a)+a;    
end