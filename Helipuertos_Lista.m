clear
clear all
close all

%% LECTURA DE DATOS: %%
%DATOS=readtable("Coordenadas.xlsx"); % Lectura de coordenadas de helipuertos.
DATOS=readtable("Prueba.txt"); % Lectura de coordenadas de helipuertos.
Coordenadas=table2array(DATOS(:,1:2)); % Vector Coordenadas (Latitud y Longitud).
land = readgeotable("landareas.shp");
lat=Coordenadas(:,1); % Vector Latitud.
lon=Coordenadas(:,2); % Vector longitud.

%% GRÁFICO: %%
worldmap("Spain") % Mapa de España. 
geoshow(land,"FaceColor",[0.15 0.5 0.15])

hold on % Mantén el gráfico actual para agregar más elementos
geoshow(lat, lon, 'DisplayType', 'point', 'Marker', 'o', 'MarkerFaceColor',...
    'red', 'MarkerEdgeColor', 'black', 'MarkerSize', 5); % Ubicaciones.
title('Ubicación de todos los helipuertos contra incendios de España','FontSize',18) % Título.
