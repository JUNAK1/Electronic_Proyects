--Juan Camilo Serrano Correa
library ieee;
Use ieee.std_logic_1164.all;
Entity Bloque_and is 
port( A,B: in std_logic_vector(7 downto 0);
		A_and_B: out std_logic_vector(7 downto 0)
	);
end entity Bloque_and;
	
architecture cto of Bloque_and is 
begin 
A_and_B<=A and B;
end cto;