function fy=kernel(x,y,sigma2)
fy=exp(-(x-y)'*(x-y)/sigma2);