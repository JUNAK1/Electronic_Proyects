--Juan Camilo Serrano Correa
library ieee;
use ieee.std_logic_1164.all;
entity Sumador_9_bits is 
Generic(N:Natural:=7);

port ( X,Y1:in std_logic_vector(N-1 downto 0);
		 Ci: in std_logic;
		 S: out std_logic_vector(N-1 downto 0);
		 Co: out std_logic
		);
end entity Sumador_9_bits;
Architecture Sumador_N_bits of Sumador_9_bits is 
Signal C_s:std_logic_vector(N downto 0);
Begin 
		C_s(0)<=Ci;
		Co<=C_s(N);
		L:for i in 0 to N-1 generate -- Sumador pro
			U:entity work.FA
				port map(
					X=>X(i),
					Y=>Y1(i),
					Ci=>C_s(i),
					Co=>C_s(i+1),
					S=> S(i)
				);
		end generate L;
end sumador_N_bits;
--Juan Camilo Serrano Correa