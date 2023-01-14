
function [XE,PP,XLAND] = fcn_Actualizar_Filtro_Brujula(XE,tam_XLAND,Parametros_Filtro,PP,XLAND,med_brujula)

XELAND = [];
for ss = 1 : tam_XLAND(1)

XELAND = [XELAND;XLAND(ss,:)'];

end

C = [zeros(1,2) 1 zeros(1,tam_XLAND(1)*3)];

R = Parametros_Filtro(6,1);

I = eye(3+tam_XLAND(1)*3);

XE = [XE;XELAND];

K = PP*C'*(inv((C*PP*C')+R));
XE = XE + (K*(med_brujula-XE(3,1)));
PP=(I-(K*C))*PP;

XLAND = [];
for s = 1 : tam_XLAND(1)

XLAND = [XLAND; XE(4+(s-1)*3:6+(s-1)*3,1)'];

end

XE = XE(1:3,1);
