--Juan Camilo Serrano Correa
library ieee;
Use ieee.std_logic_1164.all;
use IEEE.numeric_std.all;
Entity Bloque_multiplicacion is 
port( A,B: in std_logic_vector(7 downto 0);
		A_mul_B: out std_logic_vector(7 downto 0)
	);
end entity Bloque_multiplicacion;
	
architecture cto of Bloque_multiplicacion is 
signal Converter  : integer;
signal Reciver : std_logic_vector(15 downto 0);
begin 

Converter <= to_integer(unsigned(A))*to_integer(unsigned(B));
Reciver <= std_logic_vector(to_unsigned(Converter, Reciver'length));
A_mul_B <= Reciver(7 downto 0); 
end cto;