imagen = imread("imagen.jpg");
escalaDeGrises = rgb2gray(imagen);
resultados = sobel(escalaDeGrises, 3, [-1 0 1; -2 0 2; -1 0 1], [1 2 1; 0 0 0; -1 -2 -1], 35);
binarizada = resultados{1,1};
normalizada = resultados{2,1};


subplot(2,2,1);
imshow(imagen);
title("Imágen original");

subplot(2,2,2);
imshow(escalaDeGrises);
title("Escala de grises");

subplot(2,2,3);
imshow(binarizada);
title("Binarizada");

subplot(2,2,4);
imshow(normalizada);
title("Normalizada");

imwrite(escalaDeGrises, "resultados/escalaDeGrises.png");