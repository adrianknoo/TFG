clear 
clear all
close all

%% Introducción: %%
[DATOS_Eco,Prevencion_2019,Extincion_2019,Prevencion_2020,Extincion_2020,Comunidades]=Economia_2019_2020;

%% Estado del arte: %%
[DATOS_Heli,Coordenadas,land,lon]=Helipuertos_Lista;

%% Ubicación y Helicóptero de diseño: %%
[lat_limit,lon_limit,mapData,Coordenadas_Ast_Cant,Ubicacion]=Asturias_Cantabria;

%% Meteorología: %%
[DATOS_METEO,Tmax_anual,Year,Mes,Tref,...
    P_suma_anual,P_media_anual,Direccion,Vel_media,Racha,Dia_lluvia,Mes_lluvia,Mes_T]=Meteorologia;

%% Diseño: %%
[D,UCW]=Diseno;

%% Presupuesto: %%
[PRESUPUESTO_DATOS,Grupo,Subgrupos,Costes_Totales,Pintura,Pintura_Blanca,Pintura_Amarilla,Terreno,Edificaciones,Equipamiento,Licencias]=Presupuesto;
