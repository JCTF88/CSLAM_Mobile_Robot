
function [XE,PP,XLAND] = fcn_Estimacion_Apriori(dt,XEPAS,WW,PP,Parametros_Filtro,tam_XLAND,XLAND,Parametros_Robot)

XELAND = [];
for ss = 1 : tam_XLAND(1)

XELAND = [XELAND;XLAND(ss,:)'];

end

r = Parametros_Robot(2,1);;
L = Parametros_Robot(4,1);
d = Parametros_Robot(3,1);

te = XEPAS(3,1);

wr = WW(1,1);
wl = WW(2,1);

H = [cos(te) -d*sin(te);sin(te) d*cos(te);0 1];

B = [r/2 r/2;r/2*L -r/2*L];

XP = H * B * WW;

XE = XEPAS(1:3,1) + XP * dt;

XE = [XE;XELAND];

du11 = 1;
du12 = 0;
du13 = -dt*(wl*((r*sin(te))/2 - (L*d*r*cos(te))/2) + wr*((r*sin(te))/2 + (L*d*r*cos(te))/2));

du21 = 0;
du22 = 1;
du23 = dt*(wl*((r*cos(te))/2 + (L*d*r*sin(te))/2) + wr*((r*cos(te))/2 - (L*d*r*sin(te))/2));

du31 = 0;
du32 = 0;
du33 = 1;

A = [du11 du12 du13;du21 du22 du23;du31 du32 du33];

A = [A zeros(3,tam_XLAND(1)*3);
     zeros(tam_XLAND(1)*3,3) eye(tam_XLAND(1)*3)];

Q = eye(3+tam_XLAND(1)*3) * Parametros_Filtro(4,1);
Q(1:3,1:3) = eye(3) * Parametros_Filtro(3,1);

PP = (A*PP*A')+Q;

XLAND = [];
for s = 1 : tam_XLAND(1)

XLAND = [XLAND; XE(4+(s-1)*3:6+(s-1)*3,1)'];

end

XE = XE(1:3,1);
