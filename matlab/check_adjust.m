% Programa de comprobación de función de ajuste de ganancia
% Debe simularse previamente el archivo tsystem_adjust.vhd

short = RdVHDL('..\signals\stimulus.dat', 6, 10);
filt = RdVHDL('..\signals\adjust.dat', 6, 10);
filt2 = RdVHDL('..\signals\adjust2.dat', 6, 10);

subplot(3,1,1);
plot(short);
title('Señal de entrada');
subplot(3,1,2);
plot(filt);
title('Salida sin variar atenuación');
subplot(3,1,3);
plot(filt2);
title('Salida variando atenuación');
