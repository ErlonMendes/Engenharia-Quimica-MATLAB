function [pl,ql,pr,qr] = cond_cc(xl,Tl,xr,Tr,t)
%COND_CC Possui as condições de contorno para a resolução do modelo de condução pura em uma barra de aço
% Os índices l e r significam left e right, isto é, esquerda e direita da barra.

pl = Tl-100; % Em x = 0, T = 100°C (CC do tipo Dirichlet)

ql = 0; % Não há CC do tipo Neumann em x = 0

pr = Tr-0; % Em x = L, T = 0°C (CC do tipo Dirichlet)

qr = 0; % Não há CC do tipo Neumann em x = L
end