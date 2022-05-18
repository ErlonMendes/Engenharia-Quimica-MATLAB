function [ res ] = dolrmod_bc2( ya,yb )
% DO_LARGE_RIVERS_BC2 is the function containing the boundary conditions of
% a downstream segment above the wastewater discharge.

global L0 N0 D0

res = [ya(1) - L0
       yb(2) - 0
       ya(3) - N0
       yb(4) - 0
       ya(5) - D0
       yb(6) - 0];
end
