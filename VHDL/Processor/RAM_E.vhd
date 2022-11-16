library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RAM_E is port
	(
	   clock: IN STD_LOGIC  := '1';
		address		: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
		data		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		wren		: IN STD_LOGIC ;--'0' lectura 	'1' escritura
		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
end RAM_E;

architecture Behavioral of RAM_E is

signal able: std_logic_vector(7 downto 0);
signal S_Q: std_logic_vector(7 downto 0);

component RAM is port (
	   clock	: IN STD_LOGIC  := '1';
		address		: IN STD_LOGIC_VECTOR (2 DOWNTO 0);
		data		: IN STD_LOGIC_VECTOR (7 DOWNTO 0);
		wren		: IN STD_LOGIC ;--'0' lectura 	'1' escritura
		q		: OUT STD_LOGIC_VECTOR (7 DOWNTO 0)
	);
end component;

begin

MEM : RAM port map (clock, address, data, wren, S_Q);

L: for i in 0 to 7 generate
	able(i) <= not wren and S_q(i);
end generate L; 

q <= able;
 
end Behavioral;