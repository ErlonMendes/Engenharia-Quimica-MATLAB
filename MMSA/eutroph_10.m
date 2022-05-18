function [dCdt] = eutroph_10(t,C)
%EUTROPH_10 Summary of this function goes here
%   Detailed explanation goes here
tau = 534;
k1 = 0.25;
kg = 0.0375;
ks = 0.024;
k0 = 0.14;
W1_V = 0.0268;
W2_V = 0.0856;

dCdt(1,:) = W1_V + k0*C(3) - kg*C(1)*C(2) - C(1)/tau;
dCdt(2,:) = kg*C(1)*C(2) - k1*C(2) - ks*C(2) - C(2)/tau;
dCdt(3,:) = k1*C(2) + W2_V - ks*C(3) - k0*C(3) - C(3)/tau;
end

