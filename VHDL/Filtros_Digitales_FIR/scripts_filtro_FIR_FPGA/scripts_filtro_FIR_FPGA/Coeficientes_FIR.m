% low_pass or Band_pass filters with windows Blackman Harris
close all
clear all
clc
Nf=100   % orden del filtro 
N = Nf+1; % N?meros de Coeficientes 
n = 0;      %indice para el calculo de los coeficientes 0<=n<=N-1
fs = 80000;   % Frecuencia de muestreo 
fc1 = 2000;    % Frecuencia de corte m?nima en Hz
fc2 = 10000;   % Frecuencia de corte m?xima en HZ
Wc1 = (2*pi*fc1)/fs   %frecuencia de corte inferor normalizada
Wc2 = (2*pi*fc2)/fs   %frecuencia de corte superior normalizada
M = floor(N/2);         % coeficiente central debe ser entero

for i = 1:N  
 w(i) = (0.35875-0.48829*cos((2*pi*n)/(N-1))+0.14128*cos((4*pi*n)/(N-1))-0.01168*cos((6*pi*n)/(N-1)) );     
 if n ~= M
   hd(i) = ((sin(Wc2*((n)-M)))/(pi*((n)-M))) - ((sin(Wc1*((n)-M)))/(pi*((n)-M))) ;
 else
   hd(i) = ((Wc2-Wc1)/pi);
 end
 
 h(i) = hd(i)*w(i);
 n = n+1; 

end
fvtool(h);

% t=0:1/fs:1/1;
% % y=chirp(t,100,1,100000);
% y=square(2*pi*16000*t);
% x=filter(h,1,y);
% figure
% 
% plot(t,y);
% 
% figure
% 
% plot(t,x);
% x=0:1/fs:1;
% y=sin(2*pi*15000*x);
% z=sin(2*pi*1000*x);
% am=z.*y;
% figure
% plot(x,am);
% axis([0.009 0.01 -1 1])
% am=(am.^2);
% w=filter(h,1,am);
% figure
% plot(x,z);
% axis([0.009 0.01 -1 1])
% figure
% plot(x,sqrt(w));
% axis([0.009 0.01 -1 1])

VHDL_Coeficientes(h,16);