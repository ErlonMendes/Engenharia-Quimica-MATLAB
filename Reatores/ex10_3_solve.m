clear
clc
global PT0 alpha
ci = 0;
wspan = [0 10000];

[w,x] = ode45('ex10_3',wspan,ci);

y=(1-alpha.*w).^0.5;

PH2=PT0*(1.5-x).*y;
PB=PT0*x.*y;
PT=PT0*(1-x).*y;

figure
plot(w,x,w,y);

figure
plot(w,PH2,w,PB,w,PT);