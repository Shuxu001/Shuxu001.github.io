% Negative capacitance (NC) FET model (Version 1.0.0) 
% The model can calculate the Q-V, C-V, and I-V characteristics of the conventional MOSFET and NC-FET
% Gate-source and gate-drain overlap and fringing capacitances and flat-band potential are considered in the model
% Corresponding input parameters: r_C=C_ov/C_ox and flat-band potential (Vfb)
% Coefficients of different ferroelectric dielectrics are provided
% There is a provision to include multi-layers gate NC dielectric stack

% Muhammad A. Wahab, Purdue University, 2015 (Advisor: Prof. Muhammad A. Alam)

clc; clear all; close all

%% Constants
 
eps_0      = 8.854e-14;                  % free space permittivity (F/cm)
eps_ox     = 3.9;                        % dielectric constant of oxide
eps_s      = 12;                         % dielectric constant of semiconductor
q          = 1.6e-19;                    % electron charge (Coulomb)
kB         = 1.38e-23;                   % Boltzmann constant (J/K)
T          = 300;                        % Temperature (K)
kBT        = kB*T/q;                     % (eV)

%% Applied biases

VS         = 0;                          % applied source bias (V); keep it always zero
VD         = 0.5;                        % applied drain bias (V)
VGMOS      = linspace(-2,2,1000);        % applied gate bias of MOSFET (V)

%% MOSFET parameters

L_g        = 50e-7;                      % gate length (cm)
EOT        = 0.7e-7;                     % equivalent gate oxide thickness (cm)
N_A        = 1e19;                       % doping density in substrate (1/cm^3)
Vth        = 0.34;                       % threshold voltage (V)
mu         = 295;                        % effective mobility of carrier (cm^2/Sec)
vx0        = 1.595e7;                    % saturation velocity of carrier (cm/sec)
beta       = 1.8;                        % saturation-transition-region fitting parameter
Vfb        = -0.0;                       % flat-band potential (V)

%% Oxide and overlap capacitances

C_ox       = eps_ox*eps_0/EOT;           % oxide capacitance (F/cm^2)
r_C        = 1/3;                        % ratio of overlap capacitance and oxide capacitance

%% Modification in EOT to include overlap capacitance with a contraint that on-state capacitance is defined by peak of ferroelectric

EOT        = (1+2*r_C)*EOT;              % final equivalent gate oxide thickness (cm)
C_ox       = eps_ox*eps_0/EOT;           % oxide capacitance (F/cm^2)
C_ov       = r_C*C_ox;                   % gate-source or gate-drain overlap capacitance (F/cm^2)

%% Negative capacitor parameters

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% NC Material                          alphaFE (cm/F)     betaFE (cm^5/F/Coul^2)     gammaFE (cm^9/F/Coul^4)    Ref  %%%
%%% BaTiO_3                                -5e8                -2.2250e18                  7.5e27                  [1]-[2]
%%% PZT (PbZr_{1-x}Ti_{x}O_3)              -2.25e9              1.3e18                     9.8333e25               [1]
%%% SBT (Sr_{0.8}Bi_{2.2}Ta_2O_9)          -3.25e9              9.375e18                     0                     [1]
%%% P(VDF-TrFE)                            -1.8e11              5.8e22                       0                     [3]-[5]
%%% HfSiO                                  -8.65e10             1.92e20                      0                     [6]

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tFE        = 11e-7;                      % thickness of ferroelectric (cm)
alphaFE    = -8.65e10;                   % coefficient of ferroelectric (cm/F)
betaFE     = 1.92e20;                    % coefficient of ferroelectric (cm^5/F/Coul^2)
gammaFE    = 0;                          % coefficient of ferroelectric (cm^9/F/Coul^4)

%% MOSFET gate capacitance (depletion)

VGMOS_dep  = VGMOS(VGMOS>=Vfb);          % gate bias to calculate depletion capacitance

% (q*N_A/2/eps_s)Wdep^2+(q*N_A/C_ox)Wdep+(Vfb-VGMOS_dep)=0;  ( chapter 16, eqs (16.14 and 16.17) of Ref [7] )
for ii = 1:length(VGMOS_dep)
       p             = [(q*N_A/2/(eps_s*eps_0))    (q*N_A/C_ox)    Vfb-VGMOS_dep(ii)];
       r             = roots(p);
       W_dep(ii)     = r(r>=0);
end

C_dep                = eps_0*eps_s./W_dep;                                % depletion capacitance (F/cm^2)

%% MOSFET gate capacitance (inversion)

mm                   = 1+(C_dep/C_ox);                                    % body_factor to calculate inversion capacitance
mm(mm>=4)            = 4;

Q_inv                = C_ox*(mm*kBT).*exp((VGMOS_dep-Vth)/kBT./mm);       % charge to calculate inversion capacitance (Coul/cm^2)
C_inv                = gradient(Q_inv,VGMOS_dep);                         % inversion capcitance (F/cm^2)

%% Total MOSFET gate capacitance 

