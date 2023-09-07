% 1) A partir de los datos de velocidad del viento en el archivo VientosCosteros.mat
% calcule las series de tiempo del transporte de Ekman hacia fuera de la costa (dirección x)

% 𝑀𝑥 = 𝜏𝑦 /  𝜌𝑓

% La coordenada “y” representa la dirección a lo largo de la costa. 
% Note que los vientos están dados en coordenadas Norte (componente V) y Este 
% (componente U). Por lo tanto, debe rotar adecuadamente los vectores para obtener 
% componentes a lo largo de la costa (Tau_y) y la componente perpendicular a la costa
% (Tau_x).

% El archivo contiene las matrices Ui, Vi y fecha. Ui y Vi contienen tres columnas 
% correspondientes a promedios diarios de las velocidades del viento en 37°S, 30°S y 
% 21°S. La matriz fecha contiene [año mes día hr min s] (los últimos tres datos son cero).

% Use una densidad para el agua de mar de ρ = 1025 kg m^3
% y un valor del parámetro de 
% Coriolis (f ) correspondiente a la latitud indicada.
% Ayuda. Para calcular el esfuerzo del viento (a partir de la velocidad) use la relación 
% 𝛕 = 𝜌𝐶𝐷|𝐖|𝐖,
% donde ρ es la densidad del aire (use 1.2 kg m^3)
%  CD es un coeficiente de arrastre (use un 
% valor constante de 1.3*10-3
% , el coeficiente de arrastre es adimensional). W es el vector 
% velocidad del viento y |W| es su magnitud, |W| = (Wx^2 + Wy^2 )^1/2
% 
% Comente el valor de CD dado (constante) en relación con la Figura 9.14 del libro de 
% Pond & Pickard (1983).
% Grafique las series de Transporte de Ekman en las 3 localidades y analice los 
% resultados en el marco de la variabilidad sinóptica de la surgencia comparando las 
% tres localidades. Comúnmente el transporte de Ekman perpendicular a la costa se 
% utiliza como un Índice de Surgencia, conocido también como Indice de Bakun (debido 
% al trabajo de Bakun, 1973). 

clear all 
clc
load('VientosCosteros.mat');

%% latitud 37 


%trabajemos primero con la latitud 37 

%para rotar los vectores significa que tengo que dejar los vectores que
%están en un marco norte este a la direccion de la costa 

%para eso sacamos el angulo alfa que sera el angulo desde el norte al
%vector 

alfa= atand(Ui(:,1)./Vi(:,1)); %en grados

aux=find(Ui(:,1)>0 & Vi(:,1)<0 );
alfa(aux)=alfa(aux)+180;
aux2=find(Ui(:,1)<=0 & Vi(:,1) < 0);
alfa(aux2)=alfa(aux2)-180;

clear aux aux2

%magnitud de la velocidad del viento W
mag_W = sqrt((Vi(:,1).^2) + (Ui(:,1).^2));



%calculamos los nuevos componentes en el marco de referencia de la costa
%estos 30 grados corresponden 30 grados con respecto al norte y la costa de
%concepcion 37° esto lo vi en google maps 

y_c = mag_W.*cosd(alfa-30);
x_c = mag_W.*sind(alfa-30);


%calculamos tau 
rho_mar = 1025; %kg/m^3
rho_aire = 1.2; %kg/m^3
cd = 1.3e-3;



tau_y = rho_aire*cd*y_c.*mag_W;

%transporte

M_x37 = tau_y ./ (rho_mar*2*7.292e-5*sind(-37));



fechas = datenum(fecha(:,1),fecha(:,2),fecha(:,3));
figure()
plot(fechas(:,1),M_x37,'m')
datetick('x','yyyy')
title('Transporte de Ekman fuera de la costa 37°S')
xlabel('Años')
ylabel('transporte en x [m^2/s]')
axis tight
grid on




%% 30 

alfa= atand(Ui(:,2)./Vi(:,2)); %en grados

aux=find(Ui(:,2)>0 & Vi(:,2)<0 );
alfa(aux)=alfa(aux)+180;
aux2=find(Ui(:,2)<=0 & Vi(:,2) < 0);
alfa(aux2)=alfa(aux2)-180;

clear aux aux2

%magnitud de la velocidad del viento W
mag_W = ((Vi(:,2)).^2 + (Ui(:,2)).^2).^(1/2);



%calculamos los nuevos componentes en el marco de referencia de la costa
%estos 30 grados corresponden 5 grados con respecto al norte y la costa de
%serena 5° esto lo vi en google maps 

