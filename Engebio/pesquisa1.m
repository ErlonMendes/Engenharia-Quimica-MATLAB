function [ dxdt ] = pesquisa1( t,x )
%PESQUISA Summary of this function goes here
%BATH_REACTOR
% x(1) = X
% x(2) = S
% x(3) = P1
% x(4) = P2
% dxdt(1,:) = dXdt
% dxdt(2,:) = dSdt
% dxdt(3,:) = dP1dt
% dxdt(4,:) = dP2dt

um = 0.093;
Ks = 8;
Yxs = 0.1006;
Yp1s = 0.041;
Yp2s = 0.0161;
Yxp1 = Yxs/Yp1s;
Yxp2 = Yxs/Yp2s;

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