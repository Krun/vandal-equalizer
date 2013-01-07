short = RdVHDL('..\short_stim.dat', 6, 10);
filt = RdVHDL('..\output.dat', 6, 10);
filt2 = RdVHDL('..\output2.dat', 6, 10);

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

filtered = zeros(size(short));
for i = 1:7,
    Bi = B(i,:);
    Ai = A(i,:);
    Gi = G(i);
    yi = filter(Bi, Ai, short);
    yi = yi * Gi;
    filtered = filtered + yi;
end

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
