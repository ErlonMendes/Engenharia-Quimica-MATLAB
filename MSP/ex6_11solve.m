% Resolve o Exemplo 6.11 (CONSTANTINIDES, 2000)
clear % Limpa as variáveis presentes no Workspace
clc % Limpa os comandos presentes no Command Window

R = 0.27/2; % m
a = 19e-3/2; % m
r = linspace(a,R,50); % Cria a malha com os valores de r
t = linspace(0,400,50); % Cria a malha com os valores de t

m = 1;
sol = pdepe(m,@ex6_11pde,@ex6_11ci,@ex6_11cc,r,t); % Resolve a PDE

C = sol(:,:,1);

figure % Construção do gráfico de C(%) vs r(m) e t(s)
surf(r,t,C,'FaceColor','interp','EdgeColor','none','FaceLighting','phong')
colorbar;title('Concentração, C(%)');xlabel('Raio r(m)');ylabel('Tempo t(s)');