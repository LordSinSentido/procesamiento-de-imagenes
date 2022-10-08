function resultado = ecualizar(entrada)
    [datos, ~] = imhist(entrada);
    [filas, columnas] = size(entrada);
    suma = 0;

    resultado = ones(filas, columnas);
    histograma = zeros(1, 256);

    for i = 1:256
        histograma(i) = datos(i) + suma;
        suma = histograma(i);
    end
    
    for i = 1:filas
        for j = 1:columnas
            temp = floor(entrada(i, j)*255);
            resultado(i, j) = histograma(temp + 1) / (filas * columnas);
        end
    end
end