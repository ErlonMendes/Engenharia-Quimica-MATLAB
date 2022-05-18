function [ R ] = metals_lakes1( KdM, kstau )
% METALS_LAKES Steady-State Model for Metals in Lakes

fp = (KdM)./(1+KdM);
R = (kstau.*fp)./(1+kstau.*fp);
