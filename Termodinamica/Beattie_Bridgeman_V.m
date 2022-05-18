function Beattie_Bridgeman_V
clear
clc
T = 400; % K
p = 1.01325e7; % Pa
R = 8.314; % J/(mol*K)

A0 = 507.31e-3; % Pa*m^6/mol^(-2)
a = 71.32e-6; % m^3/mol
B0 = 104.76e-6; % m^3/mol
b = 72.35e-6; % m^3/mol
c = 660.0; % K^3*m^3/mol

Vm = Beattie_Bridgeman_eq (T,p,R,A0,a,B0,b,c) % Pa

    function [Vm] = Beattie_Bridgeman_eq (T,p,R,A0,a,B0,b,c)
        beta = R*T*(B0 - A0/(R*T) - c/T^3);
        gama = R*T*(-B0*b + A0*a/(R*T) - B0*c/T^3);
        delta = R*T*(B0*b*c/T^3);
        gamalinha = 1/(R*T)*(gama/(R*T) - (beta/(R*T))^2);
        deltalinha = 1/(R*T)^2*(delta/(R*T) - 3*beta*gama/(R*T)^2 + 2*(beta/(R*T))^3);
        Vm = R*T/p + beta/(R*T) + gamalinha*p + deltalinha*p^2;
    end
end