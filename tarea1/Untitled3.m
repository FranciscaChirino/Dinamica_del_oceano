
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

subplot(2,2,2)
contourf(lon1, lat1, mediaroot', 'LineColor', 'none')
colormap('redbluecmap')
colorbar
title('Rotor del viento en Otoño')
xlabel('Longitud')
ylabel('Latitud')
caxis([-6*(10^-7) 6*(10^-7)])
axis tight

subplot(2,2,3)
contourf(lon1, lat1, mediaroinv', 'LineColor', 'none')
colormap('redbluecmap')
colorbar
title('Rotor del viento en Invierno')
xlabel('Longitud')
ylabel('Latitud')
caxis([-2*(10^-7) 2*(10^-7)])
axis tight

subplot(2,2,4)
contourf(lon1, lat1, mediaropri', 'LineColor', 'none')
colormap('redbluecmap')
colorbar
title('Rotor del viento en Primavera')
xlabel('Longitud')
ylabel('Latitud')
caxis([-2*(10^-7) 2*(10^-7)])
axis tight



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

% Agregar la etiqueta de unidad al colorbar
c = colorbar;
ylabel(c, '[Pa/m]');