C_S                  = C_dep+C_inv;                                       % semiconductor capacitance contributed by depletion and inversion (F/cm^2)
C_GMOS(VGMOS>=Vfb)   = C_S*C_ox./(C_S+C_ox);                              % gate capacitance in depletion and inversion (F/cm^2)
C_GMOS(VGMOS<Vfb)    = C_ox;                                              % gate capacitance in accumulation (F/cm^2)


%% MOSFET gate charge 

Q_GMOS               = cumtrapz(VGMOS,C_GMOS);                            % MOSFET gate charge (Coul/cm^2)
Q_GMOS               = Q_GMOS-Q_GMOS(VGMOS==VGMOS_dep(1));                % MOSFET gate charge is zero at zero gate bias

%% Inclusion of overlap capacitance effect

C_GMOSov             = C_GMOS+2*C_ov;                                     % gate capacitance including overlap capacitance (F/cm^2)
Q_GMOSov             = Q_GMOS+C_ov*(VGMOS-VS)+C_ov*(VGMOS-VD);            % gate charge including overlap capacitance effect (Coul/cm^2)

%% ID-VGS characteristics of conventional MOSFET [8]

VDSAT                = vx0*L_g/mu;                                        % drain bias for current saturation due to velocity saturation (V)
Fs                   = (VD/VDSAT)/(1+(VD/VDSAT)^beta)^(1/beta);           % field dependent factor

m                    = 1+(C_GMOS/C_ox);                                   % body_factor
Qinv                 = C_ox*(m*kBT).*log(1+exp((VGMOS-Vth)/kBT./m));      % inversion charge to calculate current (Coul/cm^2)

ID                   = Qinv*vx0*Fs*1e-4;                                  % drain current (A/um)


%% Negative capacitance (NC) FET

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% U                  = -alpha*Q^2/2+beta*Q^4/4+gamma*Q^6/6
% VFE                = -alpha*Q+beta*Q^3+gamma*Q^5
% CFE^(-1)           = -alpha+3*beta*Q^2+5*gamma*Q^4

% alpha              = -2*alphaFE*tFE
% beta               = 4*betaFE*tFE
% gamma              = 6*gammaFE*tFE

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

C_FEinv              = 2*alphaFE*tFE+12*betaFE*tFE*Q_GMOSov.^2+30*gammaFE*tFE*Q_GMOSov.^4;              % inverse capacitance of ferroelectric dielectric (cm^2/F)
VFE                  = 2*alphaFE*tFE*Q_GMOSov+4*betaFE*tFE*Q_GMOSov.^3+6*gammaFE*tFE*Q_GMOSov.^5;       % voltage across ferroelectric capacitor (V)

VGNC                 = VGMOS+VFE;                                                                       % voltage of the external gate (V)

% For multiple layers of dielectric stack VGN = VGM+VFE1+VFE2+.......

%% Total capacitance

C_T                  = gradient(Q_GMOSov,VGNC);                                                         % total gate capacitance of the dielectric stack (F/cm^2)

%% plots of simulated results

% C_GMOS vs VGMOS plot without overlap capacitance
figure(1)
plot(VGMOS,C_GMOS*1e6,'-r','markersize',12.0,'linewidth',3.0); hold on
set(gca,'linewidth',2.5,'fontname','Helvetica','Fontsize',22,'ticklength',[0.025 0.025],'PlotBoxAspectRatio',[1 0.85 1]);
xlabel('V_{GMOS} [V]'); ylabel('C_{GMOS} [\muF/cm^2]'); axis([-0.7 0.7 0 4]); grid on
set(gca, 'XTick',[-0.6:0.3:0.6]); set(gca, 'YTick',[0:1:4]);

% Q_GMOS vs VGMOS plot without overlap capacitance
figure(2)
plot(VGMOS,Q_GMOS*1e6,'-b','markersize',12.0,'linewidth',3.0); hold on
set(gca,'linewidth',2.5,'fontname','Helvetica','Fontsize',22,'ticklength',[0.025 0.025],'PlotBoxAspectRatio',[1 0.85 1]);
xlabel('V_{GMOS} [V]'); ylabel('Q_{GMOS} [\muC/cm^2]'); axis([0 0.7 0 2.5]); grid on
set(gca, 'XTick',[0:0.2:0.6]); set(gca, 'YTick',[0:0.5:2.5]);

% Different components of inverse capacitance vs Q_GMOSov plot 
figure(3)
plot(Q_GMOSov*1e6,1./(C_GMOSov*1e6),'-k','markersize',12.0,'linewidth',3.0); hold on
plot(Q_GMOSov*1e6,-C_FEinv/1e6,'-r','markersize',12.0,'linewidth',3.0); hold on
plot(Q_GMOSov*1e6,1./(C_T*1e6),'-b','markersize',12.0,'linewidth',3.0); hold on
set(gca,'linewidth',2.5,'fontname','Helvetica','Fontsize',22,'ticklength',[0.025 0.025],'PlotBoxAspectRatio',[1 0.85 1]);
xlabel('Q_{GMOS} [\muC/cm^2]'); ylabel('C^{-1} [cm^2/\muF]'); axis([-4 4 0 0.6]); %grid on
set(gca, 'XTick',[-4:1:4]); set(gca, 'YTick',[0:0.1:0.6]);
AX=legend('1/C_{GMOSov}','1/C_{FE}','1/C_T','Location','NorthWest'); legend('BOXOFF');
LEG = findobj(AX,'type','text'); set(LEG,'FontSize',16);

