function [ dXdW ] = P4_22a( W,X )
%P4_22 Solução do problema 4.22 (FOGLER,1999)
k = 1.74;
Pa0 = 0.333*5;
Fa0 = 0.333*40;

dXdW(1,:) = 2*k*Pa0/Fa0*(1-X)/(1-0.6667*X);
end