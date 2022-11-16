--Juan Camilo Serrano Correa
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullAdder_8x8 is
Port (
Add0 : IN std_logic_vector(5 downto 0);
Add1 : IN std_logic_vector(5 downto 0);
Add2 : IN std_logic_vector(5 downto 0);
Add3 : IN std_logic_vector(5 downto 0);
Add4 : IN std_logic_vector(5 downto 0);
Add5 : IN std_logic_vector(5 downto 0); 
Add6 : IN std_logic_vector(5 downto 0);
Add7 : IN std_logic_vector(5 downto 0);
Salida : OUT std_logic_vector(9 downto 0));
end FullAdder_8x8;

architecture Behavioral of FullAdder_8x8 is

Component Sumador_8_bits IS
	generic (N : natural := 6);	
port ( X,Y:in std_logic_vector(N-1 downto 0);
		 Ci: in std_logic;
		 S: out std_logic_vector(N-1 downto 0);
		 Co: out std_logic);
end component;

Component Sumador_9_bits IS
	generic (N : natural := 7);	
port ( X,Y1:in std_logic_vector(N-1 downto 0);
		 Ci: in std_logic;
		 S: out std_logic_vector(N-1 downto 0);
		 Co: out std_logic);
end component;

Component Sumador_10_bits IS
	generic (N : natural := 8);
port ( X,Y2:in std_logic_vector(N-1 downto 0);
		 Ci: in std_logic;
		 S: out std_logic_vector(N-1 downto 0);
		 Co: out std_logic);
end component;

Component Sumador_11_bits IS
	generic (N : natural := 9);	
port ( X,Y3:in std_logic_vector(N-1 downto 0);
		 Ci: in std_logic;
		 S: out std_logic_vector(N-1 downto 0);
		 Co: out std_logic);
end component;
signal carry_1,carry_2,carry_3,carry_4,carry_5,carry_6,carry_7: std_logic;
signal zero : std_logic_vector(6 downto 0);
signal zero1 : std_logic_vector(7 downto 0);
signal zero2,zero3,zero4,zero5 : std_logic_vector(8 downto 0);
signal signal_1: std_logic_vector(5 downto 0);
signal signal_2: std_logic_vector(6 downto 0);
signal signal_3: std_logic_vector(6 downto 0);
signal signal_4: std_logic_vector(7 downto 0);
signal signal_5: std_logic_vector(7 downto 0);
signal signal_6: std_logic_vector(8 downto 0);
signal signal_7: std_logic_vector(8 downto 0);
signal signal_8: std_logic_vector(8 downto 0);
signal signal_9: std_logic_vector(8 downto 0);
signal signal_10: std_logic_vector(8 downto 0);

begin
signal_2 <= carry_1 & signal_1;
signal_4 <= carry_2 & signal_3;
signal_6 <= carry_3 & signal_5;
zero <= '0' & add2;
zero1 <= "00" & add3;
zero2 <= "000" & add4;
zero3 <= "000" & add5;
zero4 <= "000" & add6;
zero5 <= "000" & add7;

bit0 : Sumador_8_bits  port map (add0,add1,'0',signal_1,carry_1);
bit1 : Sumador_9_bits  port map (signal_2,zero,'0',signal_3,carry_2);	--9
bit2 : Sumador_10_bits port map (signal_4, zero1, '0', signal_5, carry_3);
bit3 : Sumador_11_bits port map (signal_6,zero2,'0', signal_7, open);
bit4 : Sumador_11_bits port map (signal_7,zero3,'0', signal_8, open);
bit5 : Sumador_11_bits port map (signal_8,zero4,'0', signal_9, open);
bit6 : Sumador_11_bits port map (signal_9,zero5,'0', signal_10, carry_7);

 
Salida <=carry_7 & signal_10 ;
end Behavioral;