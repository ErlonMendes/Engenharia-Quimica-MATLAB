clear
clc

ci = 0;
Wspan = [0 5];
[W,X] = ode45('P4_22a',Wspan,ci);

figure
plot(W,X);xlabel('W (kg)');ylabel('Conversão');

ya0 = 0.3333;
P0 = 5;
R = 0.082;
T0 = 170+273.15;
Ca0 = ya0*P0/(R*T0);

Ca = Ca0.*(1-X)./(1-0.6667*X);
Cb = 2*Ca0.*(1-X)./(1-0.6667*X);
Cc = Ca0*X./(1-0.6667*X);

figure
plot(W,Ca,W,Cb,W,Cc);xlabel('W (kg)');ylabel('Concentrações (mol/L)');legend('C_A','C_B','C_C');

ci = [0 1];
Wspan = [0 5];
[W,x] = ode45('P4_22b',Wspan,ci);

figure
plot(W,x);xlabel('W (kg)');ylabel('X,y');legend('X','y');

ya0 = 0.3333;
P0 = 5;
R = 0.082;
T0 = 170+273.15;
Ca0 = ya0*P0/(R*T0);

Ca = Ca0.*(1-x(:,1))./(1-0.6667*x(:,1)).*x(:,2);
Cb = 2*Ca0.*(1-x(:,1))./(1-0.6667*x(:,1)).*x(:,2);
Cc = Ca0*x(:,1)./(1-0.6667*x(:,1)).*x(:,2);

figure
plot(W,Ca,W,Cb,W,Cc);xlabel('W (kg)');ylabel('Concentrações (mol/L)');legend('C_A','C_B','C_C');

