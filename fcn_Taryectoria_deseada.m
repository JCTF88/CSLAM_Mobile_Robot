function XD = fcn_Taryectoria_deseada(t,i,dt,XDPAS)

%ti = 0;
%tf = 110;

%qfx = 10;
%qix = 0;

cir1 = 2.5;
cir2 = 60;

%a5tx = ((6*qfx)/(tf-ti)^(5))-((6*qix)/(tf-ti)^(5));

%a4tx = (qix*((15*tf)+(15*ti))/(tf-ti)^(5))-(qfx*((15*tf)+(15*ti))/(tf-ti)^(5));

%a3tx = (qfx*((10*tf^(2))+(40*tf*ti)+(10*ti^(2)))/(tf-ti)^(5))-(qix*((10*tf^(2))+(40*tf*ti)+(10*ti^(2)))/(tf-ti)^(5));

%a2tx = (30*qix*tf*ti*(tf+ti)/(tf-ti)^(5))-(30*qfx*tf*ti*(tf+ti)/(tf-ti)^(5));

%a1tx = (30*qfx*tf^(2)*ti^(2)/(tf-ti)^(5))-(30*qix*tf^(2)*ti^(2)/(tf-ti)^(5));

%a0tx = (qix*tf^(3)*((tf^(2))-(5*tf*ti)+(10*ti^(2)))/(tf-ti)^(5))-(qfx*ti^(3)*((10*tf^(2))-(5*tf*ti)+(ti^(2)))/(tf-ti)^(5));


%XD(1,1) = (a5tx*t^(5))+(a4tx*t^(4))+(a3tx*t^(3))+(a2tx*t^(2))+(a1tx*t)+(a0tx)-2.5*sin(t*.04);

%XD(1,1) = 5*sin(t*.02);

%XD(2,1) = t/10;

%XD(1,1) = cir1 * cos((2*pi/cir2)*t) - cir1;
%XD(2,1) = cir1 * sin((2*pi/cir2)*t);

XD(1,1) = cir1 * sin((2*pi/cir2)*t);
XD(2,1) = cir1 * cos((2*pi/cir2)*t) - cir1;

%if t > 60
%XD(1,1) = -cir1 * cos((2*pi/cir2)*t) + cir1;
%XD(2,1) = cir1 * sin((2*pi/cir2)*t);
%end

%XD(1,1) = 0;
%XD(2,1) = t/4;

%if t > 20 && t <= 40

%XD(1,1) = (t-20)/4;
%XD(2,1) = 5;

%end

%if t > 40 && t <= 60

%XD(1,1) = 5;
%XD(2,1) = 5 - (t-40)/4;

%end

XD(4,1) = (XD(1,1)-XDPAS(1,1))/dt;
XD(5,1) = (XD(2,1)-XDPAS(2,1))/dt;

XD(3,1) = atan2(XD(5,1),XD(4,1));

%if i == 1

%XD(3,1) = pi;
%XD(3,1) = 2.35;

%end

%if  t <= 5

%XD(3,1) = pi/3 + (t/5)*0.1667;

%end

%if t <= 30

%XD(3,1) = pi/2;

%end

%if t > 20 && t <= 25

%XD(3,1) = pi/2 - ((t-20)/5)*pi*.5;

%end

%if t > 25 && t <= 40

%XD(3,1) = 0;

%end

%if t > 40 && t <= 45

%XD(3,1) =  -((t-40)/5)*pi*.5;

%end

%if t > 45 && t <= 60

%XD(3,1) = -pi/2;

%end

%if XD(3,1) < 0


%XD(3,1) = XD(3,1) + 2*pi;

%end

%if t > 45  && t <= 76

%XD(3,1) = XD(3,1) + 2*pi;

%end

if XD(3,1) > 0

XD(3,1) = XD(3,1) - 2*pi;

end


XD(6,1) = (XD(3,1)-XDPAS(3,1))/dt;

XD(7,1) = sqrt(XD(4,1)^2 + XD(5,1)^2);
