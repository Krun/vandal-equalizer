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

lim = [180 180 180 120 90 60 30];



h = dlmread('responses.lst');
h = h ./ 1024;
for i = 1:7,
    limi = lim(i)
    y = 1:200
    delta = sin(2*pi*400*y);
    %delta = zeros(1,limi);
    %delta(2) = 1;
    hi = transpose(h(1:limi,i))
    Bi = B(i,:)
    Ai = A(i,:)
    yi = filter(Bi, Ai, delta)
    %diff = yi-hi;
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
    %subplot(2,2,[3:4]); stem(diff);
    tit = sprintf('Diferencia entre ambos valores (filtro %i)',i-1);
    title(tit)
    xlabel('n')
    ylabel('|h_1[n]-h_2[n]|')
    pause
    subplot
end



