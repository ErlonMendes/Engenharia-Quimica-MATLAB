function [ Tp ] = cond_eq( Te,Tw,T0,deltat,deltax,alfa )
% Método das diferenças finitas aplicado a problema puramente difusivo:
% dT/dt = alfa*d2T/dx2

Tp = ((alfa*deltat/deltax^2)*(Te + Tw) + T0)/(1 + 2*alfa*deltat/deltax^2);
end