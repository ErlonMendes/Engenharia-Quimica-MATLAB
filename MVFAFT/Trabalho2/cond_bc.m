function [pl,ql,pr,qr] = cond_bc(xl,Tl,xr,Tr,t)
global T1 T2
pl = Tl - T1;
ql = 0;
pr = Tr - T2;
qr = 0;
end