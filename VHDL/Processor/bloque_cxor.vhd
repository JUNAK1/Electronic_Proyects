--Juan Camilo Serrano Correa
library ieee;
Use ieee.std_logic_1164.all;
Entity bloque_cxor is 
port( Entrada: in std_logic_vector(7 downto 0);
		Salida: out std_logic_vector(7 downto 0);
		Ci: in std_logic
	);
end entity bloque_cxor;
architecture cto of bloque_cxor is 
begin 
		L:for i in 0 to 7 generate  
		 Salida(i)<=(entrada(i)xor Ci); 
		end generate L;
end cto;		