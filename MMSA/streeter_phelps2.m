function [ ydot ] = streeter_phelps2( x,y )
% STREETER_PHELPS2 Describes the phenomenon of dissolved oxygen decreasing
% with downstream distance due to degradation of soluble organic
% biochemical oxygen demand (BOD) in rivers

% Set of State Variables:
% y(1)=L
% y(2)=N
% y(3)=D
% ydot(1)=dL/dx
% ydot(2)=dN/dx
% ydot(3)=dD/dx

global ka kd kr kn u R P S H

% Modifications to the Streeter-Phelps Equation:
% dL/dx = -kr*L/u;
% dN/dx = -kn*N/u;
% dD/dx = (-ka*D + kd*L + kn*N + S/H + (R-P))/u;

ydot(1,:) = -kr*y(1)/u;
ydot(2,:) = -kn*y(2)/u;
ydot(3,:) = (-ka*y(3) + kd*y(1) + kn*y(2) + S/H + (R-P))/u;
end