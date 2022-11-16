library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multiplier is
Port ( A1,A2,A3,A4,A5,A6,A7,A0,B1,B2,B3,B4,B5,B6,B7,B0: in std_logic_vector (2 downto 0);
		AB0,AB1,AB2,AB3,AB4,AB5,AB6,AB7: out std_logic_vector(5 downto 0));
end Multiplier;

architecture Behavioral of Multiplier is

component Bloque_multiplicacion is port ( 
A,B: in std_logic_vector(2 downto 0);
A_mul_B: out std_logic_vector(5 downto 0)
	);
end component;

--signal contador: std_logic_vector(2 downto 0);

begin
bit0 : Bloque_multiplicacion port map (A0, B0, AB0);
bit1 : Bloque_multiplicacion port map (A1, B1, AB1);
bit2 : Bloque_multiplicacion port map (A2, B2, AB2);
bit3 : Bloque_multiplicacion port map (A3, B3, AB3);
bit4 : Bloque_multiplicacion port map (A4, B4, AB4);
bit5 : Bloque_multiplicacion port map (A5, B5, AB5);
bit6 : Bloque_multiplicacion port map (A6, B6, AB6);
bit7 : Bloque_multiplicacion port map (A7, B7, AB7);

end Behavioral;