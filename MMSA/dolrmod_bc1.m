function [ res ] = dolrmod_bc1( ya,yb )
% DO_LARGE_RIVERS_BC1 is the function containing the boundary conditions of
% an upstream segment above the wastewater discharge.

global L0 N0 D0

res = [ya(2) - 0
       yb(1) - L0
       ya(4) - 0
       yb(3) - N0
       ya(6) - 0
       yb(5) - D0];
end
