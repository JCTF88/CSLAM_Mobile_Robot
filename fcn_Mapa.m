

function MAP = fcn_Mapa()

la1=25;
la2=40;
dis1=.5;
dis2=-1;
dis3=-1;
MAP=zeros(la1*la2,4);
contm=0;
for s11 =1:la1
    
    
for s22=1:la2
contm=contm+1;
    
x=dis2+dis1*s22+(rand-.5)*3;    
y=dis3+dis1*s11+(rand-.5)*3;
z=((sqrt(x*x+y*y))/20)+(rand-.5)*2 +1;

    
MAP(s22+(la2*(s11-1)),1)=x;
MAP(s22+(la2*(s11-1)),2)=y;
MAP(s22+(la2*(s11-1)),3)=z;
MAP(s22+(la2*(s11-1)),4)=contm;

end

end

%figure(100)
%plot3(MAP(:,1),MAP(:,2),MAP(:,3),'.');
%grid on;