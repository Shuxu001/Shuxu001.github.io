clc; clear all; close all

%% 常数
eps_0      = 8.854e-14;                  % 真空介电常数 (F/cm)
eps_ox     = 3.9;                        % 氧化物介电系数
eps_s      = 12;                         % 半导体介电系数
q          = 1.6e-19;                    % 电子电荷 (Coulomb)
kB         = 1.38e-23;                   % 玻尔兹曼常数 (J/K)
T          = 300;                        % 温度 (K)
kBT        = kB*T/q;                     

%% MOSFET的参数
VS         = 0;                          % 源极接地
VD         = 0.5;                        % 漏极0.5V
VGMOS      = linspace(-2,2,1001);        % 栅压 (V)
L_g        = 50e-7;                      % 栅长 (cm)
EOT        = 1.1e-7;                       % 等效栅极氧化物厚度 (cm) 
N_A        = 1e19;                       % 基底掺杂浓度 (1/cm^3) 
Vth        = 0.34;                       % 开启电压 (V) 开启电压
mu         = 295;                        % effective mobility of carrier (cm^2/Sec) 载流子的有效流动性
vx0        = 1.595e7;                    % saturation velocity of carrier (cm/sec) 载流子的饱和速度
beta       = 1.8;                        % saturation-transition-region fitting parameter 饱和过渡区匹配参数
Vfb        = -0.0;                       % flat-band potential (V) 平带电势
C_ox       = eps_ox*eps_0/EOT;           % 氧化层电容 (F/cm^2) 
ID1        = 1e-6;                       % 亚阈区电流1 (A/um) 
ID2        = 1e-4;                       % 亚阈区电流2 (A/um) 

%% 半导体电容
VGMOS_s  = VGMOS(VGMOS>=Vfb);          
for ii = 1:length(VGMOS_s)
       p             = [(q*N_A/2/(eps_s*eps_0))    (q*N_A/C_ox)    Vfb-VGMOS_s(ii)];
       r             = roots(p);
       W_s(ii)     = r(r>=0);
end
C_s                = eps_0*eps_s./W_s;                                % 半导体电容 (F/cm^2)

%% 总电容
C_MOS(VGMOS>=Vfb)   = C_s*C_ox./(C_s+C_ox);                        
C_MOS(VGMOS<Vfb)    = C_ox;                                        

%% 传统MOS的ID计算
VDSAT                = vx0*L_g/mu;                                        % drain bias for current saturation due to velocity saturation (V)
Fs                   = (VD/VDSAT)/(1+(VD/VDSAT)^beta)^(1/beta);           % field dependent factor
m                    = 1+(C_MOS/C_ox);                                   % body_factor
Qinv                 = C_ox*(m*kBT).*log(1+exp((VGMOS-Vth)/kBT./m));      % inversion charge to calculate current (Coul/cm^2)
ID                   = Qinv*vx0*Fs*1e-4;                                  % drain current (A/um)

%% 传统MOSFET
semilogy(VGMOS,ID,'-b','linewidth',2.0); hold on
text(0.5,5e-4,'无负电容','Fontsize',12);

VGMOS2              = VGMOS(ID>=ID2);
VGMOS1              = VGMOS(ID>=ID1);
plot(VGMOS2(1),ID2,'-or','markersize',8.0,'linewidth',2.0); hold on
plot(VGMOS1(1),ID1,'-or','markersize',8.0,'linewidth',2.0); hold on
SS_MOS              = (VGMOS2(1)-VGMOS1(1))/log10(ID2/ID1)*1000   
% hold off
%% 串联定值负电容后
C_FU       = -3e-6;                     % 串联的负电容
VGFU = (1+C_MOS/C_FU).*VGMOS;         
semilogy(VGFU,ID,'-b','linewidth',2.0); hold on
text(0.15,0.001,'有负电容','Fontsize',12);
title('有无负电容对比');

VGFU2            = VGFU(ID>=ID2);
VGFU1            = VGFU(ID>=ID1);
plot(VGFU2(1),ID2,'-or','markersize',8.0,'linewidth',2.0); hold on
plot(VGFU1(1),ID1,'-or','markersize',8.0,'linewidth',2.0); hold on
SS_FU            = (VGFU2(1)-VGFU1(1))/log10(ID2/ID1)*1000 

%% 图片设置

set(gca,'linewidth',1.5,'fontname','Helvetica','Fontsize',15,'ticklength',[0.015 0.015],'PlotBoxAspectRatio',[1 1 1]);
xlabel('V_{G} [V]'); ylabel('I_{DS} [A]'); axis([-0. 0.8 3e-7 1e-2]);
set(gca, 'XTick',[0.2:0.2:0.8]); set(gca, 'YTick',[1e-7 1e-6 1e-5 1e-4 1e-3 1e-2]);