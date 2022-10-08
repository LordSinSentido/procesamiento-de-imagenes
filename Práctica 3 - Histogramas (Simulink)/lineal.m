function resultado = lineal(entrada)
    [datos, x] = imhist(entrada);
    [filas, columnas] = size(entrada);
    suma = 0;
    resultado = zeros(filas, columnas);
    histograma = zeros(1, 256);

    for i = 1:256
        histograma(i) = datos(i) + suma;
        suma = histograma(i);
    end
    
    for re = 1:filas
        for co = 1:columnas
            temp = floor(entrada(re, co)*255);
            resultado(re, co) = histograma(temp + 1) / (filas * columnas);
        end
    end
end