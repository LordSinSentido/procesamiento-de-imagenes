function resultado = lineal(entrada)
    resultado = entrada;
    
    subplot(2,2,3);
    stairs(resultado);
    xlim([0 255]);
    title('Histograma simple');
end