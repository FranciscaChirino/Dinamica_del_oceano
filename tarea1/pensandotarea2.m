%A partir de los datos de rotor del esfuerzo del viento (en el archivo 
%WSCurlPSO_12.mat) Estime las velocidades verticales w, asociadas al bombeo de 
%Ekman. Use una densidad típica de 1025 kg m-3
%y el valor correspondiente a cada latitud 
%para el parámetro de Coriolis.

%en el archivo tenemos latitudes, longitudes 

%y WSCurl es una matriz de longitudxlatitudxrotoresfuerzoviento
clc
clear all

load('WSCurlPSO_12');
WSCurl=WSCurl*(10^-7);
%pero yo por comodidad la cambiare a latitudxlongitudxrotor
%WSCurl = permute(WSCurl, [2, 1, 3]);


%aca tengo un año para la primera grilla
%es decir, aca tengo el rotor de tau pq tau es el esfuerzorotor=squeeze(WSCurl(1,1,:)); del viento 
 %todo el esfuerzo del rotor del viento para la primera grilla

%% importante a WSCurl hay que multiplicarl x10^-7 pq en la matriz original no está multiplicada
%% para que de esta forman den velocidades verticales pequeñas 

WSCurl=WSCurl*(10^-7);



%usando la ecuacion mostrad en D 
% w = nablaxtau / rho x f 
%donde nablaxtau es el rotor del esfuerzo del viento que esta dado

%para la primera grilla 
%primer mes 

w(1,1,1)= squeeze(WSCurl(1,1,1))/rho*(1*2.729*e^-5*sind(lat1(1)))

%segundo mes
w(1,1,2)= squeeze(WSCurl(1,1,2))/rho*(1*2.729*e^-5*sind(lat1(1)))


%tercer mes
w(1,1,3)= squeeze(WSCurl(1,1,3))/rho*(1*2.729*e^-5*sind(lat1(1)))


%hago un ciclo for para la primera grilla 

rho=1025;

%creo una grilla de latitudes y longitudes 

%lon1
for i=1:12
    
    w(1,1,i)=squeeze(WSCurl(1,1,i))/rho*(2.729*(10^-5)*sind(lat1(1)));

end


%ahora generalizamos para todas las lon
%lon2
for i=1:12
    
    w(2,1,i)=squeeze(WSCurl(2,1,i))/rho*(2.729*(10^-5)*sind(lat1(1)));

end

%generalizamos para todas las lon
for k=1:200 %lon
for i=1:12
    
    w(k,1,i)=squeeze(WSCurl(k,1,i))/rho*(2.729*(10^-5)*sind(lat1(1)));

end
end


%% sacamos las velocidades verticales 
%ahora para lat, incluyendo la variacion del parametro de coriolis
rho=1025;
for j=1:240
for k=1:200 %lon
for i=1:12
    
    w(k,j,i)=squeeze(WSCurl(k,j,i))/rho*(2.729*(10^-5)*sind(lat1(j)));

end
end
end

%sgy estan bien pq me da la mayoria negativa como deberia ser si tengo un
%rotor del viento positivo 


%%

%a) Grafique los campos originales del rotor para las distintas estaciones del año. Compare 
%sus resultados con los obtenidos por Bakun y Nelson (1991).

%saco las distintas estaciones, verano, invierno, otoño, primavera 

%pensando que el primer mes es enero

%verano: diciembre enero febero marzo
%otoño: marzo abril mayo junio 
%invierno: junio julio agosto septiembre.
%primavera: septiembre octubre noviembre diciembre


