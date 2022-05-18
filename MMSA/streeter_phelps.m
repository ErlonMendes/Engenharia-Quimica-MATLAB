function [ ydot ] = streeter_phelps( x,y )
% STREETER_PHELPS Describes the phenomenon of dissolved oxygen decreasing
% with downstream distance due to degradation of soluble organic
% biochemical oxygen demand (BOD) in rivers

% Set of State Variables:
% y(1)=L
% y(2)=D
% ydot(1)=dL/dx
% ydot(2)=dD/dx

global ka kd u

% Set of Differential Equations:
% dL/dx = -kd*L/u;
% dD/dx = (kd*L - ka*D)/u;

% Modifications to the Streeter-Phelps Equation (see Streeter_Phelps2):
% dL/dx = -kr*L/u;
% dN/dx = -kn*N/u;
% dD/dx = (-ka*D + kd*L + kn*N + S/H + (R-P))/u;

ydot(1,:) = -kd*y(1)/u;
ydot(2,:) = (kd*y(1) - ka*y(2))/u;
end