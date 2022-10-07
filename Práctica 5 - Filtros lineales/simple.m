function resultado = simple (imagen)
    imagen = double(imagen);
    resultado = imagen;

    [ancho, alto] = size(imagen);

    factores = [1 1 1; 1 1 1; 1 1 1];
    sumaFactores = sum(sum(factores));

    for x = 2:(ancho - 2)
        for y = 2:(alto - 2)

            suma = 0;

            for i = 1:3
                for j = 1:3
                    suma = imagen((x - 1) + i, (y - 1) + j) * factores(i, j) + suma;
                end
            end

            resultado(x, y) = suma / sumaFactores;
        end
    end

    resultado = uint8(resultado);
    imwrite(resultado, "resultados/simple.png");
end