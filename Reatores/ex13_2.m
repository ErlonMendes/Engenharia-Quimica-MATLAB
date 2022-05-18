clear
clc
t = [0 1 2 3 4 5 6 7 8 9 10 12 14];
C = [0 1 5 8 10 8 6 4 3 2.2 1.5 0.6 0];
Cfit = fit(t',C','smoothingspline');

figure
plot(Cfit,t,C,'o');xlabel('t(min)');ylabel('C(g/m^3)');

intC = trapz(t,C);
E = C/intC;
Efit = fit(t',E','smoothingspline');

figure
plot(Efit,t,E,'o');xlabel('t(min)');ylabel('E(min^-^1)');
tm = trapz(t,t.*E)
% A compara��o do tempo de resid�ncia m�dio, tm, com o tempo de passagem
% no sistema, tau, permite verificar se o escoamento � ideal
% (quando tau = tm), ou identificar o tipo de desvio ao escoamento ideal.
% Se tau < tm, h� predomin�ncia de curto-circuito, se tau > tm, acontece a
% forma��o de zonas mortas.