y_c = mag_W.*cosd(alfa-5);
x_c = mag_W.*sind(alfa-5);


%calculamos tau 
tau_y = rho_aire*cd*y_c.*mag_W;

%transporte
M_x30 = tau_y ./ (rho_mar*2*7.292e-5*sind(-30));
fechas = datenum(fecha(:,1),fecha(:,2),fecha(:,3));

figure()
plot(fechas(:,1),M_x30,'m')
datetick('x','yyyy')
title('Transporte de Ekman fuera de la costa 30°S')
xlabel('Años')
ylabel('transporte en x [m^2/s]')
axis tight
grid on



%% 21

alfa= atand(Ui(:,3)./Vi(:,3)); %en grados

aux=find(Ui(:,3)>0 & Vi(:,3)<0 );
alfa(aux)=alfa(aux)+180;
aux2=find(Ui(:,3)<=0 & Vi(:,3) < 0);
alfa(aux2)=alfa(aux2)-180;

clear aux aux2

%magnitud de la velocidad del viento W
mag_W = (((Vi(:,3)).^2) + ((Ui(:,3)).^2)).^(1/2);



%calculamos los nuevos componentes en el marco de referencia de la costa
%estos 30 grados corresponden 3 grados con respecto al norte y la costa de
%iquique 3° esto lo vi en google maps 

y_c = mag_W.*cosd(alfa-3);
x_c = mag_W.*sind(alfa-3);


%calculamos tau 
tau_y = rho_aire*cd*y_c.*mag_W;

%transporte
M_x21 = tau_y ./ (rho_mar*2*7.292e-5*sind(-21));
fechas = datenum(fecha(:,1),fecha(:,2),fecha(:,3));

figure()
plot(fechas(:,1),M_x21,'m')
datetick('x','yyyy')
title('Transporte de Ekman fuera de la costa 21°S')
xlabel('Años')
ylabel('transporte en x [m^2/s]')
axis tight
grid on



%%

% 2) Calcule el ciclo anual del transporte de Ekman promediando todos los valores de 
% enero, todos los de febreros y así hasta diciembre. Grafique el ciclo anual. Considere el 
% transporte de Ekman como un Índice de Surgencia (IS) y analice la figura de los ciclos 
% anuales en términos de la variabilidad anual de la surgencia y como estos varían en 
% las diferentes latitudes.
% 

%calculamos el ciclo anual para el transporte en x



% aux=find(fecha(:,2)==1);
% promedio1=nanmean(M_x(aux));
% 
% aux=find(fecha(:,2)==2);
% promedio2=nanmean(M_x(aux));
% 
% aux=find(fecha(:,2)==7);
% promedio7=nanmean(M_x(aux));


for i=1:12

aux=find(fecha(:,2)==i);
promedio_37(i)=nanmean(M_x37(aux));
promedio_30(i)=nanmean(M_x30(aux));
promedio_21(i)=nanmean(M_x21(aux));

end



figure()
subplot 311
plot(1:12,promedio_37,'m')
title('Promedio Transporte de Ekman fuera de la costa 37°S')
xlabel('Años')
ylabel('Promedio transporte [m^2/s]')
axis tight
grid on

subplot 312
plot(1:12,promedio_30,'m')
title('Promedio Transporte de Ekman fuera de la costa 30°S')
xlabel('Años')
ylabel('promedio transporte en x [m^2/s]')
axis tight
grid on


subplot 313
plot(1:12,promedio_21,'m')
title('Transporte de Ekman fuera de la costa 21°S')
xlabel('Años')
ylabel('promedio transporte en x [m^2/s]')
axis tight
grid on


figure()
plot(1:12,promedio_37,'m','linewidth',3)
hold on 
plot(1:12,promedio_30,'c','linewidth',3)
plot(1:12,promedio_21,'y','linewidth',3)
title('Promedio Transporte de Ekman fuera de la costa')
xlabel('Años')
ylabel('promedio transporte en x [m^2/s]')
legend('37°S','30°S','21°S')
axis tight
grid on




%% 3 

% 3) Considere que el transporte hacia fuera de la costa tiene lugar en una capa superficial 
% de profundidad hE = 20 m y que este transporte es compensado por un transporte vertical 
% (hacia la capa superficial) en una distancia L desde la costa (ver esquema en figura 
% abajo y sus apuntes de clases). La distancia L puede ser relacionada con el radio de 
% deformación interno de Rossby dado por LR = ci / f , donde ci es la velocidad de fase de 
% una onda larga interna de gravedad. Use ci = 3 m s-1
% y f correspondiente a la latitud dada
% en cada caso.


