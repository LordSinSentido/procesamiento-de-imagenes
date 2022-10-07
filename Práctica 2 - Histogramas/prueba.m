% Preparación de la imágen a trabajar
image = imread('puchero.jpg');
grayscaleImage = toGrayscale(image);
linealImage = grayscaleImage;
[xLength, yLength] = size(grayscaleImage);
luminusidadMaxima = 256;

% Histograma simple
histograma = zeros(luminusidadMaxima,1);
for x = 1:xLength
    for y = 1:yLength
        pixelActual = grayscaleImage(x, y) + 1;
        histograma(pixelActual) = histograma(pixelActual) + 1;
    end
end

% Histograma acumulado
histogramaAcumulado = histograma(1);
for i = 2:256
    histogramaAcumulado(i) = histogramaAcumulado(i - 1) + histograma(i);
end

% Histograma lineal
nuevaEscala = zeros(luminusidadMaxima,1);
imagenEcualizada = grayscaleImage;
for i = 1:256
    frecuencia(i) = histograma(i) / (xLength * yLength);
end
for i = 2:256
    frecuencia(i) = frecuencia(i) + frecuencia(i - 1);
    nuevaEscala(i) = round(255 * frecuencia(i));
end
for x = 1:xLength
    for y = 1:yLength
        %for i = 1:256
            pixelActual = grayscaleImage(x, y) + 1;
            imagenEcualizada(x, y) = nuevaEscala(pixelActual);
        %end
    end
end
histogramaLineal = zeros(luminusidadMaxima,1);
for x = 1:xLength
    for y = 1:yLength
        pixelActual = imagenEcualizada(x, y) + 1;
        histogramaLineal(pixelActual) = histogramaLineal(pixelActual) + 1;
    end
end

% Se generan las gráficas
figure()
subplot(3,2,1)
imshow(grayscaleImage)
subplot(3,2,2)
bar(histograma)
subplot(3,2,4)
bar(histogramaAcumulado)
subplot(3,2,5)
imshow(imagenEcualizada)
subplot(3,2,6)
bar(histogramaLineal)