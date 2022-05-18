function [pl,ql,pr,qr] = org_chem_rivers_bc(xl,ul,xr,ur,t)
% ORG_CHEM_RIVERS_BC is the function containing boundary conditions of the
% Organic Chemicals in Rivers and Estuaries' model

pl = [ul(1)-10
      ul(2)-0];

ql = [0
      0];

pr = [0
      0];

qr = [1
      1];
