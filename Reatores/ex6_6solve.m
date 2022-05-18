clear
clc

ci = [0.021,0.0105,0,0,0];
tauspan = [0 0.5];

[tau,C] = ode45('ex6_6',tauspan,ci);

figure
plot(tau,C);title('Exemplo 6.6 (Fogler, 1999)');xlabel('\tau (h)');ylabel('Concentrações (lbmol/ft^3)');legend('C_H','C_M','C_X','C_T','C_M_e');