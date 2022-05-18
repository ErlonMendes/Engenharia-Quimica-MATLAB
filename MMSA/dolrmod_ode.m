function [ dydx ] = dolrmod_ode( x,y )
% DO_LARGE_RIVERS_ODE Describes the phenomenon of dissolved oxygen
% decreasing with upstream and downstream distance due to degradation of
% soluble organic biochemical oxygen demand (BOD) in large rivers

global E u ka kd kr kn

dydx(1,:) = y(2);
dydx(2,:) = (u*y(2) + kr*y(1))/E;
dydx(3,:) = y(4);
dydx(4,:) = (u*y(4) + kn*y(3))/E;
dydx(5,:) = y(6);
dydx(6,:) = (u*y(6) + ka*y(5) - kd*y(1) - kn*y(3))/E;
end