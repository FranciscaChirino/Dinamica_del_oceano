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
%para integrar desde la costa
VV=flipud(V);

indices_nan = isnan(VV);
% Reemplazar los elementos NaN por 0
VV(indices_nan) = 0;

[dV_dy, ~] = gradient(VV, 27750);
%[~, dV_dyy] = gradient(VV, 27750); %no se cual esta bien 

%ahora usando la ecuacion de continuidad
% Aplicar la ecuación de continuidad para obtener el transporte zonal U(x, y)
dU_dx = -dV_dy;






% Integrar para obtener U(x, y) utilizando la función cumtrapz
U = cumtrapz(lon1, dU_dx); %pongo lon1 pq asi lo hice antes 
U(indices_nan)=NaN;
% distanciaa=distanciaa';
% 
% for i=1:200
%     W=U(i,:)*distanciaa(i);
% 
% end
% U=U*distancia;

figure()
contourf(lon2, lat1, U'*1e4, 'LineColor', 'k')
colormap(jet(8)) % Utilizar la paleta de colores "jet" con 8 colores
colorbar
title('transporte zonal')
xlabel('Longitud')
ylabel('Latitud')
axis tight



