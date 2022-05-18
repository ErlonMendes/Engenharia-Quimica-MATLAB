% Resolve o problema 6-4 (Fogler, 1999)
clear
clc
ci = [5,0,5,0,0];
Vspan = [0 105];

[V,F] = ode45('P6_4d',Vspan,ci);

figure
plot(V,F);xlabel('V(ft^3)');ylabel('Vazões molares(lbmol*s^-^1)');legend('F_A','F_B','F_C','F_D','F_E');

Fa0 = 5; % lbmol*s^(-1)
X = (Fa0-F(end,1))/Fa0