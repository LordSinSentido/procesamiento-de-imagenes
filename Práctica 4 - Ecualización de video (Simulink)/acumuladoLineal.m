function resultado = acumuladoLineal(entrada)
    resultado = entrada;

    for i = 2:256
        resultado(i) = resultado(i) + resultado(i - 1);
    end
    
    subplot(2,2,4);
    stairs(resultado);
    xlim([0 255]);
    title('Histograma lineal acumulado');
end