% i) Calcule las series de velocidades verticales en cada localidad (en m/día).
% Grafique un histograma mostrando los porcentajes de velocidades verticales 
% que caen en los intervalos entre -5 m/día y 10 m/día (cada 1 m/día, ver 
% figura de ejemplo), para las distintas estaciones del año (considere verano
% igual al periodo Ene-Mar, otoño AbrJun y así sucesivamente).


% w se calcula como

% la primera opcion 
%w = M_x/Lr



%% 37 

%el transporte de ekmann tiene unidades de m^2/s


L_37=3/(2*7.292e-5*sind(-37)); %c/f

w37 = (M_x37)/(L_37);

%lo pasamos a m/dia 60*60*24

w37_diarios = w37*60*60*24;



% figure()
% histogram(w37_diarios)


figure()
histogram(w37_diarios, 'Normalization', 'probability');
ytix = get(gca, 'YTick');
set(gca, 'YTick',ytix, 'YTickLabel',ytix*100);
ylabel('Porcentaje [%]')


% Obtener las fechas correspondientes a cada estación del año
verano_fechas =find( fecha(:,2) >= 1 & fecha(:,2) <= 3);
otono_fechas = find(fecha(:,2) >= 4 & fecha(:,2) <= 6);
invierno_fechas = find(fecha(:,2) >= 7 & fecha(:,2) <= 9);
primavera_fechas = find(fecha(:,2) >= 10 & fecha(:,2) <= 12);
% Calcular las velocidades verticales para cada estación del año y localidad
verano = w37_diarios(verano_fechas, :);
otono = w37_diarios(otono_fechas, :);
invierno = w37_diarios(invierno_fechas, :);
primavera = w37_diarios(primavera_fechas, :);


figure()
subplot 221
histogram(verano,-5:1:10,'Normalization', 'probability','FaceColor', 'm');
ytix = get(gca, 'YTick');
set(gca, 'YTick',ytix, 'YTickLabel',ytix*100);
xlabel('[m/día]')
ylabel('Porcentaje [%]')
title('Velocidades verticales en Verano a 37°S')
grid on 
axis tight

subplot 222
histogram(otono,-5:1:10, 'Normalization', 'probability','facecolor','m');
ytix = get(gca, 'YTick');
set(gca, 'YTick',ytix, 'YTickLabel',ytix*100);
ylabel('Porcentaje [%]')
xlabel('[m/día]')
title('Velocidades verticales en Otoño 37°S')
grid on 
axis tight

subplot 223
histogram(invierno,-5:1:10, 'Normalization', 'probability','facecolor','m');
ytix = get(gca, 'YTick');
set(gca, 'YTick',ytix, 'YTickLabel',ytix*100);
ylabel('Porcentaje [%]')
xlabel('[m/día]')
title('Velocidades verticales en Invierno a 37°S')
grid on 
axis tight

subplot 224
histogram(primavera,-5:1:10, 'Normalization', 'probability','facecolor','m');
ytix = get(gca, 'YTick');
set(gca, 'YTick',ytix, 'YTickLabel',ytix*100);
ylabel('Porcentaje [%]')
xlabel('[m/día]')
title('Velocidades verticales en Primavera a 37°S')
grid on 
axis tight

%% 30 


L_30=3/(2*7.292e-5*sind(-30)); %c/f


w30 = (M_x30)/(L_30);

%lo pasamos a m/dia 60*60*24

w30_diarios = w30*60*60*24;

% figure()
% histogram(w30_diarios)


% Calcular las velocidades verticales para cada estación del año y localidad
verano = w30_diarios(verano_fechas, :);
otono = w30_diarios(otono_fechas, :);
invierno = w30_diarios(invierno_fechas, :);
primavera = w30_diarios(primavera_fechas, :);


figure()
subplot 221
histogram(verano,-5:1:10,'Normalization', 'probability','FaceColor', 'm');
ytix = get(gca, 'YTick');
set(gca, 'YTick',ytix, 'YTickLabel',ytix*100);
xlabel('[m/día]')
ylabel('Porcentaje [%]')
title('Velocidades verticales en Verano a 30°')
grid on 
axis tight

subplot 222
histogram(otono,-5:1:10, 'Normalization', 'probability','facecolor','m');
ytix = get(gca, 'YTick');
set(gca, 'YTick',ytix, 'YTickLabel',ytix*100);
ylabel('Porcentaje [%]')
xlabel('[m/día]')
title('Velocidades verticales en Otoño 30°S')
grid on 
axis tight

