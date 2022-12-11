% Se lee la imágen a tratar
imagen = imread('mnd2.jpg');

% Se convierte la imágen a escala de grises
imagenGrises = rgb2gray(imagen);
imagenGrises = double(imagenGrises);

% Se obtiene las dimensiones de la imágen
[ancho, alto] = size(imagenGrises);

% Se crea la variable para la imágen binarizada
imagenBinaria = zeros(ancho, alto);

% Se binariza la imágen, siendo como ubral el valor de 150
for x = 1:ancho
    for y = 1:alto
        if imagenGrises(x, y) >= 150
            imagenBinaria(x, y) = 0;
        else
            imagenBinaria(x, y) = 255;
        end
    end
end

% Se suavisa la imágen
imagenBinaria = double(mediana(uint8(imagenBinaria), 21));

% Se crea la matriz empleada como estructura de referencia
matriz = [0 0 1 0 0; 0 1 1 1 0; 1 1 1 1 1; 0 1 1 1 0; 0 0 1 0 0;];

erosion = imagenBinaria;

% Se erosiona la imágen
for paso = 1:3
    erosion = imerode(erosion, matriz);
end

dilatacion = erosion;

% Se dilata la imágen
for paso = 1:3
    dilatacion = imdilate(erosion, matriz);
end


figure(1);
imshow(uint8(imagenBinaria));

figure(2);
imshow(uint8(dilatacion));

% Se rellenan los hoyos de la imágen
relleno = imfill(dilatacion, 'holes');

% Se convierte la imágen binarizada a formato double
imagenBinaria = double(imagenBinaria);

% Se asignan las variables para las etiquetas y las colisiones
etiqueta = 2;
colision = 1;

% Se recorre la imágen
for x = 2:(ancho - 1)
    for y = 2:(alto - 1)
        
        % Si los píxeles vecinos son ceros, se le asigna una etiqueta y se incrementa el número de las mismas
        if (imagenBinaria(x, y) == 1)
            if ((imagenBinaria(x, y - 1) == 0) && (imagenBinaria(x- 1, y) == 0))
                imagenBinaria(x, y) = etiqueta;
                etiqueta = etiqueta + 1;
            end

            % Si uno de los píxeles vecinos tiene una etiqueta asignada, esta etiqueta se le asigna al píxel actual
            if (((imagenBinaria(x, y - 1) > 1) && (imagenBinaria(x - 1, y) < 2)) || ((imagenBinaria(x, y - 1) < 2) && (imagenBinaria(x - 1, y) > 1)))
                
                if (imagenBinaria(x, y - 1) > 1)
                    imagenBinaria(x, y) = imagenBinaria(x, y - 1);
                end

                if (imagenBinaria(x - 1, y) > 1)
                    imagenBinaria(x, y) = imagenBinaria(x - 1, y);
                end
                
            end

            % Si varios de los píxeles vecinos tienen una etiqueta asignada, se le asigna una de ellas a este píxel
            if ((imagenBinaria(x, y - 1) > 1) && (imagenBinaria(x - 1, y) > 1))
                imagenBinaria(x, y) = imagenBinaria(x - 1, y);

                % Las etiquetas no usadas son registradas como colisiones
                if ((imagenBinaria(x, y - 1) ~= (imagenBinaria(x- 1, y))))
                    ec1(colision) = imagenBinaria(x - 1, y);
                    ec2(colision) = imagenBinaria(x, y - 1);
                    colision = colision + 1;
                end
            end
        end
    end
end

% Se resuelven las colisiones
for ind = 1:(colision - 1)

    % Sd detecta la etiqueta más paqueña de las que participan en la colisión.
    if (ec1(ind) <= ec2(ind))
        for r = 1:ancho
            for c = 1:alto
                if (imagenBinaria(r, c) == ec2(ind))
                    imagenBinaria(r, c) = ec1(ind);
                end
            end
        end
    end

    if (ec1(ind) > ec2(ind))
        for r = 1:ancho
            for c = 1:alto
                if (imagenBinaria(r, c) == ec1(ind))
                    imagenBinaria(r,c ) = ec2(ind);
                end
            end
        end
    end
end

% Obetenemos los valores únicos de la imágen binaria
unicos = unique(imagenBinaria);
t = length(unicos);

% Se re-etiquetan los píxeles con los valores mínimos
imagenEtiquetada = bwlabel(relleno, 8);
for r = 1:ancho
    for c = 1:alto
        for ix = 2:t
            if (imagenEtiquetada(r, c) == unicos(ix))
                imagenEtiquetada(r, c) = ix - 1;
            end
        end
    end
end

totalDeObjetos = max(max(imagenEtiquetada));

for i = 1:totalDeObjetos
    array(i) = numel(find(imagenEtiquetada == i));
end

% Se preparan los datos para el despliegue
resultado = mat2gray(imagenEtiquetada);
imagenEtiquetada = bwlabel(resultado, 8);

% Se encuentran los objetos contenidos en la imágen binaria
objetos = bwlabel(resultado, 8);

% Se obtiene el número de objetos detectados
numeroDeObjetos = max(max(objetos));

% Se selcciona un objeto, se calcula su centroide y se guardan sus posiciones
for o = 1:numeroDeObjetos
    O = objetos == o;
    H = regionprops(double(O), 'centroid');
    punto(o, 1) = H.Centroid(1);
    punto(o, 2) = H.Centroid(2);
end

% Se cuenta cuanto dinero hay
cantidadDinero = 0;
for d = 1:numeroDeObjetos
    if ((array(d) > 40000) && (array(d) < 50000))
        cantidadDinero = cantidadDinero + 1;
        disp('Un peso');
    end

    if ((array(d) > 50000) && (array(d) < 60000))
        cantidadDinero = cantidadDinero + 2;
        disp('Dos pesos');
    end

    if ((array(d) > 60000) && (array(d) < 70000))
        cantidadDinero = cantidadDinero + 5;
        disp('Cinco pesos');
    end
end


% Se despliega la imágen
figure(3),imshow(resultado),title(['Número de elementos: ',num2str(totalDeObjetos),'. Cantidad de dinero: $',num2str(cantidadDinero),'.']);
hold on

% Se ubican las etiquetas en sus respectivos objetos
for d = 1:numeroDeObjetos
    text(punto(d, 1),punto(d, 2),strcat('\color{magenta}',num2str(array(d))),'FontSize',10);
end
