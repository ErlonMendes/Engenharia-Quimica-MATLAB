% Resolve o Exemplo 6.3 (FOGLER, 1999)
clear % Limpa as variáveis presentes no Workspace
clc % Limpa os comandos presentes no Command Window

ic = [1;0;0];
tspan = [0 10];

[tau,C] = ode45('ex6_3',tspan,ic); % Resolve o sistema de ODE's

figure
plot(tau,C); % Construção do gráfico
title('Exemplo 6.3');xlabel('\tau');ylabel('Concentração');legend('C_A','C_B','C_C');