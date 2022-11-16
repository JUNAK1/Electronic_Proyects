function  Generar_senal(f0,f1,Fs)
clc

Nbits=10;
fID = fopen('senal.txt','w');  %crear archivo de texto con los coeficinetes del filtro para VHDL
              

t=0:1/Fs:1;
y=chirp(t,f0,1,f1);
% y=square(2*pi*15000*t);
% x=((2^23-1)*sin(2*pi*f*t));
x=fix((y)*(2^(Nbits-1)-1));
[m N]=size(x);

for i=1:N
 fprintf(fID,'%d\n',fix(x(i)));
end

fclose(fID);

plot(t,x)
end


