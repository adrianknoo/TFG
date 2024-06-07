function [DATOS_METEO,Tmax_anual,Year,Mes,Tref,...
    P_suma_anual,P_media_anual,Direccion,Vel_media,Racha,Dia_lluvia,Mes_lluvia,Mes_T]=Meteorologia
    close all;
    %% LECTURA DE DATOS: %%
    DATOS_METEO=readtable("Datos_Graficos_TFG.xlsx", 'Sheet', 7); % Datos meteorológicos.
    Tmax_anual=table2array(DATOS_METEO(14,32:41)); % Vector Tmax anual.
    Year=table2array(DATOS_METEO(1,32:41)); % Vector años del 2014 al 2023.
    Mes=table2cell(DATOS_METEO(2:13,31)); % Vector meses del año.
    Tref=table2array(DATOS_METEO(17,34)); % Valor Tref.
    P_suma_anual=table2array(DATOS_METEO(34,32:41)); % Precipitaciones acumuladas anuales.
    P_media_anual=table2array(DATOS_METEO(37,34)); % Precipitación media mensual.
    Direccion=table2array(DATOS_METEO(2:3556,28)); % Vector dirección predominante de vientos diario.
    Vel_media=table2array(DATOS_METEO(2:3556,13)); % Vector velocidad del viento media diaria.
    Racha=table2array(DATOS_METEO(:,14)); % Vector velocidad racha de viento diaria.
    Mes_T=[Mes(9), Mes(7), Mes(8), Mes(8), Mes(8), Mes(8), Mes(8), Mes(8), Mes(7),Mes(9)];

    %% Gráfico Tref: %%
    figure;
    plot(Year, Tmax_anual, 'Color', '#53E607', 'LineWidth', 2) % Plot de cada Tmax para cada año.
    hold on
    yline(Tref, 'r--', 'LineWidth', 2) % Señalización de la Tref.
    % Utilización de scatter en lugar de plot para marcar puntos:
    scatter(Year, Tmax_anual, 60, '*', 'MarkerEdgeColor', '#475A1A', 'MarkerFaceColor', '#475A1A') 
    set(gca, 'FontSize',12,'TickLabelInterpreter', 'latex')
    title('Temperatura del mes m\''as caluroso entre 2014 y 2023 en la estaci\''on meteorol\''ogica de Llanes', ...
    'FontSize', 20, 'Interpreter', 'latex')
    xlabel('A\~no', 'FontSize', 16, 'Interpreter', 'latex') % Eje x.
    ylabel('Temperatura [$^\circ$C]', 'FontSize', 16, 'Interpreter', 'latex') % Eje y.
    text(Year(6), Tref + 0.05, '$\uparrow$', 'Interpreter', 'latex') % Imprime la flecha hacia arriba.
    text(2018.8, Tref + 0.16, sprintf('$T_{ref} = %.2f \\ ^\\circ C$', Tref), 'FontSize',14,'Interpreter', 'latex') % Imprime la Tref.
    for i = 1:numel(Year)
        % Calcula los desplazamientos x y y para cada texto:
        x_offset = [0.04, 0.04, 0.06, -0.08, -0.49, -0.30, -0.12, -0.14, -0.33, -0.79];
        y_offset = [-0.06, 0.07, 0.06, -0.07, 0.04, 0.07, 0.08, -0.08, 0.06, 0.02];
        % Añade los desplazamientos a las posiciones base:
        x_posicion = Year(i) + x_offset(i);
        y_posicion = Tmax_anual(i) + y_offset(i);
        % Agrega el texto con las posiciones calculadas y el mes correspondiente:
        text(x_posicion, y_posicion, Mes_T{i},'FontSize',14, 'Interpreter', 'latex');
    end
    grid on % Malla.
    legend('Temperaturas del mes m\''as caluroso de cada a\~no', 'Temperatura de referencia del helipuerto', ...
    'Location', 'southoutside', 'Orientation', 'horizontal', 'FontSize', 14, 'Interpreter', 'latex') % Leyenda del gráfico Tref.
    disp(['La temperatura de referencia tiene un valor de: ', num2str(Tref), ' ºC.']);
    %set(gca,'XTickLabel',Year, 'FontSize',12,'TickLabelInterpreter', 'latex')

    %% Gráfico Precipitación total anual: %%
    figure;
    plot(Year,P_suma_anual,'Color','#00A4E6','LineWidth',2) % Plot de cada precipitación acumulada para cada año.
    hold on
    yline(P_media_anual, 'r--','LineWidth',2) % Señalización de la Pref.
    % Utilización de scatter en lugar de plot para marcar puntos:
    scatter(Year,P_suma_anual, 60, '*','MarkerEdgeColor','#0070E6', 'MarkerFaceColor','#475A1A') 
    set(gca, 'FontSize',12,'TickLabelInterpreter', 'latex')
    title('Precipitaci\''on total anual entre 2014 y 2023 en la estaci\''on meteorol\''ogica de Llanes','FontSize',20,'Interpreter','latex') % Título del gráfico Pref.
    xlabel('A\~no','FontSize',16,'Interpreter','latex') % Eje x.
    ylabel('Precipitaci\''on','FontSize',16,'Interpreter','latex') % Eje y.
    for i = 1:numel(Year)
    % Calcula los desplazamientos x y y para cada texto:
        x_offset = [0.1, -0.04, -0.13, -0.51, 0.11, -0.11, -0.47, -0.01, -0.45, -0.52];
        y_offset = [-3.99, 7.97, -9.56, 4.99, -3.03, -15.04, 4.54, 5.04, -0.02, -0.02];
    % Añade los desplazamientos a las posiciones base:
        x_posicion = Year(i) + x_offset(i);
        y_posicion = P_suma_anual(i) + y_offset(i);
    % Agrega el texto con las posiciones calculadas y el año
    % correspondiente:
        text(x_posicion, y_posicion, sprintf('%0.2f', P_suma_anual(i)), 'FontSize',14, 'Interpreter', 'latex');
    end
    text(Year(4)+0.5,P_media_anual+10.55,'$\uparrow$','FontSize',14,'Interpreter','latex') % Imprime la flecha hacia arriba.
    text(2016.7, P_media_anual + 42.60, ...
    sprintf('$\\begin{tabular}{c}Precipitaci\\''on\\\\anual media=%.2f \\ mm \\end{tabular}$', P_media_anual), ...
    'FontSize', 14, 'Interpreter', 'latex')


    grid on % Malla.
    legend('Precipitaci\''on total anual','Precipitaci\''on total anual media',...
    'Location', 'southoutside', 'Orientation', 'horizontal','FontSize',14,'Interpreter','latex') % Leyenda del gráfico Pref.
    
    %% Gráfico Días más lluviosos: %%
    % Precipitación del día más lluvioso de cada año:
    Dia_lluvia=table2array(DATOS_METEO(35,32:41));
    % Precipitación media mensual:
    Mes_lluvia=table2array(DATOS_METEO(21:32,42));
    figure;
    subplot(2,1,1)
    % Plot día más lluvioso de cada año:
    plot(Year, Dia_lluvia,'Color','#53E607','LineWidth',2)
    set(gca, 'XTickLabel', Year,'FontSize',12,'TickLabelInterpreter','latex'); % Etiqueta el eje x con los nombres de los meses,
    set(gca, 'FontSize',12,'TickLabelInterpreter', 'latex')
    title('D\''ia m\''as lluvioso de cada a\~no en la estaci\''on meteorol\''ogica de Llanes','FontSize',20,'Interpreter','latex') % Título.
    xlabel('A\~no','FontSize',16,'Interpreter','latex') % Eje x.
    ylabel('Precipitaci\''on [mm]','FontSize',16,'Interpreter','latex') % Eje y.
    for i = 1:numel(Year)
    % Calcula los desplazamientos x y y para cada texto:
        x_offset = [0.1, -0.04, -0.13, -0.11, -0.11, -0.11, -0.24, -0.11, -0.35, -0.42];
        y_offset = [-3.99, 4.97, 4.56, 4.99, 5.03, 5.04, 4.54, 5.04, -0.02, 0.02];
    % Añade los desplazamientos a las posiciones base:
        x_posicion = Year(i) + x_offset(i);
        y_posicion = Dia_lluvia(i) + y_offset(i);
    % Agrega el texto con las posiciones calculadas y el año
    % correspondiente:
        text(x_posicion, y_posicion, sprintf('%0.2f', Dia_lluvia(i)), 'FontSize',14, 'Interpreter', 'latex');
    end
    grid on % Malla.
    hold on % Aguanta lo que hay en el plot hasta ahora.
    % Marcar los puntos importantes:
    scatter(Year, Dia_lluvia, 60, '*','MarkerEdgeColor','#475A1A', 'MarkerFaceColor','#475A1A')
    legend('Precipitaci\''on del d\''ia m\''as lluvioso','FontSize',14,'Location', 'north', 'Orientation', 'horizontal','Interpreter', 'latex')

    subplot(2,1,2)
    % Plot de la precipitación media mensual:
    plot(Mes_lluvia, '-o','Color','#02FBF7','MarkerEdgeColor','#024AFB','LineWidth',2); % '-o' traza una línea con marcadores circulares en los datos.
    set(gca, 'XTick', 1:12); % Establece las marcas del eje x en los meses.
    set(gca, 'XTickLabel', Mes,'FontSize',12,'TickLabelInterpreter','latex'); % Etiqueta el eje x con los nombres de los meses,
    set(gca, 'FontSize',12,'TickLabelInterpreter', 'latex')
    title('Precipitaci\''on media mensual en la estaci\''on meteorol\''ogica de Llanes','FontSize',20,'Interpreter','latex'); % Título.
    xlabel('Mes','FontSize',16,'Interpreter','latex'); % Eje x.
    ylabel('Precipitaci\''on [mm]','FontSize',16,'Interpreter','latex'); % Eje y.
    grid on % Malla.
    legend('Precipitaci\''on media mensual','FontSize',14,'Location', 'north', 'Orientation', 'horizontal','Interpreter', 'latex')

    %% Porcentaje de días lluviosos y secos: %%
    figure;
    % Obtener los datos de días secos y lluviosos:
    Dias_lluvia_seco = table2array(DATOS_METEO([24,26],6));
    % Mapa de colores:
    map={'#FBFB02','#0228FB'};
    cmap = validatecolor(map, 'multiple');
    colormap(cmap)
    % Gráfico porcentaje de días de lluvia y secos:
    pie(Dias_lluvia_seco)
    title('Frecuencia de precipitaci\''on en la estaci\''on meteorol\''ogica de Llanes','FontSize',20,'Interpreter','latex') % Título.
    legend('D\''ias secos','D\''ias lluviosos','FontSize',14,'Interpreter','latex') % Leyenda.

    %% Rosa de los Vientos: %%
    figure;
    pax = polaraxes; % Definición de ejes polares.
    % Define los límites y colores para cada categoría de velocidad:
    vel_limites = [0, 2, 4, 6, 8, 10, 12];
    colores = ["#4CAF50","#AED581","#FFEB3B","#FBC02D","#F9A825","#FF6F00","#D32F2F"];
    % Etiquetas para las categorías de velocidad:
    etiquetas = {'0 - 2 m/s (0 - 7.2 km/h)', '2 - 4 m/s (7.2 - 14.4 km/h)', '4 - 6 m/s (14.4 - 21.6 km/h)',...
        '6 - 8 m/s (21.6 - 28.8 km/h)', '8 - 10 m/s (28.8 - 36 km/h)', '10 - 12 m/s (36 - 43.2 km/h)',...
        '$>$12 m/s (43.2 km/h)'};
    % Primer histograma polar para velocidades > de 12 m/s.
    polarhistogram(deg2rad(Direccion(Vel_media>=vel_limites(7))),deg2rad(-11.25:22.5:348.75),...
        'FaceColor',colores(7),'displayname',etiquetas{7})
    hold on % Aguanta lo que hay en el plot hasta ahora.

    % Itera sobre cada categoría de velocidad y genera el polarhistogram
    % correspondiente:
    for i = numel(vel_limites)-1:-1:1    
        polarhistogram(deg2rad(Direccion(Vel_media < vel_limites(i+1))),...
            deg2rad(-11.25:22.5:348.75), 'FaceColor', colores(i), 'displayname', etiquetas{i});
    end
    % Configuraciones adicionales:
    pax.ThetaDir = 'clockwise'; % Vector theta en dirección horaria.
    pax.ThetaZeroLocation = 'top'; % Localización de 0º y por ende del Norte.
    legend('Show', 'Location', 'westoutside', 'Orientation', 'vertical', 'FontSize', 14,'Interpreter','latex'); % Leyenda del gráfico.
    set(gca, 'ThetaZeroLocation', 'top'); % Colocar el 0° en la parte superior.
    set(gca, 'ThetaDir', 'clockwise'); % Dirección de las etiquetas en sentido horario
    thetaticks(0:22.5:350); % Etiquetas de ángulo cada 22.5 grados (360/16=22.5º).
    thetaticklabels({'N','NNE','NE','ENE','E','ESE','SE','SSE','S','SSW','SW','WSW','W','WNW','NW','NNW','N'}); % Etiquetas de dirección.
    set(gca, 'FontSize', 12); % Aumentar el tamaño de las etiquetas.
    rticks(0:100:700); % Marcas en el eje radial de 0 a 700, de 100 en 100.

    % Ajustar la posición vertical de la rosa de los vientos:        
    pax.Position = [0.1 0.075 0.8 0.8]; % [left bottom width height].
    disp('Las direcciones preodominantes son WNW y E.');
    set(gca, 'FontSize',12,'TickLabelInterpreter', 'latex')

    % Ajustar la posición vertical del título:
    title('Rosa de los vientos en la estaci\''on meteorol\''ogica de Llanes entre 2014 y 2023', 'FontSize', 20, 'Position', [0 825.5 0],'Interpreter','latex');

    %% Predominancia de velocidades de los vientos: %%
    Vel_Porcentaje=table2array(DATOS_METEO(82,32:38)); % Vector porcentajes de los tramos de velocidades.
    % Etiquetas del eje x para cada barra.
    etiquetas = reordercats(categorical(["0 - 2 m/s (0 - 7.2 km/h)","2 - 4 m/s (7.2 - 14.4 km/h)","4 - 6 m/s (14.4 - 21.6 km/h)",...
    "6 - 8 m/s (21.6 - 28.8 km/h)","8 - 10 m/s (28.8 - 36 km/h)","10 - 12 m/s (36 - 43.2 km/h)","$>$12 m/s (43.2 km/h)"]),...
    ["0 - 2 m/s (0 - 7.2 km/h)","2 - 4 m/s (7.2 - 14.4 km/h)","4 - 6 m/s (14.4 - 21.6 km/h)",...
    "6 - 8 m/s (21.6 - 28.8 km/h)","8 - 10 m/s (28.8 - 36 km/h)","10 - 12 m/s (36 - 43.2 km/h)","$>$12 m/s (43.2 km/h)"]);
    figure;
    hold on
    for i=1:length(Vel_Porcentaje)
        % Bucle que plotea los 7 tramos de velocidad.
        bar(etiquetas(i),Vel_Porcentaje(i),'FaceColor',colores(i))
    end
    grid on
    set(gca, 'XTickLabel', etiquetas, 'FontSize', 12,'TickLabelInterpreter','latex'); % Eje x.
    ylabel('Porcentaje de d\''ias analizados [$\%$]','FontSize',16,'Interpreter','latex') % Eje y.

    % Encuentra el índice del porcentaje máximo
    [~, indice_max] = max(Vel_Porcentaje);
    % Obtiene el rango de velocidades correspondiente al índice máximo
    rango_velocidades_predominante = etiquetas(indice_max);
    % Elimina el máximo para encontrar el segundo máximo
    Vel_Porcentaje(indice_max) = []; % Elimina el máximo encontrado anteriormente
    % Encuentra el índice del nuevo porcentaje máximo (segundo máximo)
    [~, indice_segundo_max] = max(Vel_Porcentaje);
    % Obtiene el rango de velocidades correspondiente al segundo máximo
    rango_segundo_velocidades_predominante = etiquetas(indice_segundo_max);
    % Muestra el mensaje con los rangos de velocidades predominantes
    disp(['Las velocidades predominantes son las que van de ', char(rango_velocidades_predominante),...
        ' seguidas de: ', char(rango_segundo_velocidades_predominante)]);
    set(gca, 'FontSize',12,'TickLabelInterpreter', 'latex')
    title('Predominancia de los diferentes rangos de velocidades','FontSize',20,'Interpreter','latex') % Título predominancia de vientos.

end
