
% 函数fact(n)  计算正整数n的阶乘
function output = fact(n)
output = 1;
for i = 1:n
output = output*i;
end