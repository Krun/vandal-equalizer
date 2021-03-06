% Programa de comprobación de las respuestas de los filtros
% Los archivos ..\signals\filterX_nogain.dat deben contener esas respuestas
% antes de aplicar la atenuación de cada filtro
%
% Simular para ello tfilter_generic.vhd

atenuadas = false;

filt0 = RdVHDL('..\signals\filter0_nogain.dat', 6, 10);
filt1 = RdVHDL('..\signals\filter1_nogain.dat', 6, 10);
filt2 = RdVHDL('..\signals\filter2_nogain.dat', 6, 10);
filt3 = RdVHDL('..\signals\filter3_nogain.dat', 6, 10);
filt4 = RdVHDL('..\signals\filter4_nogain.dat', 6, 10);
filt5 = RdVHDL('..\signals\filter5_nogain.dat', 6, 10);
filt6 = RdVHDL('..\signals\filter6_nogain.dat', 6, 10);

h = [filt0 filt1 filt2 filt3 filt4 filt5 filt6];


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

G = [8, 17, 34, 66, 125, 250, 500, 1000, 2000];
G = G./1024;

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
    if (atenuadas)
        yi = yi * Gi;
    end
    diff = abs(yi-hi);
    subplot(2,2,1); stem(hi);
    tit = sprintf('Respuesta en simulacion (filtro %i)',i-1);
    title(tit)
    xlabel('n')
    ylabel('h[n]')
    subplot(2,2,2); stem(yi);
    tit = sprintf('Respuesta ideal en MATLAB (filtro %i)',i-1);
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



