function [dXdV] = ex8_6(V,X)
%EX8_6 Solução do exemplo 8-6 p. 412 FOGLER 3ª ed
Fa0 = 0.9*163;
Ca0 = 9.3;
T = 330 + 43.3*X(1);
k = 31.1*exp(7906*(T-360)/(T*360));
Kc = 3.03*exp(-830.3*((T-333)/(T*333)));
ra = -k*Ca0*(1-(1+1/Kc)*X(1));
dXdV(1,:) = -ra/Fa0;
end

