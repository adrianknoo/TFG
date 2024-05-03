clear
clear all
close all

%% LECTURA DE DATOS: %%
DATOS = readtable("Economia_2019_2020.xlsx"); % Lectura de economía.
Prevencion_2019 = table2array(DATOS(:,3));
Extincion_2019 = table2array(DATOS(:,4));
Prevencion_2020 = table2array(DATOS(:,6));
Extincion_2020 = table2array(DATOS(:,7));
Comunidades = table2cell(DATOS(:,2));

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
ylabel('Capital [€]','FontSize',16);
title('Prevención de Incendios (2019 vs 2020)','FontSize',14);
legend('Capital invertido en prevención de incendios en 2019', 'Capital invertido en prevención de incendios en 2020', 'Location', 'northwest','FontSize',12);
set(gca, 'FontSize', 12);

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
ylabel('Capital [€]','FontSize',16);
title('Extinción de Incendios (2019 vs 2020)','FontSize',14);
legend('Capital invertido en extinción de incendios en 2019', 'Capital invertido en extinción de incendios en 2020', 'Location', 'northwest','FontSize',12);
set(gca, 'FontSize', 12);