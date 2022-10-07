function resultado = box (imagen)
    imagen = double(imagen);
    resultado = imagen;

    [ancho, alto] = size(imagen);

    factores = [0 0 0 0 0; 0 1 1 1 0; 0 1 1 1 0; 0 1 1 1 0; 0 0 0 0 0];
    sumaFactores = sum(sum(factores));

    for x = 3:(ancho - 3)
        for y = 3:(alto - 3)

            suma = 0;

            for i = 1:5
                for j = 1:5
                    suma = imagen((x - 2) + i, (y - 2) + j) * factores(i, j) + suma;
                end
            end

            resultado(x, y) = suma / sumaFactores;
        end
    end

    resultado = uint8(resultado);
    imwrite(resultado, "resultados/box.png");
end