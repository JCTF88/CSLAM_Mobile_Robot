
function [Ini_Filtro,PP,Parametros] = fcn_Ini_Filtro()

Ini_Filtro = [-.5;-.5;pi/3];

PP = eye(3) * .01;

ini = .5;

max = 20;

ini_Q_estado_robot = .0001;
ini_Q_estado_landmark = .1;

ruido_camara = 3;
ruido_brujula = .1;
ruido_rango = .1;
ruido_encoders = .08;

Parametros = [ini;max;ini_Q_estado_robot;ini_Q_estado_landmark;ruido_camara;ruido_brujula;ruido_rango;ruido_encoders];

