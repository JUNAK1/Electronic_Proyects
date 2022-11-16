--Juan Camilo Serrano Correa
library ieee;
Use ieee.std_logic_1164.all;
Entity Bloque_or is 
port( A,B: in std_logic_vector(7 downto 0);
		A_or_B: out std_logic_vector(7 downto 0)
	);
end entity Bloque_or;
	
architecture cto of Bloque_or is 
begin 
A_or_B<=A or B;
end cto;
