function [DATOS_Eco,Prevencion_2019,Extincion_2019,Prevencion_2020,Extincion_2020,Comunidades]=Economia_2019_2020

%% LECTURA DE DATOS: %%
    DATOS_Eco = readtable("Datos_Graficos_TFG.xlsx", 'Sheet', 5); % Lectura de economía.
    Prevencion_2019 = table2array(DATOS_Eco(:,3));
    Extincion_2019 = table2array(DATOS_Eco(:,4));
    Prevencion_2020 = table2array(DATOS_Eco(:,6));
    Extincion_2020 = table2array(DATOS_Eco(:,7));
    Comunidades = table2cell(DATOS_Eco(:,2));

%% GRÁFICO: %%
    figure;

% Subplot izquierdo
    subplot(1,2,1);
    bar_width = 0.35;
    x = 1:numel(Comunidades);
    bar(x - bar_width/2, Prevencion_2019, bar_width, 'FaceColor', '#E66100', 'EdgeColor', 'none');
    hold on;
    bar(x + bar_width/2, Prevencion_2020, bar_width, 'FaceColor', '#A55012', 'EdgeColor', 'none');
    grid on
    hold off;
    xticks(x);
    xticklabels(Comunidades);
    xtickangle(45);
    set(gca, 'FontSize',12,'TickLabelInterpreter', 'latex')
    ylabel('Capital [€]','FontSize',16, 'Interpreter', 'latex');
    title('Prevenci\''on de Incendios (2019 vs 2020)', 'FontSize', 20, 'Interpreter', 'latex');
    legend('Capital invertido en prevenci\''on de incendios en 2019', 'Capital invertido en prevenci\''on de incendios en 2020', 'Location', 'northwest', 'FontSize', 12, 'Interpreter', 'latex');

% Subplot derecho
    subplot(1,2,2);
    bar(x - bar_width/2, Extincion_2019, bar_width, 'FaceColor', '#53E607', 'EdgeColor', 'none');
    hold on;
    bar(x + bar_width/2, Extincion_2020, bar_width, 'FaceColor', '#475A1A', 'EdgeColor', 'none');
    grid on
    hold off;
    xticks(x);
    xticklabels(Comunidades);
    xtickangle(45);
    set(gca, 'FontSize',12,'TickLabelInterpreter', 'latex')
    ylabel('Capital [€]','FontSize',16, 'Interpreter', 'latex');
    title('Extinci\''on de Incendios (2019 vs 2020)', 'FontSize', 20, 'Interpreter', 'latex');
    legend('Capital invertido en extinci\''on de incendios en 2019', 'Capital invertido en extinci\''on de incendios en 2020', 'Location', 'northwest', 'FontSize', 12, 'Interpreter', 'latex');
end