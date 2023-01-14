
function [XE,PP,XLAND] = fcn_Actualizar_Filtro_Rango(XE,tam_XLAND,Parametros_Filtro,PP,XLAND,med_rango)

x = XE(1,1);
y = XE(2,1);

XELAND = [];
for ss = 1 : tam_XLAND(1)

XELAND = [XELAND;XLAND(ss,:)'];

end

d1 = x/(x^2 + y^2)^(1/2);
d2 = y/(x^2 + y^2)^(1/2);

C = [d1 d2 0 zeros(1,tam_XLAND(1)*3)];

R = Parametros_Filtro(7,1);

I = eye(3+tam_XLAND(1)*3);

XE = [XE;XELAND];

K = PP*C'*(inv((C*PP*C')+R));
XE = XE + (K*(med_rango-sqrt(XE(1,1)^2 + XE(2,1)^2)));
PP=(I-(K*C))*PP;

XLAND = [];
for s = 1 : tam_XLAND(1)

XLAND = [XLAND; XE(4+(s-1)*3:6+(s-1)*3,1)'];

end

XE = XE(1:3,1);
