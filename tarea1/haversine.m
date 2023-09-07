function distance = haversine(lat1, lon1, lat2, lon2)
    % Convertir las coordenadas de grados a radianes
    lat1 = deg2rad(lat1);
    lon1 = deg2rad(lon1);
    lat2 = deg2rad(lat2);
    lon2 = deg2rad(lon2);

    % Radio promedio de la Tierra en metros
    r = 6371000;

    % Calcular las diferencias de latitud y longitud
    dlat = lat2 - lat1;
    dlon = lon2 - lon1;

    % Aplicar la fórmula de Haversine
    a = sin(dlat/2)^2 + cos(lat1) * cos(lat2) * sin(dlon/2)^2;
    c = 2 * atan2(sqrt(a), sqrt(1-a));
    distance = r * c;
end