%saco el rotor solo para enero
roenero=WSCurl(:,:,1);
rooenero=roenero*1e-7;
figure()
contourf(lon1, lat1, roenero', 'LineColor', 'k')
colorbar
title('Promedio Anual de Velocidades Verticales')
xlabel('Longitud')
ylabel('Latitud')
caxis([-4 4])
axis tight



%saco los rotores para verano 
rover=WSCurl(:,:,[12, 1, 2, 3]);
%saco la media 
mediarover=nanmean(rover,3);

%saco los rotores para otoño
root=WSCurl(:,:,[3, 4, 5, 6]);
%saco la media 
mediaroot=nanmean(root,3);

%saco los rotores para invierno 
roinv=WSCurl(:,:,[6, 7, 8, 9]);
%saco la media 
mediaroinv=nanmean(roinv,3);

%saco los rotores para primavera 
ropri=WSCurl(:,:,[9, 10, 11, 12]);
%saco la media 
mediaropri=nanmean(ropri,3);

 
% Supongamos que tienes una matriz llamada 'campo_rotor' de tamaño 200x240 que contiene los datos del campo original del rotor.
% Supongamos que también tienes los vectores 'lon' y 'lat' de tamaño 200x1 y 240x1 respectivamente.

% Crear la cuadrícula de longitud y latitud
[LON, LAT] = meshgrid(lon1, lat1);

% Intercambiar el orden de las dimensiones de LON y LAT
LON = LON.';
LAT = LAT.';

% Graficar los campos originales del rotor con la función quiver
quiver(LON, LAT, mediarover(:,:), mediarover(:,:),5);

% Graficar los campos originales del rotor con la función quiver
figure()
subplot(2,2,1)
quiver(LON, LAT, mediarover(:,:), mediarover(:,:),5); %el 5 me ve e, tamaño de las flechas 
title('Verano')
xlabel('longitud')
ylabel('latitud')
axis tight

subplot(2,2,2)
quiver(LON, LAT, mediaroot(:,:), mediaroot(:,:),5); %el 5 me ve e, tamaño de las flechas 
title('Otoño')
xlabel('longitud')
ylabel('latitud')
axis tight
caxis([0 0.000000000005])
colorbar

subplot(2,2,3)
quiver(LON, LAT, mediaroinv(:,:), mediaroinv(:,:),5); %el 5 me ve e, tamaño de las flechas 
title('Invierno')
xlabel('longitud')
ylabel('latitud')
axis tight

subplot(2,2,4)
quiver(LON, LAT, mediaropri(:,:), mediaropri(:,:),5); %el 5 me ve e, tamaño de las flechas 
title('Primavera')
xlabel('longitud')
ylabel('latitud')
axis tight
colorbar


%% 1.2 b
%Grafique el campo de wE en todo el dominio (excluya de sus cálculos de w la banda 
%ecuatorial entre -3°S 3°N). Destaque en la figura el contorno wE = 0 y analice sus
%resultados en términos de regiones de surgencia y sumergencia (hundimiento) e 
%%indique cómo afectan estos procesos la profundidad de la termoclina, haloclína y 
%picnoclina. Para su análisis use las secciones de temperatura, salinidad y densidad
%de WOCE en el Pacífico Sur P06, P18 y P19. Incluya algunas figuras de las 
%transectas en su análisis.


%para eso voy a promediar mis velocidades verticales 
%asi obtengo una grilla de velocidad 
prow=nanmean(w, 3); %promedio anual de las velocidades verticales

%se elimina la banda 3°N y 3°S con operadores logicos 
a1=lat1<3 & lat1>-3;
prow(:,a1)=NaN; %para todas las lon, las lat que esten en 3 y -3 las llene de NaN 


figure()
contourf(lon1, lat1, prow', 'LineColor', 'none')
colormap('redbluecmap')
colorbar
title('Promedio Anual de Velocidades Verticales')
xlabel('Longitud')
ylabel('Latitud')
axis tight



%% 2 Cálculo de la función de corriente de Sverdrup

%a) Calcule la componente meridional del transporte de Sverdrup (V ) en todo el dominio 
%usando los datos promedios de todo el periodo y la relación

%usando un valor promedio de beta
%ese valor promedio lo saque de dinamica de fluidos geof
% beta= 2*exp-11
beta=2*10^(-11); %m^-1s^-1
rho=1025;

%usamos ademas un rotor promedio 
mediarotor=nanmean(WSCurl,3);

%formula sacada de la tarea 
V = mediarotor/(rho*beta);

figure()
contourf(lon1, lat1, V', 'LineColor', 'k')
colormap(jet(8)) % Utilizar la paleta de colores "jet" con 8 colores
colorbar
title('componente meridional del transporte de Sverdrup, REVISAR')
%caxis([-10 10])
xlabel('Longitud')
ylabel('Latitud')
axis tight

%la unica dif con las vel verticales es el orden en que me da este
%resultado

%no se si este bien 

% Integre numéricamente V(x,y0) con respecto a x en una latitud fija (y0) para obtener el 
% transporte meridional integrado en una sección zonal entre la costa de Sudamérica y una 
% posición (longitud) x. 

% 𝑉𝐼𝑛𝑡(𝑥, 𝑦0) = ∫ 𝑉(𝑥, 𝑦𝑜)𝑑𝑥 𝑥
% 𝑥𝑐𝑜𝑠𝑡𝑎 ,

% Realice sus cálculos para 𝑦𝑜 correspondiente a 20°S, 30°S y 40°S. Para las integraciones
% utilice la función de Matlab “cumtrapz.m” (en lugar de “cumsum.m”) (¿Por qué es 
% mejor cumtrapz.m?). 
% Grafique las curvas de la integral en función de x, compare y comente los resultados 
% obtenidos a distintas latitudes. 


%Si tengo que integrar con respecto a x quiere decir que tengo que integrar
%en longitud, 200 longitudes es decir x 


%lon1 va de -119 a -70 y yo para integrar tengo que hacerlo desde afuera de
%la costa, es decir tengo que dar ''vuelta'' mi vector columna para que
%vaya de -70 a -119

%OJO ES V lo que tienes que dar vuelta 
%como las ultimas filas corresponden a la costa y yo quiero integrar desde
%la costa hacia afuera de la costa, tengo que dar vuelta mi vector V 
VV=flipud(V);

lon2=flip(lon1);%aunque iwal damos vuelta nuestro vector lon
%parece que no es necesario darlo vuelta

%e integramos nuestra matriz VV pero como los NaN estarán arriba hacemos un
%pequeño arreglo 

%llenamos lo NaN con ceros, para asi no tener problemas al momento de
%integrar

%busco posiciones con NaN
indices_nan = isnan(VV);
% Reemplazar los elementos NaN por 0
VV(indices_nan) = 0;


y20=cumtrapz(lon1,VV(:,120)); %120 pq en 120 esta la latitud 20, esto lo vi de mi matriz lat1
y30=cumtrapz(lon1,VV(:,80)); %80 pq en la posicion 80 esta la latitud 30
y40=cumtrapz(lon1,VV(:,40));

%ahora que ya integre, mis valores 0 los vuelvo a NaN 
y20(y20==0)=NaN;
y30(y30==0)=NaN;
y40(y40==0)=NaN;



figure()
plot(lon2,y20,'m','linewidth',2)
hold on 
plot(lon2,y30,'c','linewidth',2)
plot(lon2,y40,'k','linewidth',2)
axis tight 
grid on 
legend('lat 20','lat 30','lat 40')


%open gradient %varagin espaciaddo 
%open cumtrapz

%%  3.- Cálculo de la función de corriente de Sverdrup
% a) Calcule numéricamente 
% 𝜕𝑉
% 𝜕𝑦 usando diferencias finitas centradas y use la ecuación de 
% continuidad en la forma 𝜕𝑈/𝜕𝑥 + 𝜕𝑉/𝜕𝑦 = 0 para calcular el transporte zonal U(x, y)

% 𝑈(𝑥, 𝑦0 ) = − ∫ 𝜕𝑉/𝜕𝑦 (𝑥′, 𝑦0)𝑑𝑥′

% Observación: Debe convertir diferencias de latitud y longitud a distancia, para ello debe 
% usar un algoritmo adecuado (indique que algoritmo usa para esta conversión).
% Dado el dominio, note que para el cálculo puede hacer cero todos los valores que están 
% al este de la línea de costa e integrar desde el borde derecho del dominio (de la matriz) 
% hasta x.

clc; clear all

load('WSCurlPSO_12.mat')
WSCurl=WSCurl*(10^-7);
% WSCurl es de 200x240x12
% lon1 es de 200
% lat1 es de 240
lon2=flip(lon1);
beta = 2 * 10^(-11); % m^-1s^-1
rho = 1025;

% Usamos además un rotor promedio 
mediarotor = nanmean(WSCurl, 3);

% Fórmula sacada de la tarea 
V = mediarotor / (rho * beta);

% Calcular la diferencia de longitud y latitud en grados
d_lon = gradient(lon1);
d_lat = gradient(lat1);

% Convertir las diferencias de longitud y latitud a distancias en metros
d_x = double(d_lon * 111000); % 111 km por grado de longitud
d_y = double(d_lat * 111000); % 111 km por grado de latitud

%solo me importa el valor el cual es 27750

%tengo la duda si aca debe ir el 27750 o si debe ir el 0.25 y luego hacer
%la conversion de latitud a metros, pero lo hare altiro

[dV_dy, ~] = gradient(V, 27750,27750); %lo hago asi y no pongo la matriz pq me da una matriz de infinitos


%ahora usando la ecuacion de continuidad
% Aplicar la ecuación de continuidad para obtener el transporte zonal U(x, y)
dU_dx = -dV_dy;


% Integrar para obtener U(x, y) utilizando la función cumtrapz
U = cumtrapz(lon1, dU_dx); %pongo lon1 pq asi lo hice antes 

% Crear una malla de longitud y latitud
[X, Y] = meshgrid(lon1, lat1);

% Graficar el mapa de color del transporte zonal U
figure
pcolor(X, Y, U');
shading interp;
colorbar;
title('Transporte zonal U');
xlabel('Longitud');
ylabel('Latitud');

%% funcion corriente 
% Calcule la función de corriente 𝜓(𝑥, 𝑦) del transporte de Sverdrup. 
% Para una latitud y0 la función de corriente está dada por
% 𝜓(𝑥, 𝑦0) = ∫𝐤∙𝛁×𝛕/𝜌𝛽 𝑑𝑥′ + 𝜓(𝑥𝑐𝑜𝑠𝑡𝑎, 𝑦0)
% donde 𝜓(xcosta, y0) = 0, y x corresponde a las diferentes longitudes (en distancia).
% Grafique la función de corriente usando contornos


psi = cumtrapz(lon1, VV);
psi(indices_nan)=NaN;


figure()
contourf(lon2, lat1, psi', 'LineColor', 'k')
colormap(jet(8)) % Utilizar la paleta de colores "jet" con 8 colores
colorbar
title('componente meridional del transporte de Sverdrup, REVISAR')
xlabel('Longitud')
ylabel('Latitud')
axis tight

