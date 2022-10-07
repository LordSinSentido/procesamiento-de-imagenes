% Se carga la imagen
img = imread('image.png');
[yfin, xfin, zfin] = size(img);
figure(1);
imshow(img);


% Escala de grises
sgrey = img;
for i = 1:yfin
    for j = 1:xfin
        
        % Se calcula la escala de grises
        x = (img(i,j) * 0.299 + img(i,j) * 0.587 + img(i,j) * 0.114);
        
        % Se escribe la imagen en gris
        sgrey(i,j,1) = x;
        sgrey(i,j,2) = x;
        sgrey(i,j,3) = x;
    end
end

% Muestra la imagen
figure(2);
imshow(sgrey);


% Blanco y negro
byn = img;
for i = 1:yfin
    for j = 1:xfin

        % Se calcula el blanco y negro
        if byn(i,j) <= 128
            byn(i,j,1) = 0;
            byn(i,j,2) = 0;
            byn(i,j,3) = 0;
        else
            byn(i,j,1) = 255;
            byn(i,j,2) = 255;
            byn(i,j,3) = 255;
        end
    end
end

figure(3);
imshow(byn);

% Negro y blanco
nyb = img;
for i = 1:yfin
    for j = 1:xfin

        % Se calcula el blanco y negro
        if nyb(i,j) >= 128
            nyb(i,j,1) = 0;
            nyb(i,j,2) = 0;
            nyb(i,j,3) = 0;
        else
            nyb(i,j,1) = 255;
            nyb(i,j,2) = 255;
            nyb(i,j,3) = 255;
        end
    end
end

figure(4);
imshow(nyb);

% Negativo

% Se calcula el negativo
neg = 255 - sgrey;

figure(5);
imshow(neg);
