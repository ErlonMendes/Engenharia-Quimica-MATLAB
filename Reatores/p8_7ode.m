function [dXdW] = p8_7ode(W,X)
%P8_7ODE Fogler
% X(1) = X
% X(2) = T
% X(3) = y
Ca0 = 0.271;
Fa0 = 5.42;
alfa = 0.019;
dhr = -20e3;
Cpa = 40;
k = 0.133*exp(31.4e3/8.314*(1/450-1/X(2)));
Ca = Ca0*(1-X(1))/(1+X(1))*(450/X(2))*X(3);
ra = -k*Ca;
dXdW(1,:) = -ra/Fa0;
dXdW(2,:) = dhr*ra/(Fa0*Cpa);
dXdW(3,:) = -alfa*(1+X(1))/(2*X(3))*(X(2)/450);
end

