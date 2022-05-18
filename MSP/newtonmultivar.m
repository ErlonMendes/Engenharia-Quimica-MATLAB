% Newton's method for multivariable problems
clear
clc

syms x1 x2
f1 = x1 - 4*x1^2 - x1*x2;
f2 = 2*x2 - x2^2 + 3*x1*x2;

xk = [-1
      -1];

J11 = diff(f1,1,x1);
J12 = diff(f1,1,x2);
J21 = diff(f2,1,x1);
J22 = diff(f2,1,x2);


err=1;
n = 0;
while err>=1e-5
    Jxk = [subs(J11,{x1,x2},[xk(1),xk(2)]) subs(J12,{x1,x2},[xk(1),xk(2)])
           subs(J21,{x1,x2},[xk(1),xk(2)]) subs(J22,{x1,x2},[xk(1),xk(2)])];

    fxk = [subs(f1,{x1,x2},[xk(1),xk(2)])
           subs(f2,{x1,x2},[xk(1),xk(2)])];

    xkp1 = xk - Jxk\fxk;
    err = double(abs(xkp1 - xk));
    xk = xkp1;
    n = n+1;
end
xk = double(xk)
n
