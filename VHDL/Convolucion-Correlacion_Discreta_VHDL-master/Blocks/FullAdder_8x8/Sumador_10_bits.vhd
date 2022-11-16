library ieee;
use ieee.std_logic_1164.all;
entity Sumador_10_bits is 
Generic(N:Natural:=8);

port ( X,Y2:in std_logic_vector(N-1 downto 0);
		 Ci: in std_logic;
		 S: out std_logic_vector(N-1 downto 0);
		 Co: out std_logic
		);
end entity Sumador_10_bits;
Architecture Sumador_N_bits of Sumador_10_bits is 
Signal C_s:std_logic_vector(N downto 0);
Begin 
		C_s(0)<=Ci;
		Co<=C_s(N);
		L:for i in 0 to N-1 generate -- Sumador pro
			U:entity work.FA
				port map(
					X=>X(i),
					Y=>Y2(i),
					Ci=>C_s(i),
					Co=>C_s(i+1),
					S=> S(i)
				);
		end generate L;
end sumador_N_bits;
--Juan Camilo Serrano Correa