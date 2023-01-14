
function fcn_Graficas_Final(tt,XRG,XDG,VDG,EE,XEG)

figure(1)
plot(XRG(:,1),XRG(:,2),'b-');
hold on
plot(XDG(:,1),XDG(:,2),'r-');
hold on
plot(XEG(:,1),XEG(:,2),'g-');
hold on
grid on;

figure(2)
plot(tt(:,1),EE(:,1));
grid on;

figure(3)
plot(tt(:,1),EE(:,2));
grid on;

figure(4)
plot(tt(:,1),EE(:,3)*180/pi);
grid on;

figure(5)
plot(tt(:,1),XRG(:,1),'b-');
hold on
plot(tt(:,1),XEG(:,1),'r-');
hold on
grid on;

figure(6)
plot(tt(:,1),XRG(:,2),'b-');
hold on
plot(tt(:,1),XEG(:,2),'r-');
hold on
grid on;

figure(7)
plot(tt(:,1),XRG(:,3),'b-');
hold on
plot(tt(:,1),XEG(:,3),'r-');
hold on
grid on;


end
