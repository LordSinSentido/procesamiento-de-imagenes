function [grayscaleImg] = toGrayscale (image)
    grayscaleImg = image;
    [yfin, xfin, zfin] = size(image); % Se obtiene las dimenciones de la imagen
    for i = 1:yfin
        for j = 1:xfin
            x = abs(round(image(i,j) * 0.299 + image(i,j) * 0.587 + image(i,j) * 0.114)); % Se calcula la escala de grises
            
            % Se escribe la imagen en gris
            grayscaleImg(i,j,1) = x;
            grayscaleImg(i,j,2) = x;
            grayscaleImg(i,j,3) = x;
        end
    end
    %imshow(grayscaleImg);
end