clc; clear all; close all

%% ����
eps_0      = 8.854e-14;                  % ��ս�糣�� (F/cm)
eps_ox     = 3.9;                        % ��������ϵ��
eps_s      = 12;                         % �뵼����ϵ��
q          = 1.6e-19;                    % ���ӵ�� (Coulomb)
kB         = 1.38e-23;                   % ������������ (J/K)
T          = 300;                        % �¶� (K)
kBT        = kB*T/q;                     

%% MOSFET�Ĳ���
VS         = 0;                          % Դ���ӵ�
VD         = 0.5;                        % ©��0.5V
VGMOS      = linspace(-2,2,1001);        % դѹ (V)
L_g        = 50e-7;                      % դ�� (cm)
EOT        = 1.1e-7;                       % ��Чդ���������� (cm) 
N_A        = 1e19;                       % ���ײ���Ũ�� (1/cm^3) 
Vth        = 0.34;                       % ������ѹ (V) ������ѹ
mu         = 295;                        % effective mobility of carrier (cm^2/Sec) �����ӵ���Ч������
vx0        = 1.595e7;                    % saturation velocity of carrier (cm/sec) �����ӵı����ٶ�
beta       = 1.8;                        % saturation-transition-region fitting parameter ���͹�����ƥ�����
Vfb        = -0.0;                       % flat-band potential (V) ƽ������
C_ox       = eps_ox*eps_0/EOT;           % ��������� (F/cm^2) 
ID1        = 1e-6;                       % ����������1 (A/um) 
ID2        = 1e-4;                       % ����������2 (A/um) 

%% �뵼�����
VGMOS_s  = VGMOS(VGMOS>=Vfb);          
for ii = 1:length(VGMOS_s)
       p             = [(q*N_A/2/(eps_s*eps_0))    (q*N_A/C_ox)    Vfb-VGMOS_s(ii)];
       r             = roots(p);
       W_s(ii)     = r(r>=0);
end
C_s                = eps_0*eps_s./W_s;                                % �뵼����� (F/cm^2)

%% �ܵ���
C_MOS(VGMOS>=Vfb)   = C_s*C_ox./(C_s+C_ox);                        
C_MOS(VGMOS<Vfb)    = C_ox;                                        

%% ��ͳMOS��ID����
VDSAT                = vx0*L_g/mu;                                        % drain bias for current saturation due to velocity saturation (V)
Fs                   = (VD/VDSAT)/(1+(VD/VDSAT)^beta)^(1/beta);           % field dependent factor
m                    = 1+(C_MOS/C_ox);                                   % body_factor
Qinv                 = C_ox*(m*kBT).*log(1+exp((VGMOS-Vth)/kBT./m));      % inversion charge to calculate current (Coul/cm^2)
ID                   = Qinv*vx0*Fs*1e-4;                                  % drain current (A/um)

%% ��ͳMOSFET
semilogy(VGMOS,ID,'-b','linewidth',2.0); hold on
text(0.5,5e-4,'�޸�����','Fontsize',12);

VGMOS2              = VGMOS(ID>=ID2);
VGMOS1              = VGMOS(ID>=ID1);
plot(VGMOS2(1),ID2,'-or','markersize',8.0,'linewidth',2.0); hold on
plot(VGMOS1(1),ID1,'-or','markersize',8.0,'linewidth',2.0); hold on
SS_MOS              = (VGMOS2(1)-VGMOS1(1))/log10(ID2/ID1)*1000   
% hold off
%% ������ֵ�����ݺ�
C_FU       = -3e-6;                     % �����ĸ�����
VGFU = (1+C_MOS/C_FU).*VGMOS;         
semilogy(VGFU,ID,'-b','linewidth',2.0); hold on
text(0.15,0.001,'�и�����','Fontsize',12);
title('���޸����ݶԱ�');

VGFU2            = VGFU(ID>=ID2);
VGFU1            = VGFU(ID>=ID1);
plot(VGFU2(1),ID2,'-or','markersize',8.0,'linewidth',2.0); hold on
plot(VGFU1(1),ID1,'-or','markersize',8.0,'linewidth',2.0); hold on
SS_FU            = (VGFU2(1)-VGFU1(1))/log10(ID2/ID1)*1000 

%% ͼƬ����

set(gca,'linewidth',1.5,'fontname','Helvetica','Fontsize',15,'ticklength',[0.015 0.015],'PlotBoxAspectRatio',[1 1 1]);
xlabel('V_{G} [V]'); ylabel('I_{DS} [A]'); axis([-0. 0.8 3e-7 1e-2]);
set(gca, 'XTick',[0.2:0.2:0.8]); set(gca, 'YTick',[1e-7 1e-6 1e-5 1e-4 1e-3 1e-2]);