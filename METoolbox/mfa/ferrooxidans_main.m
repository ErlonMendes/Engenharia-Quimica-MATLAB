% Metabolic Flux Analysis as a tool to Improve Genetic Modified Bacterium
% Fe oxidation Ana Carolina Feltrin, Hyan Dias and Erlon Mendes
clc
% Stoichiometric matrix of the proposed metabolic network with dimensions
% (i x j), where "i" is number of reactions (fluxes) and "j" is the number
% of metabolities:
model = xls2model('ModeloHOLD_original');
G = full(model.S)';

% Vector of rates of measured fluxes with dimensions (m x 1), where "m" is
% number of the measured fluxes:
vm = [0.99;27.27;6.85];

% Vector of relative positions of measured fluxes in the stoichiometric
% matrix, with dimensions (1 x m):
p = [1,47,55];

% Relative position of the unmeasured flux of interest for specific
% sensitivity analysis:
pcs = 51;

% Metabolic flux analysis:
[vc,R,rk,vmnew,vcnew,h,e,answ,C,accum,spec] = mfa(G,vm,p,pcs)