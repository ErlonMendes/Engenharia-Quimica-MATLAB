% Resolve o Exemplo 6.3 (FOGLER, 1999)
clear % Limpa as vari�veis presentes no Workspace
clc % Limpa os comandos presentes no Command Window

ic = [1;0;0];
tspan = [0 10];

[tau,C] = ode45('ex6_3',tspan,ic); % Resolve o sistema de ODE's

figure
plot(tau,C); % Constru��o do gr�fico
title('Exemplo 6.3');xlabel('\tau');ylabel('Concentra��o');legend('C_A','C_B','C_C');