--Juan Camilo Serrano Correa
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity COR is
Port ( 
	CLK,Reset : IN std_logic; 
	CH_1, CH_2: in std_logic_vector(2 downto 0);
	EEXIT : out std_logic_vector(9 downto 0));
end COR;
architecture Behavioral of COR is
signal SA1,SA2,SA3,SA4,SA5,SA6,SA7,SA0,B0,B1,B2,B3,B4,B5,B6,B7: std_logic_vector (2 downto 0);
signal O_AB0,O_AB1,O_AB2,O_AB3,O_AB4,O_AB5,O_AB6,O_AB7: std_logic_vector(5 downto 0);

Component Control_unit is Port ( 
	CLOK,Reset : IN std_logic; 
	CHANNEL_1, CHANNEL_2 : in std_logic_vector(2 downto 0);
	SA0,SA1,SA2,SA3,SA4,SA5,SA6,SA7,B0,B1,B2,B3,B4,B5,B6,B7: out std_logic_vector (2 downto 0)
);
end component;

Component Multiplier is
Port ( A1,A2,A3,A4,A5,A6,A7,A0,B1,B2,B3,B4,B5,B6,B7,B0: in std_logic_vector (2 downto 0);
		AB0,AB1,AB2,AB3,AB4,AB5,AB6,AB7: out std_logic_vector(5 downto 0));
end component;

Component FullAdder_8x8 is Port (
Add0,Add1,Add2,Add3,Add4,Add5,Add6,Add7 : IN std_logic_vector(5 downto 0);
Salida : OUT std_logic_vector(9 downto 0));
end component;
begin

BLOCK1 : Control_unit port map (CLK, Reset, CH_1, CH_2,SA0,SA1,SA2,SA3,SA4,SA5,SA6,SA7,B0,B1,B2,B3,B4,B5,B6,B7);
PP1 : Multiplier port map(SA0,SA1,SA2,SA3,SA4,SA5,SA6,SA7,B0,B1,B2,B3,B4,B5,B6,B7,O_AB0,O_AB1,O_AB2,O_AB3,O_AB4,O_AB5,O_AB6,O_AB7);

FS: FullAdder_8x8 port map (O_AB0,O_AB1,O_AB2,O_AB3,O_AB4,O_AB5,O_AB6,O_AB7,EEXIT);

end Behavioral;
--Juan Camilo Serrano Correa