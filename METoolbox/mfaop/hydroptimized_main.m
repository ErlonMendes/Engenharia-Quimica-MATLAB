% Optimized Metabolic Flux Analysis

% Stoichiometric matrix of the proposed metabolic network with dimensions
% (i x j), where "i" is number of reactions (fluxes) and "j" is the number
% of metabolities:

% Ex_glc	    glc[c]  <=>
% Ex_glyc	    glyc[c]  <=>
% Ex_atp	    adp[c]  <=>
% Ex_nad	    nad[c]  <=>
% Ex_hyd	    h2[c]  <=>
% Ex_lac	    lac[c]  <=>
% Ex_ac	        ac[c]  <=>
% Ex_etoh	    etoh[c]  <=>
% Ex_bu	        bu[c]  <=>
% Ex_acetone	acetone[c]  <=>
% Ex_buoh	    buoh[c]  <=>
% vglc	        glc[c] + 2 atp[c]  -> 2 adp[c] + 2 ga3p[c]
% vglyc	        glyc[c] + nad[c] + atp[c]  -> nadh[c] + adp[c] + ga3p[c]
% vpyr	        ga3p[c] + 2 adp[c] + nad[c]  -> pyr[c] + 2 atp[c] + nadh[c]
% vpdh	        pyr[c] + fdox[c] + coa[c]  -> accoa[c] + fdred[c]
% vnadh	        fdox[c] + nadh[c]   <=> fdred[c] + nad[c]
% vhyd	        fdred[c]  -> fdox[c] + h2[c]
% vlac	        pyr[c] + nadh[c]   -> nad[c] + lac[c]
% vthi	        2 accoa[c]  -> coa[c] + actaccoa[c]
% vac	        accoa[c] + adp[c]   <=> atp[c] + coa[c] + ac[c]
% vetoh         accoa[c] + 2 nadh[c]  -> coa[c] + 2 nad[c] + etoh[c]
% vacetone1     ac[c] + actaccoa[c]  -> accoa[c] + acetone[c]
% vacetone2	    bu[c] + actaccoa[c]  -> bucoa[c] + acetone[c]
% vhcoa	        actaccoa[c] + 2 nadh[c]  -> bucoa[c] + 2 nad[c]
% vbu	        bucoa[c] + adp[c]   <=> coa[c] + atp[c] + bu[c]
% vbuoh	        bucoa[c] + 2 nadh  -> coa[c] + 2 nad[c] + buoh[c]
% vatpase	    atp[c]  -> adp[c]
% vbiomass	    0.6667 glc[c] + 0.5833 nadh[c] + 9.9 atp[c]  ->


G = [-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0,0
    -1,0,2,0,0,0,0,0,0,0,0,-2,2,0,0,0,0,0,0,0,0
    0,-1,1,-1,0,0,0,0,0,0,0,-1,1,1,0,0,0,0,0,0,0
    0,0,-2,-1,0,0,0,0,0,0,0,2,-1,1,1,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,-1,-1,-1,1,1,0,0
    0,0,0,1,0,0,0,0,0,0,0,0,0,-1,0,-1,0,0,1,0,0
    0,0,0,0,1,0,0,0,0,0,0,0,0,0,0,1,0,0,-1,0,0
    0,0,0,1,0,1,0,0,0,0,0,0,0,-1,-1,0,0,0,0,0,0
    0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,-2,0,1,0
    0,0,-1,0,0,0,1,0,0,0,0,1,0,0,0,0,1,-1,0,0,0
    0,0,0,2,0,0,0,1,0,0,0,0,0,-2,0,0,1,-1,0,0,0
    0,0,0,0,0,0,-1,0,0,1,0,0,0,0,0,0,0,1,0,-1,0
    0,0,0,0,0,0,0,0,-1,1,0,0,0,0,0,0,0,0,0,-1,1
    0,0,0,2,0,0,0,0,0,0,0,0,0,-2,0,0,0,0,0,-1,1
    0,0,-1,0,0,0,0,0,1,0,0,1,0,0,0,0,1,0,0,0,-1
    0,0,0,2,0,0,0,0,0,0,1,0,0,-2,0,0,1,0,0,0,-1
    0,0,1,0,0,0,0,0,0,0,0,-1,0,0,0,0,0,0,0,0,0
    -0.6667,0,0,0,0,0,0,0,0,0,0,-9.9,0,-0.5833,0,0,0,0,0,0,0];

% Objective function
sG = size(G);
f = zeros(sG(1),1);
f(28) = 1;

% Lower and upper bounds:
lb = zeros(sG(1),1);
ub = 1000*ones(sG(1),1);
lb(1) = -8.72;
ub(13) = 0;
lb(3:11) = -1000;
lb(16) = -1000;
lb(20) = -1000;
lb(25) = -1000;

% Position vector of exchange reactions:
p = [1;2;3;4;5;6;7;8;9;10;11;28];

% Relative position of the unmeasured flux of interest for specific
% sensitivity analysis:
pcs = 5;

% Metabolic flux analysis:
[x,fval] = mfaop(f,G,lb,ub,p,pcs)
