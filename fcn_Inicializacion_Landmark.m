
function LAND = fcn_Inicializacion_Landmark(XR,XE,POSPUN,PROPUN,Parametros,RA,i)

f = Parametros(1,1);

e=5;
if i == 1
e = 0;  
end

dii = sqrt( (XR(1,1)-POSPUN(1,1))^2 + (XR(2,1)-POSPUN(1,2))^2 + (0-POSPUN(1,3))^2) + (rand-.5)*e;

R = [cos(XE(3,1)) -sin(XE(3,1)) 0;sin(XE(3,1)) cos(XE(3,1)) 0;0 0 1];

AN =  R * RA * [PROPUN(1,1);PROPUN(1,2);f];

%ti = atan2(AN(2),AN(1));
%fi = atan2(AN(3),sqrt(AN(1)^2+AN(2)^2));

ti = atan2(AN(1),AN(3));
fi = atan2(-AN(2),sqrt(AN(1)^2+AN(3)^2));

%VM=[cos(fi)*cos(ti);
%    cos(fi)*sin(ti);
%    sin(fi)];

VM=[cos(fi)*sin(ti);
    -sin(fi);
    cos(fi)*cos(ti)];

LAND = ([XE(1:2,1);0] + dii*VM)';