subplot 223
histogram(invierno,-5:1:10, 'Normalization', 'probability','facecolor','m');
ytix = get(gca, 'YTick');
set(gca, 'YTick',ytix, 'YTickLabel',ytix*100);
ylabel('Porcentaje [%]')
xlabel('[m/día]')
title('Velocidades verticales en Invierno a 30°S')
grid on 
axis tight

subplot 224
histogram(primavera,-5:1:10, 'Normalization', 'probability','facecolor','m');
ytix = get(gca, 'YTick');
set(gca, 'YTick',ytix, 'YTickLabel',ytix*100);
ylabel('Porcentaje [%]')
xlabel('[m/día]')
title('Velocidades verticales en Primavera a 30°S')
grid on 
axis tight


%% 21 


L_21=3/(2*7.292e-5*sind(-21)); %c/f


w21 = (M_x21)/(L_21);

%lo pasamos a m/dia 60*60*24

w21_diarios = w21*60*60*24;

%  figure()
%  histogram(w21_diarios)


verano = w21_diarios(verano_fechas, :);
otono = w21_diarios(otono_fechas, :);
invierno = w21_diarios(invierno_fechas, :);
primavera = w21_diarios(primavera_fechas, :);


figure()
subplot 221
histogram(verano,-5:1:10,'Normalization', 'probability','FaceColor', 'm');
ytix = get(gca, 'YTick');
set(gca, 'YTick',ytix, 'YTickLabel',ytix*100);
xlabel('[m/día]')
ylabel('Porcentaje [%]')
title('Velocidades verticales en Verano a 21°S')
grid on 
axis tight

subplot 222
histogram(otono,-5:1:10, 'Normalization', 'probability','facecolor','m');
ytix = get(gca, 'YTick');
set(gca, 'YTick',ytix, 'YTickLabel',ytix*100);
ylabel('Porcentaje [%]')
xlabel('[m/día]')
title('Velocidades verticales en Otoño a 21°S')
grid on 
axis tight

subplot 223
histogram(invierno,-5:1:10, 'Normalization', 'probability','facecolor','m');
ytix = get(gca, 'YTick');
set(gca, 'YTick',ytix, 'YTickLabel',ytix*100);
ylabel('Porcentaje [%]')
xlabel('[m/día]')
title('Velocidades verticales en Invierno a 21°S')
grid on 
axis tight

subplot 224
histogram(primavera,-5:1:10, 'Normalization', 'probability','facecolor','m');
ytix = get(gca, 'YTick');
set(gca, 'YTick',ytix, 'YTickLabel',ytix*100);
ylabel('Porcentaje [%]')
xlabel('[m/día]')
title('Velocidades verticales en Primavera a 21°S')
grid on 
axis tight



%% 4

% 4) Considere la serie de 37°S durante el verano del año 2000 (1 enero al 31 marzo) y 
% a) Grafique (puede usar un gráfico de barras) la serie de tiempo del esfuerzo del viento 
% paralelo a la costa (promedios diarios de Tau_y) durante el periodo. 
% Describa los eventos de surgencia (según los datos de esfuerzo del viento) en este 
% periodo: duración del evento, intensidad promedio y máxima del esfuerzo de viento 
% (Tau_y) durante el evento de surgencia. Compare la magnitud promedio de Tau_y
% durante los eventos con la magnitud promedio de Tau_y del verano de 2000 (enero a 
% marzo).

clear all 
clc
load('VientosCosteros.mat');

% sacamos el año que nos interesa 2000 (1 enero 31 marzo)

Ui=Ui(166:256,1);
Vi=Vi(166:256,1);

fecha=fecha(166:256,:);

%una vez recortado el año que me interesa roto el sistema de coordenadas

alfa= atand(Ui(:,1)./Vi(:,1)); %en grados

aux=find(Ui(:,1)>0 & Vi(:,1)<0 );
alfa(aux)=alfa(aux)+180;
aux2=find(Ui(:,1)<=0 & Vi(:,1) < 0);
alfa(aux2)=alfa(aux2)-180;

clear aux aux2

%magnitud de la velocidad del viento W
mag_W = sqrt((Vi(:,1).^2) + (Ui(:,1).^2));



%calculamos los nuevos componentes en el marco de referencia de la costa
%estos 30 grados corresponden 30 grados con respecto al norte y la costa de
%concepcion 37° esto lo vi en google maps 

