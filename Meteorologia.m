function [DATOS_METEO,Tmax_anual,Mes_Tmax,Year,Mes,Tref,...
    P_suma_anual,P_media_anual,Direccion,Vel_media,Racha,Dia_lluvia,Mes_lluvia]=Meteorologia

%% LECTURA DE DATOS: %%
    DATOS_METEO=readtable("Datos_Graficos_TFG.xlsx", 'Sheet', 7);
    Tmax_anual=table2array(DATOS_METEO(14,32:41));
    Mes_Tmax=table2cell(DATOS_METEO(2:13,31));
    Year=table2array(DATOS_METEO(1,32:41));
    Mes=table2cell(DATOS_METEO(2:13,31));
    Tref=table2array(DATOS_METEO(17,34));
    P_suma_anual=table2array(DATOS_METEO(34,32:41));
    P_media_anual=table2array(DATOS_METEO(37,34));
    Direccion=table2array(DATOS_METEO(2:3556,28));
    Vel_media=table2array(DATOS_METEO(2:3556,13));
    Racha=table2array(DATOS_METEO(:,14));

%% Gráfico Tref: %%
    figure;
    plot(Year, Tmax_anual,'Color','#53E607','LineWidth',2)
    hold on
    yline(Tref, 'r--','LineWidth',2)
    scatter(Year, Tmax_anual, 60, '*','MarkerEdgeColor','#475A1A', 'MarkerFaceColor','#475A1A') % Utilizar plot en lugar de scatter
    title('Temperatura del mes más caluroso entre 2014 y 2023 en la estación meteorológica de Llanes','FontSize',16)
    xlabel('Año','FontSize',14)
    ylabel('Temperatura [ºC]','FontSize',14)
    text(Year(6),Tref+0.05,'\uparrow','Interpreter','tex')
    text(2018.8,Tref+0.11,'Tref=23.88 ºC','Interpreter','tex')
    text(Year(1)+0.04,Tmax_anual(1)-0.06,Mes_Tmax(9),'Interpreter','tex')
    text(Year(2)+0.04,Tmax_anual(2)+0.07,Mes_Tmax(7),'Interpreter','tex')
    text(Year(3)+0.06,Tmax_anual(3)+0.06,Mes_Tmax(8),'Interpreter','tex')
    text(Year(4)+0.04,Tmax_anual(4)-0.04,Mes_Tmax(8),'Interpreter','tex')
    text(Year(5)-0.40,Tmax_anual(5)+0.04,Mes_Tmax(8),'Interpreter','tex')
    text(Year(6)-0.40,Tmax_anual(6)+0.04,Mes_Tmax(8),'Interpreter','tex')
    text(Year(7)+0.04,Tmax_anual(7)+0.04,Mes_Tmax(8),'Interpreter','tex')
    text(Year(8)+0.04,Tmax_anual(8)-0.04,Mes_Tmax(8),'Interpreter','tex')
    text(Year(9)-0.28,Tmax_anual(9)-0.02,Mes_Tmax(7),'Interpreter','tex')
    text(Year(10)-0.62,Tmax_anual(10)+0.02,Mes_Tmax(9),'Interpreter','tex')
    grid on
    legend('Temperaturas del mes más caluroso de cada año','Temperatura de referencia del helipuerto',...
    'Location', 'southoutside', 'Orientation', 'horizontal','FontSize',14)

%% Gráfico Precipitación total anual: %%
    figure;
    plot(Year,P_suma_anual,'Color','#00A4E6','LineWidth',2)
    hold on
    yline(P_media_anual, 'r--','LineWidth',2)
    scatter(Year,P_suma_anual, 60, '*','MarkerEdgeColor','#0070E6', 'MarkerFaceColor','#475A1A')
    title('Precipitación total anual entre 2014 y 2023 en la estación meteorológica de Llanes','FontSize',16)
    xlabel('Año','FontSize',14)
    ylabel('Precipitación [mm]','FontSize',14)
    text(Year(4)+0.5,P_media_anual+10.55,'\uparrow','Interpreter','tex')
    text(2016.7,P_media_anual+22.60,'Precipitación anual media=981.55 mm','Interpreter','tex')
    grid on
    legend('Precipitación total anual','Precipitación total anual media',...
    'Location', 'southoutside', 'Orientation', 'horizontal','FontSize',14)

%% Gráfico Días más lluviosos: %%
    Dia_lluvia=table2array(DATOS_METEO(35,32:41));
    Mes_lluvia=table2array(DATOS_METEO(21:32,42));
    figure;
    subplot(2,1,1)
    plot(Year, Dia_lluvia,'Color','#53E607','LineWidth',2)
    title('Día más lluvioso de cada año en la estación meteorológica de Llanes','FontSize',16)
    xlabel('Año')
    ylabel('Precipitación [mm]')
    grid on
    hold on
    scatter(Year, Dia_lluvia, 60, '*','MarkerEdgeColor','#475A1A', 'MarkerFaceColor','#475A1A')

    subplot(2,1,2)
    plot(Mes_lluvia, '-o','Color','#02FBF7','MarkerEdgeColor','#024AFB','LineWidth',2); % '-o' traza una línea con marcadores circulares en los datos
    set(gca, 'XTick', 1:12); % Establece las marcas del eje x en los meses
    set(gca, 'XTickLabel', Mes); % Etiqueta el eje x con los nombres de los meses
    title('Precipitación media mensual','FontSize',16);
    xlabel('Mes');
    ylabel('Precipitación [mm]');
    grid on

    figure;
    % Obtener los datos de días secos y lluviosos
    Dias_lluvia_seco = table2array(DATOS_METEO([24,26],6));

    map={'#FBFB02','#0228FB'};
    cmap = validatecolor(map, 'multiple');
    colormap(cmap)
    pie(Dias_lluvia_seco)
    title('Frecuencia de precipitación en la estación meteorológica de Llanes','FontSize',18)
    legend('Días secos','Días lluviosos')

