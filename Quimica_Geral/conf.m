function [c]=conf(Z)
% CONF - Programa que retorna os índices das configurações eletrônicas a partir do numero atômico Z

d=0;
A=[  2,   2,   6,   2,   6,   2,  10,   6,   2,  10,   6,   2,  14,  10,   6,   2,  14,  10,   6,   2];
B=['1s';'2s';'2p';'3s';'3p';'4s';'3d';'4p';'5s';'4d';'5p';'6s';'4f';'5d';'6p';'7s';'5f';'6d';'7p';'8s'];

for j=1:20
    for e=1:A(j)
        if sum(d)<Z
           d(j)=e;
        else
        end
    end
end

% Exceções Cr, Cu, Nb, Mo, Ru, Rh, Pd, Ag, Pt, Au, La, Gd, Ac, Th, Pa, U, Np e Cm
if Z==24 | Z==29
    d(6)=d(6)-1;
    d(7)=d(7)+1;
end
if Z==41 | Z==42 | Z==44 | Z==45 | Z==47
    d(9)=d(9)-1;
    d(10)=d(10)+1;
end
if Z==46
    d(9)=d(9)-2;
    d(10)=d(10)+2;
end
if Z==57 | Z==64
    d(14)=0;
    d(13)=d(13)-1;
    d(14)=d(14)+1;
end
if Z==78 | Z==79
    d(12)=d(12)-1;
    d(14)=d(14)+1;
end
if Z==89 | Z==91 | Z==92 | Z==93 | Z==96
    d(18)=0;
    d(17)=d(17)-1;
    d(18)=d(18)+1;
end
if Z==90
    d(18)=0;
    d(17)=d(17)-2;
    d(18)=d(18)+2;
end

d=d';
s=size(d);
c=[B(1:s(1),:) num2str(d)];
end