y_c = mag_W.*cosd(alfa-30);
x_c = mag_W.*sind(alfa-30);


%calculamos tau 
rho_mar = 1025; %kg/m^3
rho_aire = 1.2; %kg/m^3
cd = 1.3e-3;



tau_y = rho_aire*cd*y_c.*mag_W;


figure()
bar(datenum(fecha), tau_y,'m')
datetick('x', 'dd-mmm', 'keepticks')
xlabel('Fecha')
ylabel('Esfuerzo de Viento \tau_y [Pa]')
title('Esfuerzo del viento para el año 2000')
grid on
axis tight


% b) Calcule el impulso I del viento para los eventos del 7 al 11 de enero de 2000 y del 13 
% al 27 de enero de 2020.

% vuelvo a cortar los datos de la fecha que me interesa


clear all 
clc
load('VientosCosteros.mat');


%del 7 al 11 enero del 2000

Ui_2000=Ui(172:176,1);
Vi_2000=Vi(172:176,1);

fecha=fecha(172:176,:);
alfa= atand(Ui_2000(:,1)./Vi_2000(:,1)); %en grados


aux=find(Ui_2000(:,1)>0 & Vi_2000(:,1)<0 );
alfa(aux)=alfa(aux)+180;
aux2=find(Ui_2000(:,1)<=0 & Vi_2000(:,1) < 0);
alfa(aux2)=alfa(aux2)-180;

clear aux aux2

%magnitud de la velocidad del viento W
mag_W = sqrt((Vi_2000(:,1).^2) + (Ui_2000(:,1).^2));
 

y_c = mag_W.*cosd(alfa-30);
x_c = mag_W.*sind(alfa-30);


%calculamos tau 
rho_mar = 1025; %kg/m^3
rho_aire = 1.2; %kg/m^3
cd = 1.3e-3;
H=50;

tau_y2000 = rho_aire*cd*y_c.*mag_W;

% Calculo del impulso
%pasamos los dias a segundos para hacer concordar las unidades de medida
I_2000 = (1 / (rho_mar * H)) * trapz((7:11)*86400, tau_y2000);



%%
% del 13 al 27 de enero de 2000


clear all 
clc
load('VientosCosteros.mat');


%del 7 al 11 enero del 2000

Ui_2000=Ui(178:192,1);
Vi_2000=Vi(178:192,1);

fecha=fecha(178:192,:);

alfa= atand(Ui_2000(:,1)./Vi_2000(:,1)); %en grados

aux=find(Ui_2000(:,1)>0 & Vi_2000(:,1)<0 );
alfa(aux)=alfa(aux)+180;
aux2=find(Ui_2000(:,1)<=0 & Vi_2000(:,1) < 0);
alfa(aux2)=alfa(aux2)-180;

clear aux aux2

%magnitud de la velocidad del viento W
mag_W = sqrt((Vi_2000(:,1).^2) + (Ui_2000(:,1).^2));
 

y_c = mag_W.*cosd(alfa-30);
x_c = mag_W.*sind(alfa-30);


%calculamos tau 
rho_mar = 1025; %kg/m^3
rho_aire = 1.2; %kg/m^3
cd = 1.3e-3;
H=50;

tau_y2000 = rho_aire*cd*y_c.*mag_W;


% Calculo del impulso
%pasamos los dias a segundos para que de bien los valores de impulso
I_2020 = 1 / (rho_mar * H) * trapz((13:27)*86400, tau_y2000);


%% Graficamos el perfil de velocidad
g=(2.5)^2 / 50;
A_E1=0.5 * sqrt(50 / 0.1250);
LR=3/(2 * 7.292e-5 * sind(-37));
x=linspace(0, LR, 100);
R=(2.5)/(2 * 7.292e-5 * sind(-37));
for i = 1:length(x)
 v_E1(i)=A_E1*sqrt(0.1250/50)*exp(-x(i)/R);
end
d=3.0380/(2*7.292e-5*sind(-37))-R;
A_E2=50*exp(d/R);
for i = 1:length(x)
 v_E2(i)=A_E2*sqrt(0.1250 / 50)*exp(-x(i)/R);
end

figure()
plot(-x, v_E1,'m','linewidth',3)
hold on
plot(-x,v_E2,'c','linewidth',3)
legend('Evento 1','Evento 2')
ylabel('[m/s]')
xlabel('distancia desde la costa hacia fuera de esta [m]')
title('Chorro costero para evento 1 y evento 2')
grid on 
axis tight






































