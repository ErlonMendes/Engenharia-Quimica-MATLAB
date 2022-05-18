% Resolve o Exemplo 4.7 (FOGLER, 1999)
clear % Limpa as vari�veis presentes no Workspace
clc % Limpa os comandos presentes no Command Window
global kprime eps

ic = [0;1]; % Condi��es de contorno em W = 0 para X e y
wspan = [0 60]; % Varia��o de W a ser modelada

[W,x] = ode45('ex4_7',wspan,ic); % Resolve o sistema de ODE's

f = (1+eps.*x(:,1))./x(:,2);
rate = kprime.*((1-x(:,1))./(1+eps.*x(:,1))).*x(:,2);

figure
plot(W,x,W,f); % Constru��o do gr�fico de X e y vs W
title('Exemplo 4.7');xlabel('W(lb)');ylabel('X,y,f');legend('X','y','f');

figure
plot(W,rate);
title('Exemplo 4.7');xlabel('W(lb)');ylabel('rate');