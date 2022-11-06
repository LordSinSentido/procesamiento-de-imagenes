imagen = imread('imagen.jpg');
imagenRGB = double(imagen);

% Dimensiones de la imágen
[ancho, alto, profundidad] = size(imagenRGB);

% Resultados
resultadoHSI = zeros(ancho, alto, profundidad);
resultadoRGB = zeros(ancho, alto, profundidad);

% Conversión de RGB a HSI
for x = 1:ancho
    for y = 1:alto
        [resultadoHSI(x, y, 1), resultadoHSI(x, y, 2), resultadoHSI(x, y, 3)] = toHSI(imagenRGB(x, y, 1), imagenRGB(x, y, 2), imagenRGB(x, y, 3));
    end
end

% Alteriación de colores
minRGB = [0, 10, 0];
maxRGB = [120, 190, 120];

[tonoMinimo, saturacionMinimo, intensidadMinimo] = toHSI(0, 10, 0);
[tonoMaximo, saturacionMaximo, intensidadMaixmo] = toHSI(220, 190, 120);

for x = 1:ancho
    for y = 1:alto
        if ((resultadoHSI(x, y, 1) > 60) && (resultadoHSI(x, y, 1) < 180))
            resultadoHSI(x, y, 1) = resultadoHSI(x, y, 1) * 0.1;
            resultadoHSI(x, y, 2) = resultadoHSI(x, y, 2) + 0.6;
        end
    end
end

% Conversión de HSI a RGB
for x = 1:ancho
    for y = 1:alto

        [resultadoRGB(x, y, 1), resultadoRGB(x, y, 2), resultadoRGB(x, y, 3)] = toRGB(resultadoHSI(x, y, 1), resultadoHSI(x, y, 2), resultadoHSI(x, y, 3));

    end
end

figure(1);
subplot(1, 2, 1);
imshow(uint8(imagenRGB));
title('Imágen original');

subplot(1, 2, 2);
imshow(uint8(resultadoRGB));
title('Imágen procesada');
imwrite(uint8(resultadoRGB), "imagen (procesada).png");