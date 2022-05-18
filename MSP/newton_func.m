function [xkp1,n] = newton_func(fx,xk)
%NEWTON_FUNC Summary of this function goes here
%   Detailed explanation goes here
fprime = diff(fx,1);
f2prime = diff(fx,2);
err=1;
n = 1;
    while err>=1e-10
        xkp1 = xk - subs(fprime,xk)/subs(f2prime,xk);
        err = abs(xkp1 - xk);
        xk = xkp1;
        n = n+1;
    end
end