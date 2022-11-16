--Juan Camilo Serrano Correa
library ieee;
Use ieee.std_logic_1164.all;
Entity Bloq_xor is 
port( A,B: in std_logic_vector(7 downto 0);
		A_xor_B: out std_logic_vector(7 downto 0)
	);
end entity Bloq_xor;
	
architecture cto of Bloq_xor is 
begin 
A_xor_B<=A xor B;
end cto;
