function [dCdt] = metano_ode(t,C)
global f
% C(1) = S
% C(2) = X
% C(3) = M
k = 4.0;
Ks = 9.5;
Y = 0.04;
b = 0.032;
Kr = 6.0;
Ar = 0.01;
Kp = 1.0;

dCdt(1,:) = -(k*C(1)*C(2)/(Ks+C(1))) + Kr*Ar*f;
dCdt(2,:) = -Y*(k*C(1)*C(2)/(Ks+C(1))) - b*C(2);
dCdt(3,:) = (k*C(1)*C(2)/(Ks+C(1)))*(1-Y+0.8*b*(Ks+C(1)))/(k*C(1))*16/59 - Kp*C(3)*Ar;
end

