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
%la pasamos al orden que corresponde 
WSCurl=WSCurl*(10^-7);


%%
%a) Grafique los campos originales del rotor para las distintas estaciones del año. Compare 
%sus resultados con los obtenidos por Bakun y Nelson (1991).

%saco las distintas estaciones, verano, invierno, otoño, primavera 

%pensando que el primer mes es enero


%saco el rotor solo para enero
roenero=WSCurl(:,:,1);

figure()
contourf(lon1, lat1, roenero', 'LineColor', 'k')
colormap(jet(8))
colorbar
title('Rotor del esfuerzo del viento para el mes de Enero')
xlabel('Longitud')
ylabel('Latitud')
caxis([-4*(10^-7) 4*(10^-7)])
axis tight



%verano: diciembre enero febero marzo
%otoño: marzo abril mayo junio 
%invierno: junio julio agosto septiemb re.
%primavera: septiembre octubre noviembre diciembre

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

%grafico con map

% figure()
% subplot(2,2,1)
% contourf(lon1, lat1, mediarover', 'LineColor', 'none')
% colormap('redbluecmap')
% colorbar
% title('Rotor del viento en Verano')
% xlabel('Longitud')
% ylabel('Latitud')
% caxis([-6*(10^-7) 6*(10^-7)])
% axis tight
% 
% subplot(2,2,2)
% contourf(lon1, lat1, mediaroot', 'LineColor', 'none')
% colormap('redbluecmap')
% colorbar
% title('Rotor del viento en Otoño')
% xlabel('Longitud')
% ylabel('Latitud')
% caxis([-6*(10^-7) 6*(10^-7)])
% axis tight
% 
% subplot(2,2,3)
% contourf(lon1, lat1, mediaroinv', 'LineColor', 'none')
% colormap('redbluecmap')
% colorbar
% title('Rotor del viento en Invierno')
% xlabel('Longitud')
% ylabel('Latitud')
% caxis([-2*(10^-7) 2*(10^-7)])
% axis tight
% 
% subplot(2,2,4)
% contourf(lon1, lat1, mediaropri', 'LineColor', 'none')
% colormap('redbluecmap')
% colorbar
% title('Rotor del viento en Primavera')
% xlabel('Longitud')
% ylabel('Latitud')
% caxis([-2*(10^-7) 2*(10^-7)])
% axis tight

  
%con pcolor se ve MUCHO mas lindo 

figure()
subplot(2,2,1)
pcolor(lon1, lat1, mediarover')
shading flat
colormap('jet')
colorbar
title('Rotor del viento en Verano')
xlabel('Longitud')
ylabel('Latitud')
caxis([-4*(10^-7) 4*(10^-7)])
axis tight

% Agregar la etiqueta de unidad al colorbar del subplot 1
c1 = colorbar;
ylabel(c1, '[Pa/m]');

subplot(2,2,2)
pcolor(lon1, lat1, mediaroot')
shading flat
colormap('jet')
colorbar
title('Rotor del viento en Otoño')
xlabel('Longitud')
ylabel('Latitud')
caxis([-4*(10^-7) 4*(10^-7)])
axis tight

% Agregar la etiqueta de unidad al colorbar del subplot 2
c2 = colorbar;
ylabel(c2, '[Pa/m]');

subplot(2,2,3)
pcolor(lon1, lat1, mediaroinv')
shading flat
colormap('jet')
colorbar
title('Rotor del viento en Invierno')
xlabel('Longitud')
ylabel('Latitud')
caxis([-4*(10^-7) 4*(10^-7)])
axis tight

% Agregar la etiqueta de unidad al colorbar del subplot 3
c3 = colorbar;
ylabel(c3, '[Pa/m]');

subplot(2,2,4)
pcolor(lon1, lat1, mediaropri')
shading flat
colormap('jet')
colorbar
title('Rotor del viento en Primavera')
xlabel('Longitud')
ylabel('Latitud')
caxis([-4*(10^-7) 4*(10^-7)])
axis tight

% Agregar la etiqueta de unidad al colorbar del subplot 4
c4 = colorbar;
ylabel(c4, '[Pa/m]');

%% 1.2 b
%Grafique el campo de wE en todo el dominio (excluya de sus cálculos de w la banda 
%ecuatorial entre -3°S 3°N). Destaque en la figura el contorno wE = 0 y analice sus
%resultados en términos de regiones de surgencia y sumergencia (hundimiento) e 
%%indique cómo afectan estos procesos la profundidad de la termoclina, haloclína y 
%picnoclina. Para su análisis use las secciones de temperatura, salinidad y densidad
%de WOCE en el Pacífico Sur P06, P18 y P19. Incluya algunas figuras de las 
%transectas en su análisis.


%% sacamos las velocidades verticales 
%ahora para lat, incluyendo la variacion del parametro de coriolis
rho=1025;
for j=1:240 %lat
for k=1:200 %lon
for i=1:12
    
w(k,j,i)=squeeze(WSCurl(k,j,i))/(rho*(2*7.29*(10^-5)*sind(lat1(j))));
%f(j)=(2*7.29*(10^-5)*sind(lat1(j)));
end
end
end

%sgy estan bien pq me da la mayoria negativa como deberia ser si tengo un
%rotor del viento positivo

%w es una matriz de 3x3 donde tengo las velocidades verticales en una
%grilla de 200x240x12 donde 200 es lon 240 lat 12 meses, es decir una
%velocidad mensual



%para eso voy a promediar mis velocidades verticales 
%asi obtengo una grilla de velocidad 
prow=nanmean(w, 3); %promedio anual de las velocidades verticales

%se elimina la banda 3°N y 3°S con operadores logicos 
a1=lat1<3 & lat1>-3;
prow(:,a1)=NaN; %para todas las lon, las lat que esten en 3 y -3 las llene de NaN 

%mas feo
% figure()
% contourf(lon1, lat1, prow', 'LineColor', 'none')
% hold on
% contour(lon1,lat1,prow',[0 0],'LineColor', 'k','linewidth',2)
% colormap(jet(8))
% colorbar
% caxis([])
% title('Promedio Anual de Velocidades Verticales')
% xlabel('Longitud')
% ylabel('Latitud')
% axis tight

%mas lindo
figure()
pcolor(lon1, lat1, prow')
shading flat
hold on
contour(lon1,lat1,prow',[0 0],'LineColor', 'k','linewidth',2)
colormap('jet')
title('Promedio Anual de Velocidades Verticales')
xlabel('Longitud')
ylabel('Latitud')
axis tight
colorbar
%caxis([-1e-5 1e-5])
caxis([-0.5e-5 0.5e-5])
%le pongo titulo al colorbar
c5 = colorbar;
ylabel(c5, 'm/s');


%% 2 Cálculo de la función de corriente de Sverdrup
%% a) 
%Calcule la componente meridional del transporte de Sverdrup (V ) en todo el dominio 
%usando los datos promedios de todo el periodo y la relación

%usando un valor promedio de beta
%ese valor promedio lo saque de dinamica de fluidos geof
% beta= 2*exp-11
clc;clear all
load('WSCurlPSO_12');
%la pasamos al orden que corresponde 
WSCurl=WSCurl*(10^-7);
beta=2*10^(-11); %m^-1s^-1
rho=1025;

%usamos ademas un rotor promedio 
mediarotor=nanmean(WSCurl,3);

%formula sacada de la tarea 
V = mediarotor/(rho*beta);

%asi ta mas feo

% figure()
% contourf(lon1, lat1, V', 'LineColor', 'k')
% colormap(jet(8)) % Utilizar la paleta de colores "jet" con 8 colores
% colorbar
% title('componente meridional del transporte de Sverdrup, REVISAR')
% xlabel('Longitud')
% ylabel('Latitud')
% axis tight

figure()
pcolor(lon1, lat1, V')
shading flat
colormap('jet')
colorbar
title('Transporte de Svedrup Meridional')
xlabel('Longitud')
ylabel('Latitud')
caxis([-15 15])
axis tight
c5 = colorbar;
ylabel(c5, 'm^2/s');

%% b 

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
clc;clear all
load('WSCurlPSO_12');
%la pasamos al orden que corresponde 
WSCurl=WSCurl;
beta=2*10^(-11); %m^-1s^-1
rho=1025; 
mediarotor=nanmean(WSCurl,3)*(10^-7);
V = mediarotor/(rho*beta);


VV=flipud(V);
%busco posiciones con NaN
indices_nan = isnan(VV);
% Reemplazar los elementos NaN por 0
VV(indices_nan) = 0;
lon2=flip(lon1);%aunque iwal damos vuelta nuestro vector lon
%parece que no es necesario darlo vuelta

%e integramos nuestra matriz VV pero como los NaN estarán arriba hacemos un
%pequeño arreglo 

%llenamos lo NaN con ceros, para asi no tener problemas al momento de
%integrar
d=diff(lon1);
distancia1=haversine(20.125,70.875,20.125+d(1,1),70.875+d(1,1));%20
distancia2=haversine(30.125,72.625,30.125+d(1,1),72.625+d(1,1));%30
distancia3=haversine(40.125,74.625,40.125+d(1,1),74.625+d(1,1));%30
y20=cumtrapz(lon1,VV(:,120))*distancia1; %120 pq en 120 esta la latitud 20, esto lo vi de mi matriz lat1
y30=cumtrapz(lon1,VV(:,80))*distancia2; %80 pq en la posicion 80 esta la latitud 30
y40=cumtrapz(lon1,VV(:,40))*distancia3;


%ahora que ya integre, mis valores 0 los vuelvo a NaN 
y20(y20==0)=NaN;
y30(y30==0)=NaN;
y40(y40==0)=NaN;

figure()
plot(lon2,y20/1e6,'m','linewidth',2) %lo divido en 1e6 para dejarlo en svedrup pq un svedrup es 1e6 m^3/s
hold on 
plot(lon2,y30/1e6,'c','linewidth',2)
plot(lon2,y40/1e6,'k','linewidth',2)
xlabel('longitud')
ylabel('Svedrup')
axis tight 
grid on 
legend('lat 20','lat 30','lat 40')



%% funcion corriente 
% Calcule la función de corriente 𝜓(𝑥, 𝑦) del transporte de Sverdrup. 
% Para una latitud y0 la función de corriente está dada por
% 𝜓(𝑥, 𝑦0) = ∫𝐤∙𝛁×𝛕/𝜌𝛽 𝑑𝑥′ + 𝜓(𝑥𝑐𝑜𝑠𝑡𝑎, 𝑦0)
% donde 𝜓(xcosta, y0) = 0, y x corresponde a las diferentes longitudes (en distancia).
% Grafique la función de corriente usando contornos

clc;clear all
load('WSCurlPSO_12');
%la pasamos al orden que corresponde 
WSCurl=WSCurl*(10^-7);
beta=2*10^(-11); %m^-1s^-1
rho=1025; 
mediarotor=nanmean(WSCurl,3);

V = mediarotor/(rho*beta);

VV=flipud(V);
lon2=flip(lon1);


% pasamos el vector de longitud en grados a distancia en metros


% Radio de la Tierra en metros
R = 6371e3; % Aproximadamente 6,371 kilómetros o 6,371,000 metros

% Convertir longitud en distancia en metros
lon1_rad = deg2rad(lon1);
distancia = R * lon1_rad;



%para poder integrar,los valores NaN los pasamos a cero
%busco posiciones con NaN
indices_nan = isnan(VV);
% Reemplazar los elementos NaN por 0
VV(indices_nan) = 0;

%integramos
psi = cumtrapz(distancia, VV);
%ahora que integramos vuelvo a colocar los valores NaN para asi en el
%grafico poder observar el continente 
psi(indices_nan)=NaN;
pssi=flipud(psi);


figure()
contourf(lon2, lat1, psi'/1e6, 'LineColor', 'k')
hold on
contour(lon1,lat1,pssi',[0 0],'LineColor', 'k','linewidth',4)
colormap(jet(8)) % Utilizar la paleta de colores "jet" con 8 colores
colorbar
title('Función Corriente')
xlabel('Longitud')
ylabel('Latitud')
axis tight

%este si q si
figure()
contourf(lon2, lat1, psi'/1e6, 'LineColor', 'k')
hold on
contour(lon1,lat1,pssi',[0 0],'LineColor', 'k','linewidth',4)
colormap(jet(8)) % Utilizar la paleta de colores "jet" con 8 colores
colorbar
title('Función Corriente')
xlabel('Longitud')
ylabel('Latitud')
axis tight

% Obtener las coordenadas de los contornos y sus valores
[C, h] = contour(lon2, lat1, psi'/1e6, 'LineColor', 'k');
clabel(C, h, 'Color', 'k', 'FontSize', 10, 'FontWeight', 'bold');

% Mostrar los valores de los contornos en el gráfico





figure()
pcolor(lon2, lat1, psi'/1e6)
shading flat
colormap('jet')
colorbar
title('Función corriente')
xlabel('Longitud')
ylabel('Latitud')
axis tight











