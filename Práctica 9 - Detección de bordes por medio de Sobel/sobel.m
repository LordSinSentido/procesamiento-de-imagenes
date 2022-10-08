function resultado = sobel (imagen, dimensionMascara, mascaraEnX, mascaraEnY, umbral)
    imagen = double(imagen);
    mitadMascara = round(dimensionMascara / 2);
    [ancho, alto] = size(imagen);

    resultadoEnX = zeros(size(imagen));
    resultadoEnY = zeros(size(imagen));
    resultadoBinarizado = zeros(size(imagen));

    listaValoresEnX = zeros(1,(dimensionMascara *  dimensionMascara));
    listaValoresEnY = zeros(1,(dimensionMascara *  dimensionMascara));


    % Convolución de la máscara

    for x = mitadMascara:(ancho - mitadMascara)
        for y = mitadMascara:(alto - mitadMascara)

            n = 1;

            for i = 1:dimensionMascara
                for j = 1:dimensionMascara

                    listaValoresEnX(n) = imagen((x - (mitadMascara - 1)) + i, (y - (mitadMascara - 1)) + j) * mascaraEnX(i, j);
                    listaValoresEnY(n) = imagen((x - (mitadMascara - 1)) + i, (y - (mitadMascara - 1)) + j) * mascaraEnY(i, j);
                    n = n + 1;

                end
            end

            resultadoEnX(x, y) = sum(listaValoresEnX);
            resultadoEnY(x, y) = sum(listaValoresEnY);

        end
    end

    % Gradiente y su normalización

    gradiente = sqrt((resultadoEnX .^ 2) + (resultadoEnY .^ 2));
    maximoDelgradiente = max(max(gradiente));
    gradienteNormalizado = (gradiente / maximoDelgradiente) * 255;

    % Binarización

    for x = 1:ancho
        for y = 1:alto

            if gradienteNormalizado(x, y) >= umbral
                resultadoBinarizado(x, y) = 255;
            else
                resultadoBinarizado(x, y) = 0;
            end

        end
    end

    % Conversión de los resultados

    resultadoBinarizado = uint8(resultadoBinarizado);
    gradienteNormalizado = uint8(gradienteNormalizado);

    resultado = {resultadoBinarizado; gradienteNormalizado};


    % Guardado de los resultados

    imwrite(resultadoBinarizado, "resultados/resultadoBinarizado.png");
    imwrite(gradienteNormalizado, "resultados/resultadoNormalizado.png");

end