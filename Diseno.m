function [D,UCW]=Diseno
    %% DATOS DE ENTRADA: %%
    D=18.70; % Dimensión máxima del helicóptero [m].
    UCW=3.00; % Dimensión máxima del tren de aterrizaje [m].
    Anchura_tot_max=15.60; % Anchura total máxima del helicóptero [m].
    %% Áreas de aproximación final y despegue: %%
    FATO=D;
    disp(['La FATO tendrá una anchura de: ',num2str(FATO),' m.'])

    %% Zonas libres de obstáculos para helicópteros: %%

    %% Áreas de toma de contacto y de elevación inicial: %%
    Area_seg_op=0.25*D;
    disp(['El área de seguridad operacional de la TLOF es de: ',num2str(Area_seg_op),' m a cada lado del cuadrilátero.'])
    FATO_mas_Area_seg_op=2*D;
    disp(['La FATO más el área de seguridad operacional es de: ',num2str(FATO_mas_Area_seg_op),' m a cada lado del cuadrilátero.'])

    %% Área de seguridad operacional: %%

    %% Calles de rodaje terrestres: %%
    CR_tierra_anchura=1.5*UCW;
    disp(['El valor de la anchura de la calle de rodaje en tierra es: ',num2str(CR_tierra_anchura),' m.'])
    RR_tierra_anchura=1.5*Anchura_tot_max;
    disp(['El valor de la anchura de la ruta de rodaje en tierra es: ',num2str(RR_tierra_anchura),' m.'])

    %% Calles de rodaje aéreas: %%
    CR_aerea_anchura=2*UCW;
    disp(['El valor de la anchura de la calle de rodaje en aire es: ',num2str(CR_aerea_anchura),' m.'])
    RR_aerea_anchura=2*Anchura_tot_max;
    disp(['El valor de la anchura de la ruta de rodaje en aire es: ',num2str(RR_aerea_anchura),' m.'])

    %% Estacionamiento: %%
    D_int=0.5*D;
    disp(['El valor del diámetro interior del puesto de estacionamiento es: ',num2str(D_int),' m.'])
    D_contacto_ext=D_int+0.5*2;
    disp(['El valor del diámetro exterior del puesto de estacionamiento es: ',num2str(D_contacto_ext),' m.'])
    D_int_Puesto=1.2*D-0.15*2;
    disp(['El valor del diámetro interior del puesto es: ',num2str(D_int_Puesto),' m.'])
    D_ext_Puesto=D_int_Puesto+0.15*2;
    disp(['El valor del diámetro exterior del puesto es: ',num2str(D_ext_Puesto),' m.'])
    Zona_proteccion=D_ext_Puesto+0.4*D*2;
    disp(['El valor del diámetro exterior de la zona de protección es: ',num2str(Zona_proteccion),' m.'])
end