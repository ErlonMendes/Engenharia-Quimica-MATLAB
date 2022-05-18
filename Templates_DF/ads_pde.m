function [c,f,s] = ads_pde(x,t,u,DuDx)
global D v lambda k1 k2

R = 1+k1*k2*u/(k2+u)/(k2+u);

c = R;
f = D*DuDx;
s = -v*DuDx -lambda*R*u;
end