%% Gráfico Vientos: %%
    figure;
    % Convertir direcciones de grados a radianes
    angulos_rad = deg2rad(Direccion); % Dividir por 10 para convertir de décimas a grados

    % Crear el gráfico polar de la rosa de los vientos
    polarplot(angulos_rad(Vel_media<2), Vel_media(Vel_media<2), 'g.', 'MarkerSize', 10);
    hold on
    polarplot(angulos_rad(2<=Vel_media&Vel_media<4), Vel_media(2<=Vel_media&Vel_media<4), 'y.', 'MarkerSize', 10);
    polarplot(angulos_rad(4<=Vel_media&Vel_media<6), Vel_media(4<=Vel_media&Vel_media<6), 'b.', 'MarkerSize', 10);
    polarplot(angulos_rad(6<=Vel_media&Vel_media<8), Vel_media(6<=Vel_media&Vel_media<8), 'r.', 'MarkerSize', 10);
    polarplot(angulos_rad(8<=Vel_media&Vel_media<10), Vel_media(8<=Vel_media&Vel_media<10), 'm.', 'MarkerSize', 10);
    polarplot(angulos_rad(10<=Vel_media&Vel_media<12), Vel_media(10<=Vel_media&Vel_media<12), 'c.', 'MarkerSize', 10);
    polarplot(angulos_rad(Vel_media>12), Vel_media(Vel_media>12), 'k.', 'MarkerSize', 10);
    % Configurar las propiedades del gráfico polar
    title('Rosa de los Vientos en la estación meteorológica de Llanes','FontSize',16)
    grid on

    % Personalizar las etiquetas de dirección
    set(gca,'ThetaZeroLocation','top'); % Colocar el 0° en la parte superior
    set(gca,'ThetaDir','clockwise'); % Dirección de las etiquetas en sentido horario
    thetaticks(0:30:330); % Etiquetas de ángulo cada 30 grados
    thetaticklabels({'N','NNE','NE','ENE','E','ESE','SE','SSE','S','SSO','SO','OSO','O','ONO','NO','NNO'});

    % Personalizar las propiedades de los marcadores
    hold on;
    polarplot(0, 0, 'r*', 'MarkerSize', 10); % Marcador para indicar la posición del norte

    % Leyenda
    legend('Velocidad del viento (m/s)', 'Ubicación del norte', 'FontSize', 14,...
        'Location', 'southoutside', 'Orientation', 'horizontal');

%% Rosa de los Vientos: %%
    figure;
    pax = polaraxes;
    polarhistogram(deg2rad(Direccion(Vel_media>=12)),deg2rad(0:20:360),'FaceColor','#D32F2F','displayname','>12 m/s')
    hold on
    polarhistogram(deg2rad(Direccion(Vel_media<=12)),deg2rad(0:20:360),'FaceColor','#FF6F00','displayname','10 - 12 m/s')
    polarhistogram(deg2rad(Direccion(Vel_media<10)),deg2rad(0:20:360),'FaceColor','#F9A825','displayname','8 - 10 m/s')
    polarhistogram(deg2rad(Direccion(Vel_media<8)),deg2rad(0:20:360),'FaceColor','#FBC02D','displayname','6 - 8 m/s')
    polarhistogram(deg2rad(Direccion(Vel_media<6)),deg2rad(0:20:360),'FaceColor','#FFEB3B','displayname','4 - 6 m/s')
    polarhistogram(deg2rad(Direccion(Vel_media<4)),deg2rad(0:20:360),'FaceColor','#AED581','displayname','2 - 4 m/s')
    polarhistogram(deg2rad(Direccion(Vel_media<2)),deg2rad(0:20:360),'FaceColor','#4CAF50','displayname','0 - 2 m/s')
    pax.ThetaDir = 'clockwise';
    pax.ThetaZeroLocation = 'top';
    legend('Show','FontSize',14)
    title('Rosa de los vientos en la estación meteorológica de Llanes','FontSize',16)
    % Personalizar las etiquetas de dirección
    set(gca,'ThetaZeroLocation','top'); % Colocar el 0° en la parte superior
    set(gca,'ThetaDir','clockwise'); % Dirección de las etiquetas en sentido horario
    thetaticks(0:22.5:350); % Etiquetas de ángulo cada 22.5 grados
    thetaticklabels({'N','NNE','NE','ENE','E','ESE','SE','SSE','S','SSW','SW','WSW','W','WNW','NW','NNW','N'});
end
