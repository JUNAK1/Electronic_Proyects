library ieee;
use ieee.std_logic_1164.all;
entity FA is 
port (X,Y,Ci:in std_logic;
		S,Co:out std_logic
		);
end entity FA;
Architecture sumador of FA is 
begin 
		S<=X xor Y xor Ci;
		Co<= (Ci and Y)or(X and Y)or(Ci and X);
end Sumador;
