% Metabolic Flux Analysis as a tool for the elucidation of the metabolism
% of neurotransmitter glutamate
%
% Aristotle Chatziioannou, Georgios Palaiologos, and Fragiskos N. Kolisisa.
% Metabolic Engineering 2003
clc
% Stoichiometric matrix of the proposed metabolic network with dimensions
% (i x j), where "i" is number of reactions (fluxes) and "j" is the number
% of metabolities:
G = [0     1  -0.5    -1     0     0     0     0     0     0     0     0     0
     0     0     0     0     0     0     0     0     1    -1     0     1     0
     0     0     0     0    -1     1     0     0    -1     0     0     0     0
     0     0     0     0     0     0     1     1     0     0     0    -1     0
     0     0     0     0     0     0     0    -1     0     1     0     0     0
     0     0     0     1     0     0     0     0     0     0     0     0    -1
     1     0     0     0     0    -1    -1     0     0     0     0     0     0
     0     0     0     0     0     0     0     0     0     0     0    -1    -1
     0     0     0     0     0     0     0     0     0     0    -1     1     0
     0     0     0     0     0     0     0     0     0    -1     1     0     0
     0    -1     0     0     1     0     0     0     0     0     0     0     1
     0     0     0     1     0     0     0     0     0     0     0     0     0
    -1     0     0     0     0     0     0     0     0     0     0     0     0
    -1     1     0    -1     0     0     0     0     0     0     0     0     0
     0     0  -0.5     0     0     0     0     1     0     0     1    -1     0
     0     0     1     0     0     0     0     0     0     0     0     0     0];
 
% Vector of rates of measured fluxes with dimensions (m x 1), where "m" is
% number of the measured fluxes:
%vm = [0.060; 0.018; 0.594; 0; 0.160; 0.0975]; % Non-stimulation
vm = [0.060; 0.018; 0.980; 0; 0.160; 0.0975]; % Stimulation

% Vector of relative positions of measured fluxes in the stoichiometric
% matrix, with dimensions (1 x m):
p = [11,12,13,14,15,16];

% Relative position of the unmeasured flux of interest for specific
% sensitivity analysis. If an unmeasured flux of interest doesn't exist,
% use pcs = []:
pcs = 10;

% Metabolic flux analysis:
[vc,R,rk,vmnew,vcnew,h,e,answ,C,accum,spec] = mfa(G,vm,p,pcs)