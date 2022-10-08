function resultado = acumulado(datos)
    resultado = datos;

    for i = 2:256
        resultado(i) = resultado(i) + resultado(i - 1);
    end
    
    subplot(2,1,2);
    stairs(resultado);
    xlim([0 255]);
    title('Histograma acumulado');
end