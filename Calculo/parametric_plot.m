clear
clc

% Exemplo 1 p. 171
figure
ezplot3('2*cos(t)','2*sin(t)','t',[0,9*pi/2])

% Exemplo 2 p. 172
figure
ezplot3('2*cos(t)','2*sin(t)','3',[0,2*pi])

% Exemplo 3 p. 172
figure
ezplot3('t','2*t','9-5*t^2',[-1,1])

% Exemplo 4 p. 173
figure
ezplot('cos(2*t)','sin(t)',[0,2*pi])

% Exemplo 5 p. 174
figure
hold on
ezplot3('t^2','t^2-t','-7*t',[-4,4])
ezplot3('9+6*t','6+5*t','-21-7*t',[-4,4])
hold off