clear
clc

% Pêndulo Invertido sem Controlador (Controle de Sistemas Dinâmicos p. 149)
% 1 + 1/((s+1)*(s-1)) = 0
num = [1];
den1 = [1 1];
den2 = [1 -1];
% Combinação dos denominadores
den3 = conv(den1,den2);

figure
rlocus(num,den3)

clear
% Pêndulo Invertido com Controlador (Controle de Sistemas Dinâmicos p. 149)
% 1 + Kc*(s+gama)/((s+1)*(s-1)*(s+delta)) = 0
Kc = 2;
gama = -1;
delta = 2;
num = [Kc Kc*gama];
den1 = [1 1];
den2 = [1 -1];
den3 = [1 delta];
% Combinação dos denominadores
den4 = conv(den1,den2);
den5 = conv(den4,den3);

figure
rlocus(num,den5)

clear
% Pêndulo Invertido com Controlador (Controle de Sistemas Dinâmicos p. 149)
% 1 + (s-1)/((s+1)*(s-1)*(s+delta)) = 0
delta = 1;
num = [1];
den1 = [1 1];
den2 = [1 delta];
% Combinação dos denominadores
den3 = conv(den1,den2);

figure
rlocus(num,den3)