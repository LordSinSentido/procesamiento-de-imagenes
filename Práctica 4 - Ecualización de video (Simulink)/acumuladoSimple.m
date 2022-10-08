function resultado = acumuladoSimple(datos)
    resultado = datos;

    for i = 2:256
        resultado(i) = resultado(i) + resultado(i - 1);
    end
    
    subplot(2,2,2);
    stairs(resultado);
    xlim([0 255]);
    title('Histograma acumulado');
end