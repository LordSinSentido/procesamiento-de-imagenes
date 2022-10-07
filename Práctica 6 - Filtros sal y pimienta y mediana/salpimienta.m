function resultado = salpimienta (imagen, dimensionMascara, factorDeGranulado)
    imagen = double(imagen);
    resultado = imagen;
    mitadMascara = round(dimensionMascara / 2);
    colores = [-50 50];

    [ancho, alto] = size(imagen);

    for color = 1:2
        for cantidad = 1:round((ancho * alto) * (factorDeGranulado / 1000))
            x = randi([mitadMascara (ancho - mitadMascara)],1 , 1);
            y = randi([mitadMascara (alto - mitadMascara)], 1, 1);

            resultado(x,y) = colores(color);

            for i = 1:dimensionMascara
                for j = 1: dimensionMascara
                    resultado((x - (mitadMascara - 1)) + i, (y - (mitadMascara - 1)) + j) = resultado((x - (mitadMascara - 1)) + i, (y - (mitadMascara - 1)) + j) + colores(color);
                end
            end

        end
    end

    resultado = uint8(resultado);
    imwrite(resultado, "resultados/sal-pimienta.png");
end