clear
clc

Vspan = [0 3000];
ci = [3,2.5,0,0,0,0];

[V,F] = ode45('ex6_5',Vspan,ci);

figure
plot(V,F);xlabel('V(dm^3)');ylabel('F(mol/s)');legend('Fno','Fnh3','Fh2o','Fn2','Fo2','Fno2');