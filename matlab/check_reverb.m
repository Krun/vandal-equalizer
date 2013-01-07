% Programa de comprobación de función de reverb
% Debe simularse previamente el archivo tsystem_reverb.vhd

short = RdVHDL('..\signals\short_stim.dat', 6, 10);
filt = RdVHDL('..\signals\reverb.dat', 6, 10);
filt2 = RdVHDL('..\signals\reverb2.dat', 6, 10);

add = length(filt) - length(short);
addzr = zeros(add,1);
shortx = [short; addzr];

subplot(3,1,1);
plot(shortx);
title('Señal de entrada');
subplot(3,1,2);
plot(filt);
title('Salida sin reverb');
subplot(3,1,3);
plot(filt2);
title('Salida con reverb');
