%% w
clear;clc;
load('rg');
ff=fopen('d.dat','wb');
fwrite(ff,rg,'double');
fclose(ff);
%% q
clear;clc;
ff=fopen('d.dat','rb');
w=fread(ff,'double');
fclose(ff);
imshow(reshape(w,[798 598]))