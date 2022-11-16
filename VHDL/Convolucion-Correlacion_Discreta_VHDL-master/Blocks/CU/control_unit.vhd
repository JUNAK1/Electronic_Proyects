--Juan Camilo Serrano Correa
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control_unit is
Port ( 
	CLOK,Reset : IN std_logic; 
	CHANNEL_1, CHANNEL_2 : in std_logic;  
	O_CHANNEL_1, O_CHANNEL_2 : out std_logic_vector(7 downto 0);  
	ADDRAM : out std_logic_vector(2 downto 0)
);
end Control_unit;
architecture Behavioral of Control_unit is
Signal S_CHANNEL_1, S_CHANNEL_2,XX1,XX2 : std_logic;

Component CONTADOR is Port (
	CLK : IN std_logic; 
	Reset : IN std_logic;
	Salida : OUT std_logic_vector(2 downto 0));
end component;

Component pipo is port(
	clk,rst,en: in std_logic;
	d:in std_logic;
	qo:out std_logic
);
end component;

Component shift_siso is port(
Clock, Sin : in std_logic;
Pout: out std_logic_vector(7 downto 0);
Sout : out std_logic
);
end component;

begin
CLK1 : CONTADOR port map (CLOK, Reset, ADDRAM);
RETN1 : pipo port map(CLOK, Reset, '1', CHANNEL_1, S_CHANNEL_1);
RETN2 : pipo port map(CLOK, Reset, '1', CHANNEL_2, S_CHANNEL_2);
REGISTRO1: shift_siso port map(CLOK, S_CHANNEL_1,O_CHANNEL_1, XX1);
REGISTRO2: shift_siso port map(CLOK, S_CHANNEL_2,O_CHANNEL_2, XX2);

end Behavioral;
--Juan Camilo Serrano Correa