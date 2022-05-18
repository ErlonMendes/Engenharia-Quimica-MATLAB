function [dCdt] = polimerizacao_cadeia(t,C)
global k0 kp kt f
% I2 = C(1)
% M = C(2)
% dI2/dt = dCdt(1,:)
% dM/dt = dCdt(2,:)
dCdt(1,:) = -k0*C(1);
dCdt(2,:) = -kp*C(2)*sqrt(2*k0*C(1)*f/kt);
end

