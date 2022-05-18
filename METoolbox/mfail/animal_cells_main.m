clc
% Stoichiometric matrix of the proposed metabolic network with dimensions
% (i x j), where "i" is number of reactions (fluxes) and "j" is the number
% of metabolities:
G = [ 1  0  0  0  0  0  0
     -1  0  0  0  0  0  0
     -1  0  0  0  0  0  0
     -1  1  0  0  0 -1  0
      0 -1  1  0  0  0  0
      0  0  1  0  0  0  0
      0  0 -1  1  0  0  0
      0  0  0 -1  1  0  1
      0  0  0 -1  1  0 -1
      0  0  0  0 -1  1  0
      1  0  0  0 -1  0  0
      0  0  0  0  0 -1  0
      0  0 -1  0  0  0  0];

% Vector of rates of measured fluxes with dimensions (m x 1), where "m" is
% number of the measured fluxes:
vm = [100;15;80;40;5;10];

% Vector of relative positions of measured fluxes in the stoichiometric
% matrix, with dimensions (1 x m):
p = [1,2,3,6,12,13];

% Metabolic flux analysis:
[vc,answ,xpyr,xicit,xakg,xsuc,xmal,xoaa] = mfail(G,vm,p)