clear
clc

T = linspace(323,400);
W = 80;
Fa0 = 5.42;
Ca0 = 0.217;
T0 = 450;

for i = 1:100
    syms X
    Tmb = T(i);
    eq1 = Fa0*X/(0.133*exp(3776.8*(1/450-1/Tmb))*Ca0*(1-X)/(1+X)*T0/Tmb)-W;
    solX = solve(eq1);
    Xmb(i) = double(solX(2));
end

Xeb = (40*(T-450) - 500/5.42*(323-T))/20e3;

figure
plot(T,Xmb,T,Xeb)
xlabel('T(K)')
ylabel('X')
legend('Xmb','Xeb')