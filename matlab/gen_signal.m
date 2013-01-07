% Generación de señales de estímulo

t = 1:1000;

x0 = sin(2*pi*31.25*t/8000); 
x1 = sin(2*pi*62.5*t/8000); 
x2 = sin(2*pi*125*t/8000); 
x3 = sin(2*pi*250*t/8000); 
x4 = sin(2*pi*500*t/8000); 
x5 = sin(2*pi*1000*t/8000); 
x6 = sin(2*pi*2000*t/8000); 

% Tomaremos la señal del filtro 3 como muestra
sig = x3;

WrVHDL(sig, 6, 10, '../signals/stimulus.dat')

