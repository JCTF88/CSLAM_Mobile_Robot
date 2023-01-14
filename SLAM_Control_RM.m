
clear all;
clc;

Parametros_Robot = fcn_Parametros_Robot();

Ini_Robot = fcn_Ini_Robot();

[Ini_Filtro,PP_Inicial,Parametros_Filtro] = fcn_Ini_Filtro();

Parametros_Ciclo = fcn_Parametros_Ciclo();

[Parametros_Camara,RA_Camara,Parametros_Camara_Calibracion] = fcn_Parametros_Camara();

MAPA = fcn_Mapa();

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

i = 1;
kk = 1;
t = 0;
cont_frecuencia_camara = 1;
while i <= Parametros_Ciclo(3,1)
  t

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Cinematica del Robot (Posicion)

if i == 1
XR = Ini_Robot;
VC = [0;0];
end
XR = fcn_Cinematica_Robot(Parametros_Robot,VC,XR,Parametros_Ciclo(2,1));
XRG(kk,:) = [XR(1,1) XR(2,1) XR(3,1)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Trayectoria deseada

if i == 1
XD = [0;0;pi/2;0;0;0;0];
end
XD = fcn_Taryectoria_deseada(t,i,Parametros_Ciclo(2,1),XD);
XDG(kk,:) = [XD(1,1) XD(2,1) XD(3,1)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Medicion encoders

WW = fcn_Cinematica_Encoders(Parametros_Robot,XR);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Medicion brujula

med_brujula = fcn_med_Brujula(XR);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Medicion Rango

med_rango = fcn_med_Rango(XR);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Estimacion del Filtro A priori (Robot)

if i == 1
XE = Ini_Filtro;
PP = PP_Inicial;
XLAND = [];
end

tam_XLAND = size(XLAND);

[XE,PP,XLAND] = fcn_Estimacion_Apriori(Parametros_Ciclo(2,1),XE,WW,PP,Parametros_Filtro,tam_XLAND,XLAND,Parametros_Robot);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if cont_frecuencia_camara == 1

% Proyeccion Mapa no Visible

if i == 1
MAPANO = MAPA;
end
tam_mapa_novisible = size(MAPANO);

for s = 1 : tam_mapa_novisible(1)

Punto = fcn_Modelo_Camara(Parametros_Camara,RA_Camara,XR,MAPANO(s,:));
PROMAPANO(s,:) = Punto + [(rand-.5)*Parametros_Camara(4,1) (rand-.5)*Parametros_Camara(4,1)];

end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Proyeccion Mapa Visible

if i == 1
MAPASI = [];
PROMAPASI = [];
end
tam_mapa_sivisible = size(MAPASI);

for s = 1 : tam_mapa_sivisible(1)

Punto = fcn_Modelo_Camara(Parametros_Camara,RA_Camara,XR,MAPASI(s,:));
PROMAPASI(s,:) = Punto + [(rand-.5)*Parametros_Camara(4,1) (rand-.5)*Parametros_Camara(4,1)];

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Inicializacion de Landmarks

tam_mapa_novisible = size(MAPANO);

s2 = 1;
del = zeros(0);
for s = 1 : tam_mapa_novisible(1)

tam_XLAND = size(XLAND);

Pos_Plano = fcn_Pos_Plano(RA_Camara,XR,MAPANO(s,:));

if abs(PROMAPANO(s,1)) <= Parametros_Camara(2,1) && abs(PROMAPANO(s,2)) <= Parametros_Camara(3,1) && tam_XLAND(1) <= Parametros_Filtro(2,1) && Pos_Plano > 0

LAND = fcn_Inicializacion_Landmark(XR,XE,MAPANO(s,:),PROMAPANO(s,:),Parametros_Camara,RA_Camara,i);

XLAND = [XLAND;LAND];
MAPASI =[MAPASI;MAPANO(s,:)];
PROMAPASI =[PROMAPASI;PROMAPANO(s,:)];

del(s2,1) = s;

s2 = s2 + 1;
end
end

MAPANO(del,:) = [];

PP = fcn_Aumentar_P(PP,del,Parametros_Filtro(1,1),i);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Actualizacion del filtro (Camara)

tam_XLAND = size(XLAND);

for s = 1 : tam_XLAND(1)

[XE,PP,XLAND] = fcn_Actualizar_Filtro_Camara(Parametros_Camara,RA_Camara,XE,XLAND(s,:),s,tam_XLAND,PROMAPASI(s,:),Parametros_Filtro,PP,XLAND);

end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Actualizacion del filtro (Brujula)

tam_XLAND = size(XLAND);

[XE,PP,XLAND] = fcn_Actualizar_Filtro_Brujula(XE,tam_XLAND,Parametros_Filtro,PP,XLAND,med_brujula);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Actualizacion del filtro (rango)

tam_XLAND = size(XLAND);

[XE,PP,XLAND] = fcn_Actualizar_Filtro_Rango(XE,tam_XLAND,Parametros_Filtro,PP,XLAND,med_rango);

XEG(kk,:) = [XE(1,1) XE(2,1) XE(3,1)];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

if cont_frecuencia_camara == 1

% Eliminar Landmarks

tam_XLAND = size(XLAND);

ss = 1;
del = zeros(0);
for s = 1 : tam_XLAND(1)

if abs(PROMAPASI(s,1)) > Parametros_Camara(2,1) || abs(PROMAPASI(s,2)) > Parametros_Camara(3,1)

del(ss,1)=s;

ss = ss + 1;

end

end

XLAND(del,:) = [];
MAPASI(del,:) = [];
PROMAPASI(del,:) = [];

tam_Borrar = size(del);

for s1 = 1 : tam_Borrar(1)

re = del(s1,1) - s1 + 1;
PP(2+((re-1)*3):2+((re-1)*3)+3-1,:) = [];
PP(:,2+((re-1)*3):2+((re-1)*3)+3-1) = [];

end

end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Control del Robot

[VC,E] = fcn_Control_Robot(Parametros_Robot,XE,XD,i,Parametros_Ciclo(2,1));

VDG(kk,:) = [VC(1,1) VC(2,1)];

EE(kk,:) = [E(1,1) E(2,1) E(3,1)];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cont_frecuencia_camara = cont_frecuencia_camara + 1;
if cont_frecuencia_camara == 11
cont_frecuencia_camara = 1;
end

tt(kk,1) = t;
kk = kk + 1;
i = i + 1;
t = t + Parametros_Ciclo(2,1);

end

fcn_Graficas_Final(tt,XRG,XDG,VDG,EE,XEG);
