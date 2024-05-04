function [lat_limit,lon_limit,mapData,Coordenadas_Ast_Cant,Ubicacion]=Asturias_Cantabria

%% LÍMITES DE LATITUD Y LONGITUD: %%
    lat_limit = [42.5, 43.80]; % Límite latitud.
    lon_limit = [-7.20, -3.10]; % Límite longitud.

%% LECTURA DE ARCHIVOS: %%
    mapData = shaperead('recintos_provinciales_inspire_peninbal_etrs89.shp'); % Lectura archivo shapefile de las provincias de España.
    DATOS_Ast_Cant = readtable("Datos_Graficos_TFG.xlsx",'Sheet',6); % Lectura de coordenadas de helipuertos.

%% INPUTS: %%
    Coordenadas_Ast_Cant = table2array(DATOS_Ast_Cant(:,2:3)); % Vector Coordenadas (Latitud y Longitud).
    lat_Ast_Cant = Coordenadas_Ast_Cant(:,1); % Vector Latitud.
    lon_Ast_Cant = Coordenadas_Ast_Cant(:,2); % Vector longitud.
    Ubicacion = table2cell(DATOS_Ast_Cant(:,1));
    colores = ['r', 'g', 'b', 'c', 'm', 'y', 'k']; % Ejemplo de colores: rojo, verde, azul, cyan, magenta, amarillo, negro
    marcadores = {'*', '+', 'o', 'x', 's', '^', 'h'}; % Ejemplo de marcadores: asterisco, más, círculo, cruz, cuadrado, triángulo, hexágono

%% PLOT PUNTOS DESTACABLES CANTABRIA Y ASTURIAS: %%
    figure;
    geoshow(mapData, 'DisplayType', 'polygon', 'FaceColor', [0, 1, 0]) % Color verde: [R, G, B] = [0, 1, 0]
    title('Medios contra incendios de las CC.AA de Asturias y Cantabria','FontSize',18)
    hold on % Mantén el gráfico actual para agregar más elementos
    for i = 1:numel(lat_Ast_Cant)
        geoshow(lat_Ast_Cant(i), lon_Ast_Cant(i), 'DisplayType', 'point', 'Marker', marcadores{mod(i,length(marcadores))+1},...
        'MarkerFaceColor', colores(mod(i,length(colores))+1), 'MarkerEdgeColor', 'black', 'MarkerSize', 10); % Ubicaciones.
    end
    legend(Ubicacion, 'Location', 'southoutside', 'Orientation', 'horizontal');

% Limita los ejes de acuerdo a los límites de latitud y longitud
    xlim(lon_limit)
    ylim(lat_limit)
end
