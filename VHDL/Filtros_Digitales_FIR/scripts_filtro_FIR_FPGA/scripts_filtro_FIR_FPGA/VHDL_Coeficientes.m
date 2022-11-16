function  VHDL_Coeficientes(h, Nbits)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
fID = fopen('coeficientes.vhd','w');  %crear archivo de texto con los coeficinetes del filtro para VHDL

[m N]=size(h);

maximo=max(h)*2^Nbits;
minimo=min(h)*2^Nbits;

if(maximo>2^(Nbits-1)-1 || minimo<-2^(Nbits-1))
    K=Nbits+1;
else
    K=Nbits
end

fprintf(fID,'constant  N   :natural :=%d;--numero de coeficientes\n',N); % 
fprintf(fID,'Constant  fix :natural :=%d;-- cantidad de bits de la parte fraccionaria\n',Nbits); % 
fprintf(fID,'Constant  K   :natural :=%d;-- Cantidad de bits requeridos para los coeficientes\n\n',K); %
fprintf(fID,'type coef	is array(0 to N-1) of signed(K-1 downto 0);\n')
fprintf(fID,'constant coeficiente : coef :=('); %
for i=1:N
    tmp=fix(h(i)*2^(Nbits));
 if(i<N)
     fprintf(fID,'to_signed(%d,K),\n',tmp); % 
 else
     fprintf(fID,'to_signed(%d,K));\n',tmp); % 
 end
end
fprintf(fID,'\n\n'); % 
fprintf(fID,'--fix debe ser igual a: %d\n',Nbits); % 
fprintf(fID,'--N debe ser igual a: %d\n',N); % 
fprintf(fID,'--K debe ser igual a: %d',K); %
fclose(fID);



end

