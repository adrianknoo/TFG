function [DATOS_Heli,Coordenadas,land,lon]=Helipuertos_Lista

%% LECTURA DE DATOS: %%
    DATOS_Heli=readtable("Prueba.txt"); % Lectura de coordenadas de helipuertos.
    Coordenadas=table2array(DATOS_Heli(:,1:2)); % Vector Coordenadas (Latitud y Longitud).
    land = readgeotable("landareas.shp");
    lat=Coordenadas(:,1); % Vector Latitud.
    lon=Coordenadas(:,2); % Vector longitud.

%% GRÁFICO: %%
    figure;
    worldmap("Spain") % Mapa de España. 
    geoshow(land,"FaceColor",[0.15 0.5 0.15])

    hold on % Mantén el gráfico actual para agregar más elementos
    geoshow(lat, lon, 'DisplayType', 'point', 'Marker', 'o', 'MarkerFaceColor',...
    'red', 'MarkerEdgeColor', 'black', 'MarkerSize', 5); % Ubicaciones.
    title('Ubicación de todos los helipuertos contra incendios de España','FontSize',18) % Título.
end