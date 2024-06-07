function [PRESUPUESTO_DATOS,Grupo,Subgrupos,Costes_Totales,Pintura,Pintura_Blanca,Pintura_Amarilla,Terreno,Edificaciones,Equipamiento,Licencias]=Presupuesto
    PRESUPUESTO_DATOS = readtable("Presupuesto.xlsx");
    Grupo = table2cell(PRESUPUESTO_DATOS(1:6,9));
    Subgrupos = table2cell(PRESUPUESTO_DATOS(:,12));
    Costes_Totales = table2array(PRESUPUESTO_DATOS(1:6,10));
    Pintura=table2array(PRESUPUESTO_DATOS(1:2,13));
    Pintura_Blanca = table2array(PRESUPUESTO_DATOS(1:4,5));
    Pintura_Amarilla = table2array(PRESUPUESTO_DATOS(5:8,5));
    Terreno=table2array(PRESUPUESTO_DATOS(9:10,4));
    Edificaciones=table2array(PRESUPUESTO_DATOS(15:16,4));
    Equipamiento = table2array(PRESUPUESTO_DATOS(3:4,13));
    % FALTA: Vector luces.
    Licencias=table2array(PRESUPUESTO_DATOS(40:42,4));
    Personal=table2array(PRESUPUESTO_DATOS(63:68,2));

    %% Gráfico genérico: %%
    figure;
    pct=pie(Costes_Totales);
    set(gca, 'FontSize', 14, 'TickLabelInterpreter', 'latex')
    title('Costes destinados', 'FontSize', 20, 'Interpreter', 'latex')
    hct = legend(table2cell(PRESUPUESTO_DATOS(1:6,9)), 'Location', 'southoutside', 'Orientation', 'horizontal', 'FontSize', 14, 'Interpreter', 'latex');
    % Ajustar la posición de la leyenda
    hct.Position(1) = 0.5 - hct.Position(3)/2;

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
    porcentajes = round((Pintura / sum(Pintura)) * 100, 0);
    porcentajes_str = string(porcentajes) + "%";
    % Define las etiquetas personalizadas
    labels_p1p = {num2str(round(Pintura(1),0)), num2str(round(Pintura(2),0))};
    % Concatena las etiquetas personalizadas con los porcentajes
    combinedtxt = strcat(labels_p1p', " €= ", porcentajes_str);
    % Actualiza el texto del gráfico de pastel con las etiquetas personalizadas y los porcentajes
    for i = 1:numel(pText)
        pText(i).String = combinedtxt(i);
        pText(i).Color = 'black';
        if contains(pText(i).String, string(labels_p1p)) || contains(pText(i).String, 'Otros')
            pText(i).FontSize = 14;  % Puedes ajustar el tamaño según tus preferencias
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
    porcentajes = round((Pintura_Blanca / sum(Pintura_Blanca)) * 100, 0);
    porcentajes_str = string(porcentajes) + "%";
    % Define las etiquetas personalizadas
    labels_p2p = {num2str(round(Pintura_Blanca(1),0)), num2str(round(Pintura_Blanca(2),0)), num2str(round(Pintura_Blanca(3),0)), num2str(round(Pintura_Blanca(4),0))};
    % Concatena las etiquetas personalizadas con los porcentajes
    combinedtxt = strcat(labels_p2p', " €= ", porcentajes_str);
    % Actualiza el texto del gráfico de pastel con las etiquetas personalizadas y los porcentajes
    for i = 1:numel(pText)
        pText(i).String = combinedtxt(i);
        pText(i).Color = 'black';
        if contains(pText(i).String, string(labels_p2p)) || contains(pText(i).String, 'Otros')
            pText(i).FontSize = 14;  % Puedes ajustar el tamaño según tus preferencias
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
    porcentajes = round((Pintura_Amarilla / sum(Pintura_Amarilla)) * 100, 0);
    porcentajes_str = string(porcentajes) + "%";
    % Define las etiquetas personalizadas
    labels_p3p = {num2str(round(Pintura_Amarilla(1),0)), num2str(round(Pintura_Amarilla(2),0)), num2str(round(Pintura_Amarilla(3),0)), num2str(round(Pintura_Amarilla(4),0))};
    % Concatena las etiquetas personalizadas con los porcentajes
    combinedtxt = strcat(labels_p3p', " €= ", porcentajes_str);
    % Actualiza el texto del gráfico de pastel con las etiquetas personalizadas y los porcentajes
    for i = 1:numel(pText)
        pText(i).String = combinedtxt(i);
        pText(i).Color = 'black';
        if contains(pText(i).String, string(labels_p3p)) || contains(pText(i).String, 'Otros')
            pText(i).FontSize = 14;  % Puedes ajustar el tamaño según tus preferencias
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

    h_p3p.Position(1) = 0.805 - h_p3p.Position(3)/2;
    h_p3p.Position(2) = 0.05; % Ajustar manualmente la posición vertical

    %% Gráfico Edificaciones: %%
    figure;
    pedif=pie(Edificaciones);
    colores = {'#EC7063','#F4D03F'}; % rojo para el primer sector, negro para el segundo
    for i = 1:numel(pedif)/2
        pedif(2*i-1).FaceColor = colores{i};
    end
    pText = findobj(pedif, 'Type', 'text');
    % Calcula los porcentajes de cada categoría y conviértelos en texto
    porcentajes = round((Edificaciones / sum(Edificaciones)) * 100, 0);
    porcentajes_str = string(porcentajes) + "%";
    % Define las etiquetas personalizadas
    labels_edif = {num2str(round(Edificaciones(1),0)), num2str(round(Edificaciones(2),0))};
    % Concatena las etiquetas personalizadas con los porcentajes
    combinedtxt = strcat(labels_edif', " €= ", porcentajes_str);
    % Actualiza el texto del gráfico de pastel con las etiquetas personalizadas y los porcentajes
    for i = 1:numel(pText)
        pText(i).String = combinedtxt(i);
        pText(i).Color = 'black';
        if contains(pText(i).String, string(labels_edif)) || contains(pText(i).String, 'Otros')
            pText(i).FontSize = 14;  % Puedes ajustar el tamaño según tus preferencias
            pText(i).FontWeight = 'bold';  % Otras propiedades de fuente que puedes ajustar
        end
    end
    set(gca, 'FontSize', 14, 'TickLabelInterpreter', 'latex')
    title('Costes destinados a edificaciones', 'FontSize', 20, 'Interpreter', 'latex')
    h_edif = legend(Subgrupos(7:8), 'Location', 'southoutside', 'FontSize', 14, 'Interpreter', 'latex');

    %% Gráfico Equipamiento: %%
    figure;
    p_equip=pie(Equipamiento);
    colores = {'#F4D03F ', '#EC7063 '}; % rojo para el primer sector, negro para el segundo
    for i = 1:numel(p_equip)/2
        p_equip(2*i-1).FaceColor = colores{i};
    end
    pText = findobj(p_equip, 'Type', 'text');
    % Calcula los porcentajes de cada categoría y conviértelos en texto
    porcentajes = round((Equipamiento / sum(Equipamiento)) * 100, 0);
    porcentajes_str = string(porcentajes) + "%";
    % Define las etiquetas personalizadas
    labels_equip = {num2str(round(Equipamiento(1),0)), num2str(round(Equipamiento(2),0))};
    % Concatena las etiquetas personalizadas con los porcentajes
    combinedtxt = strcat(labels_equip', " €= ", porcentajes_str);
    % Actualiza el texto del gráfico de pastel con las etiquetas personalizadas y los porcentajes
    for i = 1:numel(pText)
        pText(i).String = combinedtxt(i);
        pText(i).Color = 'black';
        if contains(pText(i).String, string(labels_equip)) || contains(pText(i).String, 'Otros')
            pText(i).FontSize = 14;  % Puedes ajustar el tamaño según tus preferencias
            pText(i).FontWeight = 'bold';  % Otras propiedades de fuente que puedes ajustar
        end
    end
    set(gca, 'FontSize', 14, 'TickLabelInterpreter', 'latex')
    title('Costes destinados a salvamento y extinci\''on de incendios', 'FontSize', 20, 'Interpreter', 'latex')
    h_equip = legend(Subgrupos(3:4), 'Location', 'southoutside', 'FontSize', 14, 'Interpreter', 'latex');

    %% Gráfico Terreno: %%
    figure;
    p_terreno = pie(Terreno);
    colores = {'g', 'k'}; % rojo para el primer sector, negro para el segundo
    for i = 1:numel(p_terreno)/2
        p_terreno(2*i-1).FaceColor = colores{i};
    end

    pText = findobj(p_terreno, 'Type', 'text');
    % Calcula los porcentajes de cada categoría y conviértelos en texto
    porcentajes = round((Terreno / sum(Terreno)) * 100, 0);
    porcentajes_str = string(porcentajes) + "%";
    % Define las etiquetas personalizadas
    labels_terreno = {num2str(round(Terreno(1),0)), num2str(round(Terreno(2),0))};
    % Concatena las etiquetas personalizadas con los porcentajes
    combinedtxt = strcat(labels_terreno', " €= ", porcentajes_str);
    % Actualiza el texto del gráfico de pastel con las etiquetas personalizadas y los porcentajes
    for i = 1:numel(pText)
        pText(i).String = combinedtxt(i);
        pText(i).Color = 'black';
        if contains(pText(i).String, string(labels_terreno)) || contains(pText(i).String, 'Otros')
            pText(i).FontSize = 14;  % Puedes ajustar el tamaño según tus preferencias
            pText(i).FontWeight = 'bold';  % Otras propiedades de fuente que puedes ajustar
        end
    end

    set(gca, 'FontSize', 14, 'TickLabelInterpreter', 'latex')
    title('Costes destinados al terreno', 'FontSize', 20, 'Interpreter', 'latex')
    h_terreno = legend(Subgrupos(5:6), 'Location', 'southoutside', 'FontSize', 14, 'Interpreter', 'latex');
    
    %% Gráfico Luces: %%

    %% Gráfico Licencias: %%
    figure;
    p_licencias = pie(Licencias);
    colores = {'r', '#D35400','g'}; % rojo para el primer sector, negro para el segundo
    for i = 1:numel(p_licencias)/2
        p_licencias(2*i-1).FaceColor = colores{i};
    end

    pText = findobj(p_licencias, 'Type', 'text');
    % Calcula los porcentajes de cada categoría y conviértelos en texto
    porcentajes = round((Licencias / sum(Licencias)) * 100, 0);
    porcentajes_str = string(porcentajes) + "%";
    % Define las etiquetas personalizadas
    labels_licencias = {num2str(round(Licencias(1),0)), num2str(round(Licencias(2),0)), num2str(round(Licencias(3),0))};
    % Concatena las etiquetas personalizadas con los porcentajes
    combinedtxt = strcat(labels_licencias', " €= ", porcentajes_str);
    % Actualiza el texto del gráfico de pastel con las etiquetas personalizadas y los porcentajes
    for i = 1:numel(pText)
        pText(i).String = combinedtxt(i);
        pText(i).Color = 'black';
        if contains(pText(i).String, string(labels_licencias)) || contains(pText(i).String, 'Otros')
            pText(i).FontSize = 14;  % Puedes ajustar el tamaño según tus preferencias
            pText(i).FontWeight = 'bold';  % Otras propiedades de fuente que puedes ajustar
        end
    end

    set(gca, 'FontSize', 14, 'TickLabelInterpreter', 'latex')
    title('Costes destinados a las licencias de software', 'FontSize', 20, 'Interpreter', 'latex')
    h_licencias = legend(table2cell(PRESUPUESTO_DATOS(40:42,1)), 'Location', 'southoutside', 'FontSize', 14, 'Interpreter', 'latex');

    %% Gráfico Personal: %%
    figure;
    p_personal = pie(Personal);
    colores = {'b', 'g','r','#D35400','y','k'}; % rojo para el primer sector, negro para el segundo
    for i = 1:numel(p_personal)/2
        p_personal(2*i-1).FaceColor = colores{i};
    end

    pText = findobj(p_personal, 'Type', 'text');
    % Calcula los porcentajes de cada categoría y conviértelos en texto
    porcentajes = round((Personal / sum(Personal)) * 100, 0);
    porcentajes_str = string(porcentajes) + "%";
    % Define las etiquetas personalizadas
    labels_personal = {num2str(round(Personal(1),0)), num2str(round(Personal(2),0)), num2str(round(Personal(3),0)), num2str(round(Personal(4),0)), num2str(round(Personal(5),0)), num2str(round(Personal(6),0))};
    % Concatena las etiquetas personalizadas con los porcentajes
    combinedtxt = strcat(labels_personal', " €= ", porcentajes_str);
    % Actualiza el texto del gráfico de pastel con las etiquetas personalizadas y los porcentajes
    for i = 1:numel(pText)
        pText(i).String = combinedtxt(i);
        pText(i).Color = 'black';
        if contains(pText(i).String, string(labels_personal)) || contains(pText(i).String, 'Otros')
            pText(i).FontSize = 14;  % Puedes ajustar el tamaño según tus preferencias
            pText(i).FontWeight = 'bold';  % Otras propiedades de fuente que puedes ajustar
        end
    end

    set(gca, 'FontSize', 14, 'TickLabelInterpreter', 'latex')
    title('Costes destinados al personal', 'FontSize', 20, 'Interpreter', 'latex')
    h_personal = legend(table2cell(PRESUPUESTO_DATOS(63:68,1)), 'Location', 'westoutside', 'FontSize', 14, 'Interpreter', 'latex');
end