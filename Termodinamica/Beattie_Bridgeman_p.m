function Beattie_Bridgeman_p
clear
clc
T = 370; % K
Vm = 60e-3; % m^3/mol
R = 8.314; % J/(mol*K)

a = 0.00345; % Pa*m^6/mol^2
b = 23.4e-6; % m^3/mol

A0 = 2.19e-3; % Pa*m^6/mol^(-2)
a = 59.84e-6; % m^3/mol
B0 = 14e-6; % m^3/mol
b = 0e-6; % m^3/mol
c = 0.04; % K^3*m^3/mol

p = ideal_eq (T,Vm,R) % Pa
p = van_der_Waals_eq (T,Vm,R,a,b) % Pa
p = Beattie_Bridgeman_eq (T,Vm,R,A0,a,B0,b,c) % Pa

    function [p] = ideal_eq (T,Vm,R)
        p = R*T/Vm;
    end
    function [p] = van_der_Waals_eq (T,Vm,R,a,b)
        p = R*T/(Vm-b) - a/Vm^2;
    end
    function [p] = Beattie_Bridgeman_eq (T,Vm,R,A0,a,B0,b,c)
        beta = R*T*(B0 - A0/(R*T) - c/T^3)
        gama = R*T*(-B0*b + A0*a/(R*T) - B0*c/T^3)
        delta = R*T*(B0*b*c/T^3)
        p = (R*T + beta/Vm + gama/Vm^2 + delta/Vm^3)/Vm;
    end
end