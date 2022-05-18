% Metabolic Flux Analysis as a tool to Improve Genetic Modified Bacterium
% Hydrogen Production Daniela Muccillo, Erlon Mendes and Luismar Marques
% Porto
clc
% Stoichiometric matrix of the proposed metabolic network with dimensions
% (i x j), where "i" is number of reactions (fluxes) and "j" is the number
% of metabolities:
G = [ 2    0    0    0    0    0    0    0    0    0    0    0    0    0   -2    2    0    0    0
     -1    1    0    0    0    0    0    0    0    0    0    0    0    0    2   -2   -1    1    1
      0   -1   -1    1    0    0    0    0    0    0    0    0    0    0    0    0   -1    1    1
      0    0    1   -1    1    0    0    0    0    0    0    0    0    0    0    0    0    0    0
      0    0    0    0   -1    1    0    0    0    0    0    0    0    0    0    0    1   -1   -1
      0    0    0    0    0   -1    1    0    0    0    0    0    0    0    0    0    0    0    0
      0    0    0    0    0    0   -1    1    0    0    0    0    0    0    0    0    1   -1   -1
      0    0    1    0    0    0    0   -1    1    0    0    0    0    0   -1    1    0    0    0
      0    0    0    0    0    0    0    0   -1    0    0    0    0    0    1   -1    0    0    0
      0    0    1   -1    0    0    0    0    0    1    0    0    0    0    0    0    1   -1   -1
      0    0    0    0    0    0    0    0    0   -1    0    0    0    0    0    0    1   -1   -1
      0    0    1   -1    0    0    0    0    0    0    1    0    0    0   -1    1    0    0    0
      0    0    0    0    0    0    0    0    0    0   -1    0    0    0    1   -1    0    0    0
      0    0    0    0    0    0    0    0    0    0    0    1    0    0    0    0   -1    1    1
      0    0    0    0    0    0    0    0    0    0    0   -1    1    0   -1    1    0    0    0
      1    0    0    0    0    0    0    0    0    0    0    0   -1    0    0    0    0    0    0
      0    0    0    0    0    0    0    0    0    0    0    0    0    1    0    0    0    0    0
      0    0    0    0    0    0    0    0    0    0    0    0    0   -1    0    0    1   -1   -1
      0   -1    0    0    0    0    0    0    0    0    0    0    0    0    0    0    1   -1   -1
      0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    0    1   -1   -1];
 
% Vector of rates of measured fluxes with dimensions (m x 1), where "m" is
% number of the measured fluxes:
vm = [5.72; 10.2; 4.0; 0.29; 1.8; 0; 0; 0.81];%Glucose
%vm = [0.92; 6.1; 2.87; 0.1; 0.34; 4.9; 10.8; 0.08];%Glycerol

% Vector of relative positions of measured fluxes in the stoichiometric
% matrix, with dimensions (1 x m):
p = [1,3,9,11,13,14,18,19];

% Relative position of the unmeasured flux of interest for specific
% sensitivity analysis:
pcs = 20;

% Metabolic flux analysis:
[vc,R,rk,vmnew,vcnew,h,e,answ,C,accum,spec] = mfa(G,vm,p,pcs)