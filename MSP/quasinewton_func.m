function [xkp1,n] = quasinewton_func(fx,xq,xp)
%NEWTON_FUNC Summary of this function goes here
%   Detailed explanation goes here
fprime = diff(fx,1);
err = 1;
n = 1;
    while err>=1e-4
        xkp1 = xq - subs(fprime,xq)/((subs(fprime,xq)-subs(fprime,xp))/(xq-xp));
        err = abs(xkp1 - xq);
        xq = xkp1;
        n = n+1;
    end
end