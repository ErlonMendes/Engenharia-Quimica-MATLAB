function [pl,ql,pr,qr] = ads_cc(xl,Cl,xr,Cr,t)
global Cin v
pl = Cl-Cin;
ql = 0;
pr = v*Cr;
qr = 1;
end