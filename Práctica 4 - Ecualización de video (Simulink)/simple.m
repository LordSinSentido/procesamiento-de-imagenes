function resultado = simple(entrada)
    resultado = entrada;
    
    subplot(2,2,1);
    stairs(resultado);
    xlim([0 255]);
    title('Histograma simple');
end