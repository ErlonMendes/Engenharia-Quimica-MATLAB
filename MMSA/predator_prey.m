function [ dxdt ] = predator_prey( t,x )
%PREDATOR_PREY Modelo predador-presa
%   x(1) = x
%   x(2) = y
%   dxdt(1,:) = dx/dt
%   dxdt(2,:) = dy/dt

k1 = 0.02; % dia^-1
k2 = 0.00004; % dia^-1*nº de raposas^-1
k3 = 0.00004; % dia^-1*nº de coelhos^-1
k4 = 0.04; % dia^-1

dxdt(1,:) = k1*x(1) - k2*x(1)*x(2);
dxdt(2,:) = k3*x(1)*x(2) - k4*x(2);
end

