
function WW = fcn_Cinematica_Encoders(Parametros_Robot,XR)

B = [Parametros_Robot(2,1)/2 Parametros_Robot(2,1)/2;Parametros_Robot(2,1)/2*Parametros_Robot(4,1) -Parametros_Robot(2,1)/2*Parametros_Robot(4,1)];

ROT3 = [cos(XR(3,1)) sin(XR(3,1));
        -sin(XR(3,1))/Parametros_Robot(3,1) cos(XR(3,1))/Parametros_Robot(3,1)];   

V = [XR(4,1);XR(5,1)];

WW = B^-1 * ROT3 * V + [(rand-.5)*.05;(rand-.5)*.05];


