clear all
close all

fs=100; % 采样频率
N=100;  % 采样点数(越大，频率分辨率越高)
n=0:N-1;
t=n/fs; % 采样的时间点
y=0.5*sin(2*pi*20*t)+2*sin(2*pi*40*t);
subplot(2,2,1),plot(t(1:100),y(1:100))
x=fft(y,N);
m=abs(x)/N*2;
f=n*fs/N;
subplot(2,2,2),plot(f,m);
xlabel('频率/Hz');
ylabel('振幅');title('N=128');
grid on;

% fs=100;
% N=65536*64;
% n=0:N-1;
% t=n/fs;
% y=0.5*sin(2*pi*20*t)+2*sin(2*pi*40*t);
% subplot(2,2,3),plot(t(1:100),y(1:100))
% x=fft(y,N);
% m=abs(x)/N*2;
% f=n*fs/N;
% subplot(2,2,4),plot(f,m);
% xlabel('频率/Hz');
% ylabel('振幅');title('N=2048');
% grid on;
