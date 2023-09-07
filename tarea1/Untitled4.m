clc
clear all

load('WSCurlPSO_12');
%la pasamos al orden que corresponde 
WSCurl=WSCurl*(10^-7);

beta=2*10^(-11); %m^-1s^-1
rho=1025;

%usamos ademas un rotor promedio 
mediarotor=nanmean(WSCurl,3);

%formula sacada de la tarea 
V = mediarotor/(rho*beta);


VV=flipud(V);
%busco posiciones con NaN
indices_nan = isnan(VV);
% Reemplazar los elementos NaN por 0
VV(indices_nan) = 0;
lon2=flip(lon1);%aunque iwal damos vuelta nuestro vector lon
%parece que no es necesario darlo vuelta

d=diff(lon1);
distancia11=gsw_distance(lon1,lat1);%20

