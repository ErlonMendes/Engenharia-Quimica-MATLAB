clear
clc

ci = [10,10,0,0,0,0];
Vspan = [0 10];
[V,F] = ode45('ex6_8',Vspan,ci);

figure
plot(V,F);xlabel('Volume de Reator (dm^3)');ylabel('Vazão molar (mol*min^-^1)');legend('F_A','F_B','F_C','F_D','F_E','F_F');

v = 10;
C = F/v;

figure
plot(V,C);xlabel('Volume de Reator (dm^3)');ylabel('Concentração (mol*dm^-^3)');legend('C_A','C_B','C_C','C_D','C_E','C_F');