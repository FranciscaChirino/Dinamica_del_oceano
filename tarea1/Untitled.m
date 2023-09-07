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


figure()
contourf(lon1, lat1, prow', 'LineColor', 'none')
hold on
contour(lon1,lat1,prow',[0 0],'LineColor', 'k','linewidth',2)
colormap(jet(8))
colorbar
title('Promedio Anual de Velocidades Verticales')
xlabel('Longitud')
ylabel('Latitud')
axis tight
caxis([-1e-5 1e-5])
caxis([-1e-6 1e-6])
caxis([-1e-6 0])
figure
contourf(lon1, lat1, prow', 'LineColor', 'none')
pcolor(lon1, lat1, prow'); shading flat
caxis([-1e-5 1e5])
colorbar
caxis([-1e-7 1e7])
figure
pcolor(lon1, lat1, prow'); shading flat; colorbar
caxis([-1e-5 1e-5])
caxis([-0.5e-5 0.5e-5])