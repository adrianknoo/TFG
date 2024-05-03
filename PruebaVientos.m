clear 
clear all
close all

%% LECTURA DE DATOS: %%
TEMPERATURAS=readtable("Meteorología.xlsx", 'Sheet', 1);
PRECIPITACIONES=readtable("Meteorología.xlsx", 'Sheet', 2);
VIENTOS=readtable("Meteorología.xlsx", 'Sheet', 3);
Tmax_anual=table2array(TEMPERATURAS(14,6:15));
Mes_Tmax=table2cell(TEMPERATURAS(2:13,5));
Year=table2array(TEMPERATURAS(1,6:15));
Tref=table2array(TEMPERATURAS(17,8));
P_suma_anual=table2array(PRECIPITACIONES(15,6:15));
P_media_anual=table2array(PRECIPITACIONES(17,10));
Direccion=table2array(VIENTOS(:,12))*10;
Vel_media=table2array(VIENTOS(:,13));
Racha=table2array(VIENTOS(:,14));

%% Gráfico Vientos: %%
close all
figure(3)

% Convertir direcciones de decenas de grados a radianes
angulos_rad = deg2rad(Direccion); % Convertir de grados a radianes

% Especificar los límites de los bins
bin_edges = linspace(0, 2*pi, 16); % 16 bins entre 0 y 2*pi

% Normalizar los datos de velocidad para el histograma
vel_normalizada = Vel_media / max(Vel_media);

% Definir límites de velocidad para cada bin
vel_bins = [0, 0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 1.1];

% Crear histogramas polarizados para cada rango de velocidad
for i = 1:length(vel_bins)-1
    indices_vel = find(vel_normalizada > vel_bins(i) & vel_normalizada <= vel_bins(i+1));
    polarhistogram(angulos_rad(indices_vel), bin_edges, 'FaceColor', rand(1,3), 'EdgeColor', 'k');
    hold on
end

% Personalizar las etiquetas de dirección
set(gca,'ThetaZeroLocation','top'); % Colocar el 0° en la parte superior
set(gca,'ThetaDir','clockwise'); % Dirección de las etiquetas en sentido horario
thetaticks(0:22.5:350); % Etiquetas de ángulo cada 22.5 grados
thetaticklabels({'N','NNE','NE','ENE','E','ESE','SE','SSE','S','SSW','SW','WSW','W','WNW','NW','NNW','N'});

% Título y cuadrícula
title('Rosa de los Vientos en Mieres','FontSize',16)
grid on

% Leyenda
legend('Viento menos de 10 m/s','Viento 10-20 m/s','Viento 20-30 m/s','Viento 30-40 m/s','Viento 40-50 m/s',...
    'Viento 50-60 m/s','Viento más de 60 m/s','Location','southoutside','Orientation','horizontal','FontSize',14);
%%
% Inicializar una matriz para almacenar los resultados
a = zeros(7, 16); % Siete rangos de velocidad y 16 ángulos

% Definir los límites de los ángulos
angles = linspace(-pi/16, 15*pi/16, 16);

% Definir los límites de velocidad
vel_ranges = [0, 10, 20, 30, 40, 50, 60, Inf];

% Iterar sobre los rangos de velocidad
for v = 1:numel(vel_ranges)-1
    % Contar cuántos ángulos cumplen las condiciones
    for i = 1:15
        % Se ajustan las condiciones para tener en cuenta los límites de velocidad
        if v == 1
            a(v, i) = length(angulos_rad(Vel_media <= 10 & ...
                angles(i) <= angulos_rad & angulos_rad <= angles(i+1)));
        elseif v == numel(vel_ranges)-1
            a(v, i) = length(angulos_rad(Vel_media > 60 & ...
                angles(i) <= angulos_rad & angulos_rad <= angles(i+1)));
        else
            a(v, i) = length(angulos_rad(Vel_media > vel_ranges(v) & ...
                Vel_media <= vel_ranges(v+1) & ...
                angles(i) <= angulos_rad & angulos_rad <= angles(i+1)));
        end
    end
    % Para el último ángulo
    if v == 1
        a(v, 16) = length(angulos_rad(Vel_media <= 10 & ...
            angles(16) <= angulos_rad & angulos_rad <= angles(1)));
    elseif v == numel(vel_ranges)-1
        a(v, 16) = length(angulos_rad(Vel_media > 60 & ...
            angles(16) <= angulos_rad & angulos_rad <= angles(1)));
    else
        a(v, 16) = length(angulos_rad(Vel_media > vel_ranges(v) & ...
            Vel_media <= vel_ranges(v+1) & ...
            angles(16) <= angulos_rad & angulos_rad <= angles(1)));
    end
end

% Calcular la suma total de cada columna de la matriz "a"
suma_columnas = sum(a);

% Inicializar la matriz "b" con ceros y del mismo tamaño que "a"
b = zeros(size(a));

% Calcular el porcentaje para cada celda de la matriz "a"
for i = 1:size(a, 1)
    for j = 1:size(a, 2)
        b(i, j) = (a(i, j) / suma_columnas(j)) * 100;
    end
end

% Crear histograma polarizado para la matriz b
figure;
polarhistogram('BinEdges', angles, 'BinCounts', b(:), 'FaceColor', 'cyan', 'EdgeColor', 'k');
hold on;

% Personalizar las etiquetas de dirección
set(gca,'ThetaZeroLocation','top'); % Colocar el 0° en la parte superior
set(gca,'ThetaDir','clockwise'); % Dirección de las etiquetas en sentido horario
thetaticks(0:22.5:350); % Etiquetas de ángulo cada 22.5 grados
thetaticklabels({'N','NNE','NE','ENE','E','ESE','SE','SSE','S','SSW','SW','WSW','W','WNW','NW','NNW','N'});

% Título y cuadrícula
title('Histograma de Porcentajes de Dirección y Velocidad del Viento', 'FontSize', 16);
grid on;