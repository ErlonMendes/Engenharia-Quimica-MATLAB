% Modela a condução pura em uma barra de aço
clear % Limpa as variáveis presentes no Workspace
clc % Limpa os comandos presentes no Command Window

x = linspace(0,100,50); % Cria a malha com os valores de x
t = linspace(0,1000,50); % Cria a malha com os valores de t

m = 0;
sol = pdepe(m,@cond_pde,@cond_ci,@cond_cc,x,t); % Resolve a PDE

T = sol(:,:,1);

figure % Construção do gráfico de T(°C) vs x e t
surf(t,x,T','EdgeColor','none')
xlabel('Tempo')
ylabel('Comprimento')
zlabel('Temperatura')
title('\alpha^2.\partial^2u/\partialx^2 = \partialu/\partialt, Solução Numérica')