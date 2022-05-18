clear
clc
global eps PT0
ci = [0 1];
wspan = [0 10000];

[W,x] = ode45('ex10_3b',wspan,ci);

figure
plot(W,x);
xlabel('W(kg)')
ylabel('X,y')
legend('X','y')

PH2=PT0*(1.5-x(:,1))./(1+eps*x(:,1)).*x(:,2);
PB=PT0*x(:,1)./(1+eps*x(:,1)).*x(:,2);
PT=PT0*(1-x(:,1))./(1+eps*x(:,1)).*x(:,2);

figure
plot(W,PH2,W,PB,W,PT);
xlabel('W(kg)')
ylabel('Pi(atm)')
legend('P_H_2','P_B','P_T')