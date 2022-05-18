function [ R,fp ] = metals_lakes2( pH )
% METALS_LAKES Steady-State Model for Metals in Lakes

tau = 10; % d
vs = 0.1; % m/d
H = 1; % m
M = 1*10^(-6); % kg*L^(-1)

ks = vs/H; % d^(-1)
Kd = 10^(-1)./10.^(-pH); % L*kg^(-1)
fp = (Kd.*M)./(1+Kd.*M);
R = (ks.*fp.*tau)./(1+ks.*fp.*tau);
