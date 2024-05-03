
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
bin_edges = linspace(0, 2*pi, 32); % 36 bins entre 0 y 2*pi

% Inicializar una matriz para almacenar los resultados
a = zeros(7, 16); % Siete rangos de velocidad y 16 ángulos

% Definir los límites de los ángulos
angles = linspace(0, 2*pi, 16);

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
a11=length(angulos_rad(Vel_media <= 10 & 3*pi/32<=angulos_rad<=5*pi/32));
a11=length(angulos_rad(Vel_media <= 10 & 3*pi/32<=angulos_rad<=5*pi/32));
a11=length(angulos_rad(Vel_media <= 10 & 3*pi/32<=angulos_rad<=5*pi/32));
a11=length(angulos_rad(Vel_media <= 10 & 3*pi/32<=angulos_rad<=5*pi/32));

a2=length(angulos_rad(Vel_media > 10 & Vel_media <= 20));
a3=length(angulos_rad(Vel_media > 20 & Vel_media <= 30));
a4=length(angulos_rad(Vel_media > 30 & Vel_media <= 40));
a5=length(angulos_rad(Vel_media > 40 & Vel_media <= 50));
a6=length(angulos_rad(Vel_media > 50 & Vel_media <= 60));
a7=length(angulos_rad(Vel_media > 60));

% Crear histogramas para cada rango de velocidad y especificar colores
polarhistogram(a1, bin_edges,'FaceColor','#1D5908');


hold on
polarhistogram(a2, bin_edges,'FaceColor','r'); %#3FB814

polarhistogram(a3, bin_edges,'FaceColor','#9BF979');
polarhistogram(a4, bin_edges,'FaceColor','#E6FFDD');
polarhistogram(a5, bin_edges,'FaceColor','#EFFE06');
polarhistogram(a6, bin_edges,'FaceColor',"#F59A06");
polarhistogram(a7, bin_edges,'FaceColor',"#F53906");


legend('Viento menos de 10 m/s','Viento 10-20 m/s','Viento 20-30 m/s','Viento 30-40 m/s','Viento 40-50 m/s',...
    'Viento 50-60 m/s','Viento más de 60 m/s')
title('Rosa de los Vientos en Mieres','FontSize',16)
grid on

% Personalizar las etiquetas de dirección
set(gca,'ThetaZeroLocation','top'); % Colocar el 0° en la parte superior
set(gca,'ThetaDir','clockwise'); % Dirección de las etiquetas en sentido horario
thetaticks(0:22.5:350); % Etiquetas de ángulo cada 22.5 grados
thetaticklabels({'N','NNE','NE','ENE','E','ESE','SE','SSE','S','SSW','SW','WSW','W','WNW','NW','NNW','N'});

