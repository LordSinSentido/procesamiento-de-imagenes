function resultado = mediana (imagen, dimensionMascara)
    imagen = double(imagen);
    resultado = imagen;
    mitadMascara = round(dimensionMascara / 2);

    [ancho, alto] = size(imagen);

    listaValores = zeros(1,(dimensionMascara *  dimensionMascara));

    for x = mitadMascara:(ancho - mitadMascara)
        for y = mitadMascara:(alto - mitadMascara)

            n = 1;

            for i = 1:dimensionMascara
                for j = 1:dimensionMascara
                    listaValores(n) = imagen((x - (mitadMascara - 1)) + i, (y - (mitadMascara - 1)) + j);
                    n = n + 1;
                end
            end

            listaValores = sort(listaValores);
            resultado(x,y) = listaValores(round((dimensionMascara * dimensionMascara) / 2));
        end
    end

    resultado = uint8(resultado);
    imwrite(resultado, "resultados/mediana.png");
end