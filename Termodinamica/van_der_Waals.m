function van_der_Waals
clear
clc
% T = 500; % K
% Vm = 40e-3; % m^3/mol
% R = 8.314; % J/(mol*K)
% 
% a = 0.138; % Pa*m^6/mol^2
% b = 31.8e-6; % m^3/mol
% 
% p = ideal_eq (T,Vm,R) % Pa
% p = van_der_Waals_eq (T,Vm,R,a,b) % Pa

T = 1000; % K
Vm = 0.1; % L/mol
R = 8.2057e-2; % L*atm/(mol*K)

a = 1.7599; % atm*L^2/mol^2
b = 0.0242; % L/mol

p = ideal_eq (T,Vm,R) % atm
p = van_der_Waals_eq (T,Vm,R,a,b) % atm

    function [p] = ideal_eq (T,Vm,R)
        p = R*T/Vm;
    end
    function [p] = van_der_Waals_eq (T,Vm,R,a,b)
        p = R*T/(Vm-b) - a/Vm^2;
    end
end