clear
clc

% Newton's method
syms x
fx = x^4 - x + 1;
xk = 3;
[xkp1,n] = newton_func(fx,xk)

% Finite difference Newton method
syms x
fx = x^4 - x + 1;
xk = 3;
h = 1e-4;
[xkp1,n] = findiffnewton_func(fx,xk,h)

% Quasi-Newton method
syms x
fx = x^4 - x + 1;
xq = 3;
xp = -3;
[xkp1,n] = quasinewton_func(fx,xq,xp)
