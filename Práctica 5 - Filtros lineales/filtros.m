imagen = imread("imagen.png");
escalaDeGrises = rgb2gray(imagen);

subplot(1,5,1);
imshow(imagen);
title("Imágen original");

subplot(1,5,2);
imshow(simple(escalaDeGrises));
title("Filtro simple");

subplot(1,5,3);
imshow(box(escalaDeGrises));
title("Filtro box");

subplot(1,5,4);
imshow(gaussiano(escalaDeGrises));
title("Filtro Gaussiano");

subplot(1,5,5);
imshow(laplaciano(escalaDeGrises));
title("Filtro Laplaciano");

imwrite(escalaDeGrises, "resultados/escalaDeGrises.png");