imagen = imread("imagen.png");

escalaDeGrises = rgb2gray(imagen);
ruido = salpimienta(escalaDeGrises, 3, 1);
correcion = mediana(ruido, 5);

subplot(1,3,1);
imshow(escalaDeGrises);
title("Escala de grises");

subplot(1,3,2);
imshow(ruido);
title("Filtro sal y pimienta");

subplot(1,3,3);
imshow(correcion);
title("Filtro mediana");

imwrite(escalaDeGrises, "resultados/escalaDeGrises.png");