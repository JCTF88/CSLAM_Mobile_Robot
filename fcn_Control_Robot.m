

function [VC,ER,VD,EI] = fcn_Control_Robot(Parametros_Robot,XR,XD,i,dt)

r = Parametros_Robot(2,1);
d = Parametros_Robot(3,1);
L = Parametros_Robot(4,1);

B = [r/2 r/2;r/2*L -r/2*L];

%%%%%%%%%%%%% Kinematic Control %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Ro = [cos(XR(3,1)) sin(XR(3,1)) 0;-sin(XR(3,1)) cos(XR(3,1)) 0;0 0 1];

ER = XD(1:3,1) - XR(1:3,1);

EX = Ro * ER;

KXX = [5;5;1;20];

VD(1,1) = XD(7,1)*cos(EX(3,1))+ KXX(1,1)*EX(1,1)-XD(6,1)*sin(EX(3,1))*d;

if EX(3,1) >= 0
VD(2,1) = (KXX(2,1)*EX(2,1)^2 + KXX(3,1)*EX(3,1)^2 + KXX(4,1)*EX(2,1) + EX(2,1)*XD(7,1)*sin(EX(3,1)) + EX(2,1)*XD(6,1)*cos(EX(3,1))*d + XD(6,1)*cos(EX(3,1)))/(d*EX(2,1)+cos(EX(3,1)));
end

if EX(3,1) < 0
VD(2,1) = (KXX(2,1)*EX(2,1)^2 + KXX(3,1)*EX(3,1)^2 - KXX(4,1)*EX(2,1) + EX(2,1)*XD(7,1)*sin(EX(3,1)) + EX(2,1)*XD(6,1)*cos(EX(3,1))*d - XD(6,1)*cos(EX(3,1)))/(d*EX(2,1)-cos(EX(3,1)));
end

%KX = [2;XD(7,1);2];

%VD(1,1) = KX(2,1)*cos(EX(3,1)) + KX(1,1)*EX(1,1)*KX(2,1);
%VD(2,1) = XD(6,1) + EX(2,1)*KX(2,1) + KX(3,1)*sin(EX(3,1))*KX(2,1);

VC = B^-1 * VD;

if i == 1
VC = [0;0];
end


