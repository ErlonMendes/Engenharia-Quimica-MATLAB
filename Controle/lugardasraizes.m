clear
clc
% Exemplo 8-2.1
% 1 + Kc/((3*s+1)*(s+1)) = 0
num = [1];
den1 = [3 1];
den2 = [1 1];
% Combinação dos denominadores
den3 = conv(den1,den2);

figure
rlocus(num,den3)

clear
% Exemplo 8-2.2
% 1 + Kc/((3*s+1)*(s+1)*(0.5*s+1)) = 0
num = [1];
den1 = [3 1];
den2 = [1 1];
den3 = [0.5 1];
% Combinação dos denominadores
den4 = conv(den1,den2);
den5 = conv(den4,den3);

figure
rlocus(num,den5)

clear
% Exemplo 8-3.1
% 1 + Kc*(6*s+1)/(6*s*(3*s+1)*(s+1)*(0.5*s+1)) = 0
num = [6 1];
den1 = [6 0];
den2 = [3 1];
den3 = [1 1];
den4 = [0.5 1];
% Combinação dos denominadores
den5 = conv(den1,den2);
den6 = conv(den5,den3);
den7 = conv(den6,den4);

figure
rlocus(num,den7)