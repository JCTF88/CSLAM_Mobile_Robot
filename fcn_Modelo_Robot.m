
function V = fcn_Modelo_Robot(Parametros_Robot,Parametros_Motor,VPAS,VOL,dt)

m = Parametros_Robot(1,1);
r = Parametros_Robot(2,1);
d = Parametros_Robot(3,1);
L = Parametros_Robot(4,1);
I = Parametros_Robot(5,1);

Jm = Parametros_Motor(1,1);
fm = Parametros_Motor(2,1);
Ka = Parametros_Motor(3,1);
Kb = Parametros_Motor(4,1);
Ra = Parametros_Motor(5,1);
rr = Parametros_Motor(6,1);

DJ = eye(2) * Jm;
DF = eye(2) * fm + (Ka*Kb/Ra);
DN = eye(2) * 1 / rr;
DK = eye(2) * Ka/Ra*rr;

HB = [m 0;0 I];
BB = 1/r * [1 1;L -L];
B2 = [r/2 r/2;r/L -r/L];

VP = (DJ*B2^-1 + DN*BB^-1*HB)^-1  * (DK*VOL - DF*B2^-1*VPAS);

V = VPAS + VP * dt;  
 
