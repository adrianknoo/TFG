function [PRESUPUESTO_DATOS,Grupo,Subgrupos,Costes_Totales,Pintura,Pintura_Blanca,Pintura_Amarilla,Terreno,Edificaciones,Equipamiento,Licencias]=Presupuesto
    PRESUPUESTO_DATOS = readtable("Presupuesto.xlsx", 'Sheet', 2);
    Grupo = table2cell(PRESUPUESTO_DATOS(1:6,9));
    Subgrupos = table2cell(PRESUPUESTO_DATOS(:,12));
    Costes_Totales = table2array(PRESUPUESTO_DATOS(1:7,15));
    Pintura=table2array(PRESUPUESTO_DATOS(1:2,13));
    Pintura_Blanca = table2array(PRESUPUESTO_DATOS(1:4,5));
    Pintura_Amarilla = table2array(PRESUPUESTO_DATOS(5:8,5));
    Terreno=table2array(PRESUPUESTO_DATOS(9:13,4));
    Edificaciones=table2array(PRESUPUESTO_DATOS([7,10],13));
    Edif=table2array(PRESUPUESTO_DATOS(10,13));
    Equipamiento = table2array(PRESUPUESTO_DATOS(3:4,13));
    Luces = table2array(PRESUPUESTO_DATOS(11:15,13));
    Licencias=table2array(PRESUPUESTO_DATOS(43:46,4));
    Personal=table2array(PRESUPUESTO_DATOS(69:74,2));

    %% Gráfico genérico: %%
    % Calcular los porcentajes
    total = sum(Costes_Totales);
    porcentajes = 100 * Costes_Totales / total;
    labels = strcat(num2str(porcentajes, '%.1f%%'));

    % Crear el gráfico de sectores
    figure;
    explode = [0 0 1 0 1 0 1];
    pct = pie(Costes_Totales, explode);
    map={'w','g','y','r','#212F3C','#F39C12','c'};
    cmap = validatecolor(map, 'multiple');
    colormap(cmap)

    % Ajustar las etiquetas
    textObjs = findobj(pct, 'Type', 'text');
    for i = 1:length(textObjs)
        % Asignar la etiqueta correcta
        textObjs(i).String = labels(i, :);
        % Obtener la posición actual de la etiqueta
        pos = textObjs(i).Position;
        % Mover la etiqueta fuera del sector si se aplica explode
        if explode(i) == 1
            textObjs(i).Position = pos * 0.95; % Ajusta el factor según sea necesario
        elseif i == 1 % Si es la primera componente (donde explode es 0)
            % Ajustar la posición vertical del porcentaje para el primer sector
            textObjs(i).Position(2) = pos(2) - 0.2; % Disminuye el valor según sea necesario
        elseif i == 6 % Si es la sexta componente (donde explode es 0)
            % Ajustar la posición vertical del porcentaje para el sexto sector
            textObjs(i).Position(2) = pos(2) - 0.3; % Disminuye el valor según sea necesario
        end
        textObjs(i).FontSize = 10; % Ajusta el tamaño de la fuente según sea necesario
        textObjs(i).FontWeight = 'bold'; % Establece la negrita
        textObjs(i).HorizontalAlignment = 'center'; % Centrar el texto
    end

    % Configurar el gráfico
    set(gca, 'FontSize', 14, 'TickLabelInterpreter', 'latex')
    title('Distribuci\''on de costes general', 'FontSize', 20, 'Interpreter', 'latex')
    hct = legend(table2cell(PRESUPUESTO_DATOS(1:7,14)), 'Location', 'east', 'Orientation', 'vertical', 'FontSize', 14, 'Interpreter', 'latex');
    % Ajustar la posición de la leyenda
    hct.Position(1) = 0.80 - hct.Position(3)/2;

    %% Subplot de la pintura: %%
    % Crear una nueva figura
    figure;

    % Gráfico Pintura General
    subplot(1, 3, 1); % 1 fila, 3 columnas, posición 1
    p1p = pie(Pintura); % Crear el gráfico de pastel

    colores = {'#ECF0F1', '#F7DC6F'}; % rojo para el primer sector, negro para el segundo
    for i = 1:numel(p1p)/2
        p1p(2*i-1).FaceColor = colores{i};
    end

    pText = findobj(p1p, 'Type', 'text');
    % Calcula los porcentajes de cada categoría y conviértelos en texto
    porcentajes = round((Pintura / sum(Pintura)) * 100, 1);
    porcentajes_str = string(porcentajes) + "%";
    % Define las etiquetas personalizadas
    labels_p1p = {num2str(round(Pintura(1),2)), num2str(round(Pintura(2),2))};
    % Concatena las etiquetas personalizadas con los porcentajes
    combinedtxt = strcat(labels_p1p', " €= ", porcentajes_str);
    % Actualiza el texto del gráfico de pastel con las etiquetas personalizadas y los porcentajes
    for i = 1:numel(pText)
        pText(i).String = combinedtxt(i);
        pText(i).Color = 'black';
        if contains(pText(i).String, string(labels_p1p)) || contains(pText(i).String, 'Otros')
            pText(i).FontSize = 10;  % Puedes ajustar el tamaño según tus preferencias
            pText(i).FontWeight = 'bold';  % Otras propiedades de fuente que puedes ajustar
        end
    end
    set(gca, 'FontSize', 14, 'TickLabelInterpreter', 'latex');
    title('Costes totales de la pintura', 'FontSize', 20, 'Interpreter', 'latex');
    h_p1p = legend(Subgrupos(1:2), 'Location', 'southoutside', 'FontSize', 14, 'Interpreter', 'latex');

    % Ajustar la posición de la leyenda
    h_p1p.Position(1) = 0.235 - h_p1p.Position(3)/2;
    h_p1p.Position(2) = 0.135; % Ajustar manualmente la posición vertical


    % Gráfico Pintura Blanca
    subplot(1, 3, 2); % 1 fila, 3 columnas, posición 2
    p2p = pie(Pintura_Blanca);

    colores = {'#7B7D7D','#B3B6B7', '#ECF0F1', '#F4F6F7'}; % rojo para el primer sector, negro para el segundo
    for i = 1:numel(p2p)/2
        p2p(2*i-1).FaceColor = colores{i};
    end

    pText = findobj(p2p, 'Type', 'text');
    % Calcula los porcentajes de cada categoría y conviértelos en texto
    porcentajes = round((Pintura_Blanca / sum(Pintura_Blanca)) * 100, 1);
    porcentajes_str = string(porcentajes) + "%";
    % Define las etiquetas personalizadas
    labels_p2p = {num2str(round(Pintura_Blanca(1),2)), num2str(round(Pintura_Blanca(2),2)), num2str(round(Pintura_Blanca(3),2)), num2str(round(Pintura_Blanca(4),2))};
    % Concatena las etiquetas personalizadas con los porcentajes
    combinedtxt = strcat(labels_p2p', " €= ", porcentajes_str);
    % Actualiza el texto del gráfico de pastel con las etiquetas personalizadas y los porcentajes
    for i = 1:numel(pText)
        pText(i).String = combinedtxt(i);
        pText(i).Color = 'black';
        if contains(pText(i).String, string(labels_p2p)) || contains(pText(i).String, 'Otros')
            pText(i).FontSize = 10;  % Puedes ajustar el tamaño según tus preferencias
            pText(i).FontWeight = 'bold';  % Otras propiedades de fuente que puedes ajustar
        end
    end

    set(gca, 'FontSize', 14, 'TickLabelInterpreter', 'latex');
    title('Costes destinados a pintura blanca', 'FontSize', 20, 'Interpreter', 'latex');
    h_p2p = legend(table2cell(PRESUPUESTO_DATOS(1:4, 1)), 'Location', 'southoutside', 'FontSize', 14, 'Interpreter', 'latex');

    % Gráfico Pintura Amarilla
    subplot(1, 3, 3); % 1 fila, 3 columnas, posición 3
    p3p = pie(Pintura_Amarilla);

    colores = {'#B7950B','#F1C40F', '#F7DC6F', '#FCF3CF'}; % rojo para el primer sector, negro para el segundo
    for i = 1:numel(p3p)/2
        p3p(2*i-1).FaceColor = colores{i};
    end

    pText = findobj(p3p, 'Type', 'text');
    % Calcula los porcentajes de cada categoría y conviértelos en texto
    porcentajes = round((Pintura_Amarilla / sum(Pintura_Amarilla)) * 100, 1);
    porcentajes_str = string(porcentajes) + "%";
    % Define las etiquetas personalizadas
    labels_p3p = {num2str(round(Pintura_Amarilla(1),2)), num2str(round(Pintura_Amarilla(2),2)), num2str(round(Pintura_Amarilla(3),2)), num2str(round(Pintura_Amarilla(4),2))};
    % Concatena las etiquetas personalizadas con los porcentajes
    combinedtxt = strcat(labels_p3p', " €= ", porcentajes_str);
    % Actualiza el texto del gráfico de pastel con las etiquetas personalizadas y los porcentajes
    for i = 1:numel(pText)
        pText(i).String = combinedtxt(i);
        pText(i).Color = 'black';
        if contains(pText(i).String, string(labels_p3p)) || contains(pText(i).String, 'Otros')
            pText(i).FontSize = 10;  % Puedes ajustar el tamaño según tus preferencias
            pText(i).FontWeight = 'bold';  % Otras propiedades de fuente que puedes ajustar
        end
    end

    set(gca, 'FontSize', 14, 'TickLabelInterpreter', 'latex');
    title('Costes destinados a pintura amarilla', 'FontSize', 20, 'Interpreter', 'latex');
    h_p3p = legend(table2cell(PRESUPUESTO_DATOS(5:8, 1)), 'Location', 'southoutside', 'FontSize', 14, 'Interpreter', 'latex');

    % Ajustar la posición de las leyendas
    h_p1p.Position(1) = 0.235 - h_p1p.Position(3)/2;
    h_p1p.Position(2) = 0.135; % Ajustar manualmente la posición vertical

    h_p2p.Position(1) = 0.525 - h_p2p.Position(3)/2;
    h_p2p.Position(2) = 0.05; % Ajustar manualmente la posición vertical

    h_p3p.Position(1) = 0.805+0.04 - h_p3p.Position(3)/2;
    h_p3p.Position(2) = 0.05; % Ajustar manualmente la posición vertical
    
    % Ajuste de los subplots
    subplotWidth = 0.2; % Ancho de cada subplot
    subplotHeight = 0.862; % Altura de cada subplot
    subplotMargin = 0.1; % Margen entre subplots

    % Calcula el ancho total ocupado por los subplots y el espacio entre ellos
    totalWidth = 3 * subplotWidth + 2 * subplotMargin;
    spacing = subplotMargin + subplotWidth;

    % Calcula la posición del primer subplot
    subplotPos1 = [subplotMargin, 0.1, subplotWidth, subplotHeight];
    % Establece la posición del primer subplot
    set(gca, 'Position', subplotPos1);

    % Calcula la posición del segundo subplot
    subplotPos2 = [subplotMargin + spacing, 0.1, subplotWidth, subplotHeight];
    % Establece la posición del segundo subplot
    set(gca, 'Position', subplotPos2);

    % Calcula la posición del tercer subplot
    subplotPos3 = [subplotMargin + 2 * spacing+0.04, 0.1, subplotWidth, subplotHeight];
    % Establece la posición del tercer subplot
    set(gca, 'Position', subplotPos3);

    %% Gráfico Edificaciones: %%
    figure;
    pedif=pie(Edificaciones);
    colores = {'#EC7063','#F4D03F'}; % rojo para el primer sector, negro para el segundo
    for i = 1:numel(pedif)/2
        pedif(2*i-1).FaceColor = colores{i};
    end
    pText = findobj(pedif, 'Type', 'text');
    % Calcula los porcentajes de cada categoría y conviértelos en texto
    porcentajes = round((Edificaciones / sum(Edificaciones)) * 100, 1);
    porcentajes_str = string(porcentajes) + "%";
    % Define las etiquetas personalizadas
    labels_edif = {num2str(round(Edificaciones(1),2)), num2str(round(Edificaciones(2),2))}';
    % Concatena las etiquetas personalizadas con los porcentajes
    combinedtxt = strcat(labels_edif, " €= ", porcentajes_str);
    % Actualiza el texto del gráfico de pastel con las etiquetas personalizadas y los porcentajes
    for i = 1:numel(pText)
        pText(i).String = combinedtxt(i);
        pText(i).Color = 'black';
        if contains(pText(i).String, string(labels_edif)) || contains(pText(i).String, 'Otros')
            pText(i).FontSize = 10;  % Puedes ajustar el tamaño según tus preferencias
            pText(i).FontWeight = 'bold';  % Otras propiedades de fuente que puedes ajustar
        end
    end
    set(gca, 'FontSize', 14, 'TickLabelInterpreter', 'latex')
    title('Costes destinados a edificaciones', 'FontSize', 20, 'Interpreter', 'latex')
    h_edif = legend(Subgrupos([7,10]), 'Location', 'southoutside', 'FontSize', 14, 'Interpreter', 'latex');

    %% Gráfico Equipamiento: %%
    figure;
    p_equip=pie(Equipamiento);
    colores = {'#F4D03F ', '#EC7063 '}; % rojo para el primer sector, negro para el segundo
    for i = 1:numel(p_equip)/2
        p_equip(2*i-1).FaceColor = colores{i};
    end
    pText = findobj(p_equip, 'Type', 'text');
    % Calcula los porcentajes de cada categoría y conviértelos en texto
    porcentajes = round((Equipamiento / sum(Equipamiento)) * 100, 1);
    porcentajes_str = string(porcentajes) + "%";
    % Define las etiquetas personalizadas
    labels_equip = {num2str(round(Equipamiento(1),2)), num2str(round(Equipamiento(2),2))};
    % Concatena las etiquetas personalizadas con los porcentajes
    combinedtxt = strcat(labels_equip', " €= ", porcentajes_str);
    % Actualiza el texto del gráfico de pastel con las etiquetas personalizadas y los porcentajes
    for i = 1:numel(pText)
        pText(i).String = combinedtxt(i);
        pText(i).Color = 'black';
        if contains(pText(i).String, string(labels_equip)) || contains(pText(i).String, 'Otros')
            pText(i).FontSize = 10;  % Puedes ajustar el tamaño según tus preferencias
            pText(i).FontWeight = 'bold';  % Otras propiedades de fuente que puedes ajustar
        end
    end
    set(gca, 'FontSize', 14, 'TickLabelInterpreter', 'latex')
    title('Costes destinados a salvamento y extinci\''on de incendios', 'FontSize', 20, 'Interpreter', 'latex')
    h_equip = legend(Subgrupos(3:4), 'Location', 'southoutside', 'FontSize', 14, 'Interpreter', 'latex');

    %% Gráfico Terreno: %%
    figure;
    p_terreno = pie(Terreno);
    colores = {'#A8EC0D', '#0F2EF1','#A04000','#F1C40F', '#696A65'}; % rojo para el primer sector, negro para el segundo
    for i = 1:numel(p_terreno)/2
        p_terreno(2*i-1).FaceColor = colores{i};
    end

    pText = findobj(p_terreno, 'Type', 'text');
    % Calcula los porcentajes de cada categoría y conviértelos en texto
    porcentajes = round((Terreno / sum(Terreno)) * 100, 1);
    porcentajes_str = string(porcentajes) + "%";
    % Define las etiquetas personalizadas
    labels_terreno = {num2str(round(Terreno(1),2)), num2str(round(Terreno(2),2)), num2str(round(Terreno(3),2)), num2str(round(Terreno(4),2)), num2str(round(Terreno(5),2))};
    % Concatena las etiquetas personalizadas con los porcentajes
    combinedtxt = strcat(labels_terreno', " €= ", porcentajes_str);
    % Actualiza el texto del gráfico de pastel con las etiquetas personalizadas y los porcentajes
    for i = 1:numel(pText)
        pText(i).String = combinedtxt(i);
        pText(i).Color = 'black';
        if contains(pText(i).String, string(labels_terreno)) || contains(pText(i).String, 'Otros')
            pText(i).FontSize = 10;  % Puedes ajustar el tamaño según tus preferencias
            pText(i).FontWeight = 'bold';  % Otras propiedades de fuente que puedes ajustar
        end
    end

    set(gca, 'FontSize', 14, 'TickLabelInterpreter', 'latex')
    title('Costes destinados al terreno', 'FontSize', 20, 'Interpreter', 'latex')
    h_terreno = legend(Subgrupos([5:6,16:18]), 'Location', 'southoutside', 'Orientation', 'horizontal', 'FontSize', 14, 'Interpreter', 'latex');
    h_terreno.Position(1) = 0.515 - h_terreno.Position(3)/2;
    h_terreno.Position(2) = 0.450 - h_terreno.Position(3)/4;

    %% Gráfico Luces: %%
    figure;
    p_Luces = pie(Luces);
    colores = {'#696A65','#A8EC0D', '#0078FF','#EC7063','k'}; % rojo para el primer sector, negro para el segundo
    for i = 1:numel(p_Luces)/2
        p_Luces(2*i-1).FaceColor = colores{i};
    end

    pText = findobj(p_Luces, 'Type', 'text');
    % Calcula los porcentajes de cada categoría y conviértelos en texto
    porcentajes = round((Luces / sum(Luces)) * 100, 1);
    porcentajes_str = string(porcentajes) + "%";
    % Define las etiquetas personalizadas
    labels_Luces = {num2str(round(Luces(1),0)), num2str(round(Luces(2),2)), num2str(round(Luces(3),2)), num2str(round(Luces(4),2)), num2str(round(Luces(5),2))};
    % Concatena las etiquetas personalizadas con los porcentajes
    combinedtxt = strcat(labels_Luces', " €= ", porcentajes_str);
    % Actualiza el texto del gráfico de pastel con las etiquetas personalizadas y los porcentajes
    for i = 1:numel(pText)
        pText(i).String = combinedtxt(i);
        pText(i).Color = 'black';
        if contains(pText(i).String, string(labels_Luces)) || contains(pText(i).String, 'Otros')
            pText(i).FontSize = 10;  % Puedes ajustar el tamaño según tus preferencias
            pText(i).FontWeight = 'bold';  % Otras propiedades de fuente que puedes ajustar
        end
    end

    set(gca, 'FontSize', 14, 'TickLabelInterpreter', 'latex')
    title('Costes destinados a las luces', 'FontSize', 20, 'Interpreter', 'latex')
    h_Luces = legend(Subgrupos(11:15), 'Location', 'southoutside', 'Orientation', 'horizontal', 'FontSize', 14, 'Interpreter', 'latex');
    h_Luces.Position(1) = 0.515 - h_Luces.Position(3)/2;
    h_Luces.Position(2) = 0.45 - h_Luces.Position(3)/4;
    
    %% Gráfico Licencias: %%
    figure;
    p_licencias = pie(Licencias);
    colores = {'#EC7063','#A8EC0D', '#0078FF','#696A65'}; % rojo para el primer sector, negro para el segundo
    for i = 1:numel(p_licencias)/2
        p_licencias(2*i-1).FaceColor = colores{i};
    end

    pText = findobj(p_licencias, 'Type', 'text');
    % Calcula los porcentajes de cada categoría y conviértelos en texto
    porcentajes = round((Licencias / sum(Licencias)) * 100, 1);
    porcentajes_str = string(porcentajes) + "%";
    % Define las etiquetas personalizadas
    labels_licencias = {num2str(round(Licencias(1),0)), num2str(round(Licencias(2),2)), num2str(round(Licencias(3),2)), num2str(round(Licencias(4),2))};
    % Concatena las etiquetas personalizadas con los porcentajes
    combinedtxt = strcat(labels_licencias', " €= ", porcentajes_str);
    % Actualiza el texto del gráfico de pastel con las etiquetas personalizadas y los porcentajes
    for i = 1:numel(pText)
        pText(i).String = combinedtxt(i);
        pText(i).Color = 'black';
        if contains(pText(i).String, string(labels_licencias)) || contains(pText(i).String, 'Otros')
            pText(i).FontSize = 10;  % Puedes ajustar el tamaño según tus preferencias
            pText(i).FontWeight = 'bold';  % Otras propiedades de fuente que puedes ajustar
        end
    end

    set(gca, 'FontSize', 14, 'TickLabelInterpreter', 'latex')
    title('Costes destinados a las licencias de software', 'FontSize', 20, 'Interpreter', 'latex')
    h_licencias = legend(table2cell(PRESUPUESTO_DATOS(43:46,1)), 'Location', 'southoutside', 'Orientation', 'horizontal', 'FontSize', 14, 'Interpreter', 'latex');
    h_licencias.Position(1) = 0.51 - h_licencias.Position(3)/2;
    h_licencias.Position(2) = 0.30 - h_licencias.Position(3)/4;

    %% Gráfico Personal: %%
    figure;
    p_personal = pie(Personal);
    colores = {'b', 'g','r','#D35400','y','k'}; % rojo para el primer sector, negro para el segundo
    for i = 1:numel(p_personal)/2
        p_personal(2*i-1).FaceColor = colores{i};
    end

    pText = findobj(p_personal, 'Type', 'text');
    % Calcula los porcentajes de cada categoría y conviértelos en texto
    porcentajes = round((Personal / sum(Personal)) * 100, 1);
    porcentajes_str = string(porcentajes) + "%";
    % Define las etiquetas personalizadas
    labels_personal = {num2str(round(Personal(1),2)), num2str(round(Personal(2),2)), num2str(round(Personal(3),2)), num2str(round(Personal(4),2)), num2str(round(Personal(5),2)), num2str(round(Personal(6),2))};
    % Concatena las etiquetas personalizadas con los porcentajes
    combinedtxt = strcat(labels_personal', " €= ", porcentajes_str);
    % Actualiza el texto del gráfico de pastel con las etiquetas personalizadas y los porcentajes
    for i = 1:numel(pText)
        pText(i).String = combinedtxt(i);
        pText(i).Color = 'black';
        if contains(pText(i).String, string(labels_personal)) || contains(pText(i).String, 'Otros')
            pText(i).FontSize = 10;  % Puedes ajustar el tamaño según tus preferencias
            pText(i).FontWeight = 'bold';  % Otras propiedades de fuente que puedes ajustar
        end
    end

    set(gca, 'FontSize', 14, 'TickLabelInterpreter', 'latex')
    title('Costes destinados al personal', 'FontSize', 20, 'Interpreter', 'latex')
    h_personal = legend(table2cell(PRESUPUESTO_DATOS(69:74,1)), 'Location', 'southoutside', 'Orientation', 'horizontal', 'FontSize', 14, 'Interpreter', 'latex');
    h_personal.Position(1) = 0.52 - h_personal.Position(3)/2;
    h_personal.Position(2) = 0.350 - h_personal.Position(3)/4;
end