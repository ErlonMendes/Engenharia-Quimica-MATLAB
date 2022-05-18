function [ pa,qa,pR,qR ] = ex6_11cc( ra,Ca,rR,CR,t )
%EX6_11CC Possui as condições de contorno para a resolução do Exemplo 6.11 (CONSTANTINIDES, 2000)

pa = Ca-100; % Em r = a, C = 100% (CC do tipo Dirichlet)
qa = 0; % Não há CC do tipo Neumann em r = a
pR = 0; % Não há CC do tipo Dirichlet em r = R
qR = 1; % Em r = R, dC/dr = 0 (CC do tipo Neumann)
end