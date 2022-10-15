imagenOriginal = imread("imagen.jpg");
imagen = rgb2gray(imagenOriginal);
imagen = double(imagen);
[ancho, alto] = size(imagen);
v = zeros(size(imagen));
s = zeros(size(imagen));
h = ones(3, 3) * (1/9);
mascaraGaussiana = [0 1 2 1 0; 1 3 5 3 1; 2 5 9 5 2; 1 3 5 3 1; 0 1 2 1 0] * (1/57);

imagenFiltrada = imfilter(imagen, h);

mascaraEnX = [-0.5 0 0.5];
mascaraEnY = [-0.5; 0; 0.5];

recorridoEnX = imfilter(imagenFiltrada, mascaraEnX);
recorridoEnY = imfilter(imagenFiltrada, mascaraEnY);

HE11 = recorridoEnX .* recorridoEnX;
HE22 = recorridoEnY .* recorridoEnY;
HE12 = recorridoEnX .* recorridoEnY;

A = imfilter(HE11, mascaraGaussiana);
B = imfilter(HE22, mascaraGaussiana);
C = imfilter(HE12, mascaraGaussiana);

alfa = 0.04;

rp = A + B;
rp1 = rp .* rp;

Q = ((A .* B) - (C .* C)) - (alfa * rp1);
th = 1000;

%for

v = Q > th;

pixel = 10;

for x = 1:ancho
    for y = 1:alto
        if(v(x,y))
            I1 = [x - pixel 1];
            I2 = [x + pixel ancho];
            I3 = [y - pixel 1];
            I4 = [y + pixel alto];

            datxi = max(I1);
            datxs = min(I2);
            datyi = max(I3);
            datys = min(I4);

            bloc = Q(datxi:1:datxs, datyi:1:datys);

            maxB = max(max(bloc));

            if(Q(x, y) == maxB)
                s(x,y) = 1;
            end
        end
    end
end

figure(1);
imshow(uint8(imagenOriginal));
hold on

x=0;
y=0;

for x = 1:ancho
    for y = 1:alto
        if(s(x,y))
            plot(y,x,'o','MarkerSize',15);
        end
    end
end

ax = gcf;
resultado = ax;

% Guardado de los resultados

exportgraphics(ax,'resultados/esquinasDetectadas.png','Resolution',75); 