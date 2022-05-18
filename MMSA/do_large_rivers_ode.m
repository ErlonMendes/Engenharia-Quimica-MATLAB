function [ dydx ] = do_large_rivers_ode( x,y )
% DO_LARGE_RIVERS_ODE Describes the phenomenon of dissolved oxygen
% decreasing with upstream and downstream distance due to degradation of
% soluble organic biochemical oxygen demand (BOD) in large rivers

global E kd u ka

% Mass Balance Equation to Ultimate BOD Concentration:
% E*d2L/dx2 - u*dL/dx - kd*L = 0

% Transformation to Canonical Form:
% L = y(1)
% dL/dx = y(2)
% d2L/dx2 = (u*y(2) + kd*y(1))/E

% Mass Balance Equation to DO Deficit:
% E*d2D/dx2 - u*dD/dx - ka*D + kd*L = 0

% Transformation to Canonical Form:
% D = y(3)
% dD/dx = y(4)
% d2D/dx2 = (u*y(4) + ka*y(3) - kd*y(1))/E

dydx = [y(2)
        (u*y(2) + kd*y(1))/E
        y(4)
        (u*y(4) + ka*y(3) - kd*y(1))/E];
end