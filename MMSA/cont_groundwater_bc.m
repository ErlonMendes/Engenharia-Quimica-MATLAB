function [pl,ql,pr,qr] = cont_groundwater_bc(xl,Cl,xr,Cr,t)
% CONT_GROUNDWATER_BC is the function containing boundary conditions of the
% Groundwater Contaminants' model

pl = Cl-1;

ql = 0;

pr = 0;

qr = 1;
end