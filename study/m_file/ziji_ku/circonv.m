function yc=circonv(x1,x2,N)
if length(x1)>N
    error('N must not be less than length of x1');
end
if length(x2)>N
    error('N must not be less than length of x2');
end
x1=[x1,zeros(1,N-length(x1))];
x2=[x2,zeros(1,N-length(x2))];
n=[0:1:N-1];
x2=x2(mod(-n,N)+1);
H=zeros(N,N);
for n=1:1:N
    H(n,:)=cirshiftd(x2,n-1,N);
end
yc=x1*H';
 
function y=cirshiftd(x,m,N)
if length(x)>N
    error('x must not be less than length of N');
end
x=[x,zeros(1,N-length(x))];
n=[0:1:N-1];
y=x(mod(n-m,N)+1);
