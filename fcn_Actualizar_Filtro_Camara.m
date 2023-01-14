
function [XE,PP,XLAND] = fcn_Actualizar_Filtro_Camara(Parametros_Camara,RA_Camara,XE,LAND,s,tam_XLAND,Punto_r,Parametros_Filtro,PP,XLAND)

x = XE(1,1);
y = XE(2,1);
te = XE(3,1);

xt = LAND (1,1);
yt = LAND (1,2);
zt = LAND (1,3);

f = Parametros_Camara(1,1);

XELAND = [];
for ss = 1 : tam_XLAND(1)

XELAND = [XELAND;XLAND(ss,:)'];

end

Punto_e = fcn_Modelo_Camara(Parametros_Camara,RA_Camara,XE,LAND);

du1 = - (f*sin(te))/(cos(te)*(x - xt) + sin(te)*(y - yt)) - (f*cos(te)*(cos(te)*(y - yt) - sin(te)*(x - xt)))/(cos(te)*(x - xt) + sin(te)*(y - yt))^2;
du2 = (f*cos(te))/(cos(te)*(x - xt) + sin(te)*(y - yt)) - (f*sin(te)*(cos(te)*(y - yt) - sin(te)*(x - xt)))/(cos(te)*(x - xt) + sin(te)*(y - yt))^2;
du3 = - f - (f*(cos(te)*(y - yt) - sin(te)*(x - xt))^2)/(cos(te)*(x - xt) + sin(te)*(y - yt))^2;
du4 = (f*sin(te))/(cos(te)*(x - xt) + sin(te)*(y - yt)) + (f*cos(te)*(cos(te)*(y - yt) - sin(te)*(x - xt)))/(cos(te)*(x - xt) + sin(te)*(y - yt))^2;
du5 = (f*sin(te)*(cos(te)*(y - yt) - sin(te)*(x - xt)))/(cos(te)*(x - xt) + sin(te)*(y - yt))^2 - (f*cos(te))/(cos(te)*(x - xt) + sin(te)*(y - yt));
du6 = 0;

dv1 = -(f*zt*cos(te))/(cos(te)*(x - xt) + sin(te)*(y - yt))^2;
dv2 = -(f*zt*sin(te))/(cos(te)*(x - xt) + sin(te)*(y - yt))^2;
dv3 = -(f*zt*(cos(te)*(y - yt) - sin(te)*(x - xt)))/(cos(te)*(x - xt) + sin(te)*(y - yt))^2;
dv4 = (f*zt*cos(te))/(cos(te)*(x - xt) + sin(te)*(y - yt))^2;
dv5 = (f*zt*sin(te))/(cos(te)*(x - xt) + sin(te)*(y - yt))^2;
dv6 = f/(cos(te)*(x - xt) + sin(te)*(y - yt));

C = [du1 du2 du3 zeros(1,(s-1)*3) du4 du5 du6 zeros(1,3*(tam_XLAND(1)-s));
     dv1 dv2 dv3 zeros(1,(s-1)*3) dv4 dv5 dv6 zeros(1,3*(tam_XLAND(1)-s))];

R = eye(2) * Parametros_Filtro(5,1);

I = eye(3+tam_XLAND(1)*3);

XE = [XE;XELAND];

K = PP*C'*(inv((C*PP*C')+R));
XE = XE + (K*(Punto_r'-Punto_e'));
PP=(I-(K*C))*PP;

XLAND = [];
for s = 1 : tam_XLAND(1)

XLAND = [XLAND; XE(4+(s-1)*3:6+(s-1)*3,1)'];

end

XE = XE(1:3,1);