% Different components of voltage plot 
figure(4)
plot(VGNC,VGMOS,'-k','markersize',12.0,'linewidth',3.0); hold on
plot(VGNC,VGNC,'-b','markersize',12.0,'linewidth',3.0); hold on
plot(VGNC,VFE,'-r','markersize',12.0,'linewidth',3.0); hold on
set(gca,'linewidth',2.5,'fontname','Helvetica','Fontsize',22,'ticklength',[0.025 0.025],'PlotBoxAspectRatio',[1 0.85 1]);
xlabel('V_{GNC} [V]'); ylabel('V [V]'); axis([0 0.7 -1.2 1.7]); %grid on; 
set(gca, 'XTick',[0:0.2:0.6]); set(gca, 'YTick',[-1:0.5:1.5]);
AX=legend('V_{GMOS}','V_{GNC}','V_{FE}','Location','NorthWest'); legend('BOXOFF');
LEG = findobj(AX,'type','text'); set(LEG,'FontSize',16);

% ID-VGN characteristics
figure(5)
semilogy(VGNC,ID,'-b','markersize',12.0,'linewidth',3.0); hold on
set(gca,'linewidth',2.5,'fontname','Helvetica','Fontsize',22,'ticklength',[0.025 0.025],'PlotBoxAspectRatio',[1 0.85 1]);
xlabel('V_{GNC} [V]'); ylabel('I_{DS} [A/\mum]'); axis([0 0.7 3e-7 1e-2]);
set(gca, 'XTick',[0:0.2:0.8]); set(gca, 'YTick',[1e-7 1e-6 1e-5 1e-4 1e-3 1e-2]);

%% Calculation of sub-threshold slope (S)
ID2              = 1e-4;                                           % drain current (A/um)
ID1              = 1e-6;                                           % drain current (A/um)

VGNC2            = VGNC(ID>=ID2);
VGNC1            = VGNC(ID>=ID1);

plot(VGNC2(1),ID2,'-dr','markersize',12.0,'linewidth',3.0); hold on
plot(VGNC1(1),ID1,'-dr','markersize',12.0,'linewidth',3.0); hold on

S                = (VGNC2(1)-VGNC1(1))/log10(ID2/ID1)*1000         % sub-threshold slope (mV/dec)


% For a broad general introduction to Phase Transition and Landau Switching, see  https://sites.google.com/site/ece670landauelectronics/home. 
% The following references are specific for the code above. 

% [1] A. Jain and M. A. Alam, “Stability Constraints Define the Minimum Subthreshold Swing of a Negative Capacitance Field-Effect 
% Transistor,?IEEE Trans. Electron Devices, vol. 61, no. 7, pp. 2235?242, Jul. 2014.

% [2] S. Salahuddin and S. Datta, “Use of negative capacitance to provide voltage amplification for low power nanoscale devices.,?
% Nano Lett., vol. 8, no. 2, pp. 405?0, Feb. 2008.

% [3] M. A. Wahab and M. A. Alam, “Compact Model of Short-Channel Negative Capacitance (NC)-FET with BSIM4/MVS and Landau Theory,?
% in NEEDS Annual Meeting and Workshop, May 11-12, 2015, Cambridge, MA, USA.

% [4] M. A. Wahab and M. A. Alam, "A Verilog-A Compact Model for Negative Capacitance FET," NEEDS NanoHUB, 2015.

% [5] Y. Li, Y. Lian, K. Yao, and G. S. Samudra, “Evaluation and optimization of short channel ferroelectric MOSFET for low power 
% circuit application with BSIM4 and Landau theory,?Solid. State. Electron., vol. 114, pp. 17?2, Dec. 2015.

% [6] T. S. Böscke, J. Müller, D. Bräuhaus, U. Schröder, and U. Böttger. "Ferroelectricity in hafnium oxide: CMOS compatible 
% ferroelectric field effect transistors." In Electron Devices Meeting (IEDM), 2011 IEEE International, pp. 24-5. IEEE, 2011.

% [7] R. F. Pierret, "Semiconductor device fundamentals. Reading, MA: Addison-Wesley," 1996.

% [8] A. Khakifirooz, O. M. Nayfeh, and D. A. Antoniadis, "A Simple Semiempirical Short-Channel MOSFET Current-Voltage
% Model Continuous Across All Regions of Operation and Employing Only Physical Parameters," IEEE Trans. Electron Dev., 
% vol. 56, pp. 1674-1680, 2009.

% [9] A. Jain and M. A. Alam, “Proposal of a Hysteresis-Free Zero Subthreshold Swing Field-Effect Transistor,?IEEE Trans. Electron 
% Devices, vol. 61, no. 10, pp. 3546?552, Oct. 2014.
