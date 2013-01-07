short = RdVHDL('..\signals\stimulus.dat', 6, 10);
filt = RdVHDL('..\signals\adjust.dat', 6, 10);
filt2 = RdVHDL('..\signals\adjust2.dat', 6, 10);

G = [8, 17, 34, 66, 125, 250, 500, 1000, 2000];
G = G./1024;

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

m = length(filt)-4;

subplot(3,1,1);
plot(short(1:m));
title('Señal de entrada');
subplot(3,1,2);
plot(filt(1:m));
title('Salida sin variar atenuación');
subplot(3,1,3);
plot(filt2(1:m));
title('Salida variando atenuación');
