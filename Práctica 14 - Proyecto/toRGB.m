function [rojo, verde, azul] = toRGB(tono, saturacion, intensidad)

    % Se calculan los colores para cuando el tono sea menor o igual a 120.
    if (tono <= 120)
        rojo = intensidad * (1 + ((saturacion * cosd(tono)) / (cosd(60 - tono))));
        azul = intensidad * (1 - saturacion);
        verde = (3 * intensidad) - rojo - azul;
    end

    % Se calculan los colores para cuando el tono sea mayor a 120 y menor o igual a 240.
    if ((tono > 120) && (tono <= 240))
        rojo = intensidad * (1 - saturacion);
        verde = intensidad * (1 + ((saturacion * cosd(tono - 120)) / (cosd(180 - tono))));
        azul = (3 * intensidad) - rojo - verde;
    end

    % Se calculan los colores para cuando el tono sea mayor a 240.
    if (tono > 240)
        verde = intensidad * (1 - saturacion);
        azul = intensidad * (1 + ((saturacion * cosd(tono - 240)) / (cosd(300 - tono))));
        rojo = (3 * intensidad) - verde - azul;
    end

    % Se redondean los valores.
    rojo = round(rojo);
    verde = round(verde);
    azul = round(azul);
    
end