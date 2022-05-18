function [xkp1,n] = findiffnewton_func(fx,xk,h)
%FINDIFFNEWTON_FUNC Summary of this function goes here
%   Detailed explanation goes here
err = 1;
n = 1;
    while err>=1e-6
        xkp1 = xk - h/2*(subs(fx,xk+h)-subs(fx,xk-h))/(subs(fx,xk+h)-2*subs(fx,xk)+subs(fx,xk-h));
        err = abs(xkp1 - xk);
        xk = xkp1;
        n = n+1;
    end
end