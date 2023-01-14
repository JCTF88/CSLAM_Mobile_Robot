
function [Parametros1,Parametros2,Parametros3] = fcn_Parametros_Camara()

f = 300.1;
resou = 150;
resov = 150;
ruido = 2;

RA = [0 0 1;
      1 0 0;
      0 -1 0];

Parametros1 = [f;resou;resov;ruido];
Parametros2 = RA;
Parametros3 = [5*pi/180;12*pi/180;8*pi/180;.5;.1;1];

end