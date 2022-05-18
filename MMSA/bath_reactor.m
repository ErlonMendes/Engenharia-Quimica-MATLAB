function [ dxdt ] = bath_reactor( t,x )
%BATH_REACTOR
% x(1) = X
% x(2) = S
% x(3) = P
% dxdt(1,:) = dXdt
% dxdt(2,:) = dSdt
% dxdt(3,:) = dPdt

um = 0.15;
Ks = 1.25;
Yxs = 0.14;
Yps = 0.85;
Yxp = Yxs/Yps;

% u = um*S/(Ks+S);

% dXdt = um*S/(Ks+S)*X;
% dSdt = -(1/Yxs)*um*S/(Ks+S)*X;
% dPdt = (1/Yxp)*um*S/(Ks+S)*X

u = um*x(2)/(Ks+x(2));

dxdt(1,:) = u*x(1);
dxdt(2,:) = -(1/Yxs)*u*x(1);
dxdt(3,:) = (1/Yxp)*u*x(1);
end