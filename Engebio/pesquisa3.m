function [ dxdt ] = pesquisa3( t,x )
%PESQUISA Summary of this function goes here
%BATH_REACTOR
% x(1) = X
% x(2) = S
% x(3) = P
% dxdt(1,:) = dXdt
% dxdt(2,:) = dSdt
% dxdt(3,:) = dPdt

um = 0.0422;
Ks = 0.15;
Yxs = 1.8412;
Yxp1 = 0.9602;
Yxp2 = 0.18;

% u = um*S/(Ks+S);

% dXdt = um*S/(Ks+S)*X;
% dSdt = -(1/Yxs)*um*S/(Ks+S)*X;
% dP1dt = (1/Yxp1)*um*S/(Ks+S)*X;
% dP2dt = (1/Yxp2)*um*S/(Ks+S)*X;

u = um*x(2)/(Ks+x(2));

dxdt(1,:) = u*x(1);
dxdt(2,:) = -(1/Yxs)*u*x(1);
dxdt(3,:) = (1/Yxp1)*u*x(1);
dxdt(4,:) = (1/Yxp2)*u*x(1);
end