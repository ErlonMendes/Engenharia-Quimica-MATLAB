% Polimerização em cadeia em reator batelada
clear
clc

global k0 kp kt f

k0 = 1.4e-3;
kp = 4.4e2;
ka = 1.2e8;
kd = 0;
kt = ka+kd;
f = 0.7;
M0 = 3;
I0 = [1,0.1,0.01,0.001,0.0001,0.00001];

% Solução Numérica:
tspan = linspace(0,2*3600,1000);
for i = 1:6
    ci = [I0(i),M0];
    [t,C] = ode45('polimerizacao_cadeia',tspan,ci);
    Cn(:,i) = C(:,2);
end

figure
plot(t/3600,Cn)
title('Solução Numérica')
xlabel('t (h)')
ylabel('M (mol/dm^3)')
legend(['I0 = ' num2str(I0(1)) ' M'],['I0 = ' num2str(I0(2))  ' M'],['I0 = ' num2str(I0(3))  ' M'],['I0 = ' num2str(I0(4))  ' M'],['I0 = ' num2str(I0(5))  ' M'],['I0 = ' num2str(I0(6))  ' M'])

% Solução Analítica:
for i =1:6
    Ca(:,i) = M0*exp((8*kp^2*f*I0(i)/(k0*kt))^(1/2)*(exp(-k0*t/2)-1));
end

figure
plot(t/3600,Ca)
title('Solução Analítica')
xlabel('t (h)')
ylabel('M (mol/dm^3)')
legend(['I0 = ' num2str(I0(1)) ' M'],['I0 = ' num2str(I0(2))  ' M'],['I0 = ' num2str(I0(3))  ' M'],['I0 = ' num2str(I0(4))  ' M'],['I0 = ' num2str(I0(5))  ' M'],['I0 = ' num2str(I0(6))  ' M'])
