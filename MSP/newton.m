% Newton's method
clear
clc

syms x
fx = x^3 - x;
xk = 10;
%xk = -1/sqrt(5);

fprime = diff(fx,1);
err=1;
n = 0;
while err>=1e-5
    xkp1 = xk - subs(fx,xk)/subs(fprime,xk);
    err = double(abs(xkp1 - xk));
    xk = xkp1;
    n = n+1;
end
xk = double(xk)
n

x = linspace(-1.5,1.5);
y = subs(fx,x);

figure
hold on
plot(x,y)
plot(x,zeros(100,1),'k');
hold off
