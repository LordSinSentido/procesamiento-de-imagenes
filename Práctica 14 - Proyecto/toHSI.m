function [tono, saturacion, intensidad] = toHSI(rojo, verde, azul)
    
    % Si los valores son los mismos en los tres canales, el tono y la saturación son igual a 0, caso contrario, se calcula cada uno de ellos.
    if ((rojo == verde) && (rojo == azul) && (verde == azul))
        % Tono
        tono = 0;

        % Saturación
        saturacion = 0;
    else
        % Tono
        tono = acosd((((rojo - verde) + (rojo - azul)) / 2) / (sqrt(power((rojo - verde), 2) + ((rojo - azul) * (verde - azul)))));

        if (azul > verde)
            tono = 360 - tono;
        end

        % Saturación
        saturacion = 1 - ((3 * min([rojo, verde, azul])) / (rojo + verde + azul));
    end

    % Intensidad
    intensidad = (rojo + verde + azul) / (3);
    
end