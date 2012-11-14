A = [1024 -2029 1006;
    1024 -2011 988;
    1024 -1970 955;
    1024 -1878 890;
    1024 -1660 772;
    1024 -1115 569;
    1024 141 239];
B = [1024 0 -1024;
    1024 0 -1024;
    1024 0 -1024;
    1024 0 -1024;
    1024 0 -1024;
    1024 0 -1024;
    1024 0 -1024;];

%en este fichero estan los valores de modelsim
h = dlmread('responses_modelsim.lst'); 
%Las dos primeras columnas son n y delta n, las quitamos
h = h(:,3:end); 
%Los valores estan escalados por 1024 (10 bits fraccionarios)
h = h ./ 1024; 

% Esto no es necesario, pero ayuda a la visualizacion.
% Ajusta la longitud representada de cada respuesta al impulso
% para no obtener partes poco representativas
lim = [180 180 180 120 90 60 30];

for i = 1:7,
    limi = lim(i);
    if (limi > length(h))
        limi = length(h);
    end
    y = 1:length(h);
    delta = zeros(1,limi);
    delta(1) = 1;
    hi = transpose(h(1:limi,i));
    Bi = B(i,:);
    Ai = A(i,:);
    Gi = G(i);
    yi = filter(Bi, Ai, delta);

    diff = yi-hi;
    subplot(2,2,1); stem(hi);
    tit = sprintf('Respuesta obtenida en la simulacion (filtro %i)',i-1);
    title(tit)
    xlabel('n')
    ylabel('h[n]')
    subplot(2,2,2); stem(yi);
    tit = sprintf('Respuesta obtenida en MATLAB (filtro %i)',i-1);
    title(tit)
    xlabel('n')
    ylabel('h[n]')
    subplot(2,2,[3:4]); stem(diff);
    tit = sprintf('Diferencia entre ambos valores (filtro %i)',i-1);
    title(tit)
    xlabel('n')
    ylabel('|h_1[n]-h_2[n]|')
    pause
    subplot
end



