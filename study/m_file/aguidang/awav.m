close all
clear all
[x,F,bits]=wavread('a.wav');
T=1/F;
t=(1:length(x))*T;
subplot(2,1,1);
plot(t,x(:,1));
% [q,qq]=ginput(2);
% q=q*F;
% A(1:q(1),:)=x(1:q(1),:);
% A(q(1)+1:q(1)+length(x)-q(2)+1,:)=x(q(2):length(x),:);
% subplot(2,1,2);
% plot(t(1:length(A)),A(:,1));
% wavplay(A,F);
% [w,ww]=ginput(1);
% w=w*F;
% B(1:length(x)-w+1,:)=x(w:length(x),:);
% wavplay(B,F);
[w,ww]=ginput(1);
w=round(w*F);
[y,F1,bits]=wavread('a.wav');
z(1:w,:)=x(1:w,:);
t1(1:w)=(1:w)/F;
z(w+1:w+length(y),:) = y(1:length(y),:);
t1(w+1:w+length(y)) = t1(w)+(1:length(y))/F1;
z(w+length(y)+1:length(y)+length(x),:) = x(w+1:length(x),:);
t1(w+length(y)+1:length(y)+length(x)) =w/F+ length(y)/F1 + (1:length(x)-w)/F;
subplot(2,1,2);
plot(t1,z(:,1));