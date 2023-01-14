
function XR = fcn_Cinematica_Robot(Parametros_Robot,VC,XRPAS,dt)

d = Parametros_Robot(3,1);

B = [Parametros_Robot(2,1)/2 Parametros_Robot(2,1)/2;Parametros_Robot(2,1)/2*Parametros_Robot(4,1) -Parametros_Robot(2,1)/2*Parametros_Robot(4,1)];

te = XRPAS(3,1);

G = [cos(te) -d*sin(te);sin(te) d*cos(te);0 1];

XP = G * B * VC;

XR = [XRPAS(1:3,1)+XP*dt;XP];  



