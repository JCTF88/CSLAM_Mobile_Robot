
function Punto = fcn_Modelo_Camara(Parametros,RA,X,LAND)

f = Parametros(1,1);

R = [cos(X(3,1)) -sin(X(3,1)) 0;sin(X(3,1)) cos(X(3,1)) 0;0 0 1];

AS = RA' * R' *(LAND(1,1:3)'-[X(1:2,1);0]);

u = (f * AS(1) / AS(3));
v = (f * AS(2) / AS(3));

Punto = [u v];
