% Resolve o Exemplo 4.7 (FOGLER, 1999)
clear % Limpa as variáveis presentes no Workspace
clc % Limpa os comandos presentes no Command Window
close all

global k Pa0 Fa0 thetab vb eps alpha

% Parâmetros cinéticos:
k = 0.0141; % lbmol/(atm*lbm cat*h)

% Propriedades do fluido:
mi = 0.0673; % lbm/(ft*h)
ro0 = 0.413; % lbm/ft^3

% Alimentação e configuração:
P0 = 10; % atm
Fa0 = 1.08; % lbmol/h
Fb0 = 0.54; % lbmol/h
Fi0 = Fb0*0.79/0.21; % lbmol/h
Ft0 = Fa0+Fb0+Fi0;
ya0 = Fa0/Ft0;
delta = 1-1/2-1;
eps = ya0*delta;
thetab = Fb0/Fa0;
vb = 1/2;
Pa0 = ya0*P0;
ma0 = Fa0*28; % lbm/h
mb0 = Fb0*32; % lbm/h
mi0 = Fi0*28; % lbm/h
m = ma0+mb0+mi0; % lbm/h
Ac = 0.01414; % ft^2
fi = 0.45; % porosidade do leito

% Propriedades do catalisador:
Dp = 0.0208; % ft
roc = 120; % lbm/ft^3

G = m/Ac; % lbm/(ft^2*h)
gc = 4.17e8; % lbm*ft/(lbf*h^2)
beta0 = G*(1-fi)/(gc*ro0*Dp*fi^3)*(150*(1-fi)*mi/Dp + 1.75*G)/144/14.7; % atm/ft
alpha = 2*beta0/(Ac*(1-fi)*roc*P0); % 1/lbm cat

ic = [0;1]; % Condições de contorno em W = 0 para X e y
wspan = [0 60]; % Variação de W a ser modelada

[W,x] = ode45('PBRperdadecarga',wspan,ic); % Resolve o sistema de ODE's

figure
plot(W,x); % Construção do gráfico de X e y vs W
xlabel('W (lb_m)');ylabel('X,y');legend('X','y');
