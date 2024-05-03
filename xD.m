clear all
close all

VIENTOS=readtable("Meteorología.xlsx", 'Sheet', 3);

wind_speed =table2array(VIENTOS(:,13)); % Wind speeds in m/s
wind_direction = table2array(VIENTOS(:,12))*10; % Wind directions in degrees
figure
pax = polaraxes;
polarhistogram(deg2rad(wind_direction(wind_speed>=60)),deg2rad(0:10:360),'FaceColor','auto','displayname','50 - 60 m/s')
hold on
polarhistogram(deg2rad(wind_direction(wind_speed<=60)),deg2rad(0:10:360),'displayname','50 - 60 m/s')
polarhistogram(deg2rad(wind_direction(wind_speed<50)),deg2rad(0:10:360),'FaceColor','red','displayname','40 - 50 m/s')
polarhistogram(deg2rad(wind_direction(wind_speed<40)),deg2rad(0:10:360),'FaceColor','black','displayname','30 - 40 m/s')
polarhistogram(deg2rad(wind_direction(wind_speed<30)),deg2rad(0:10:360),'FaceColor','green','displayname','20 - 30 m/s')
polarhistogram(deg2rad(wind_direction(wind_speed<20)),deg2rad(0:10:360),'FaceColor','blue','displayname','10 - 20 m/s')
polarhistogram(deg2rad(wind_direction(wind_speed<10)),deg2rad(0:10:360),'FaceColor','yellow','displayname','0 - 10 m/s')
pax.ThetaDir = 'clockwise';
pax.ThetaZeroLocation = 'top';
legend('Show')
title('Wind Rose')
% Personalizar las etiquetas de dirección
set(gca,'ThetaZeroLocation','top'); % Colocar el 0° en la parte superior
set(gca,'ThetaDir','clockwise'); % Dirección de las etiquetas en sentido horario
thetaticks(0:22.5:350); % Etiquetas de ángulo cada 22.5 grados
thetaticklabels({'N','NNE','NE','ENE','E','ESE','SE','SSE','S','SSW','SW','WSW','W','WNW','NW','NNW','N'});