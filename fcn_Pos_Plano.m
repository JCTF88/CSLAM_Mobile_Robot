
function Pos_Plano = fcn_Pos_Plano(RA,X,LAND)

R = [cos(X(3,1)) -sin(X(3,1)) 0;sin(X(3,1)) cos(X(3,1)) 0;0 0 1];

AS = RA' * R' *(LAND(1,1:3)'-[X(1:2,1);0]);

Pos_Plano = AS(3,1);