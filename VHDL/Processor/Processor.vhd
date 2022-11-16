--Juan Camilo Serrano Correa
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Processor is
Port ( 
	CLOK,Reset : IN std_logic; 
   Salida : out std_LOGIC_VECTOR(7 downto 0)
);
end Processor;
architecture Behavioral of Processor is
Signal	S_ADDRAM, S_ADDROM :  std_logic_vector(2 downto 0);
Signal 	S_CLK_M, S_WE_M : std_logic;
Signal 	ROM_out : std_logic_vector(18 downto 0);
Signal   ALU_out : std_logic_vector(7 downto 0);
 

Component ALU is 	Port( 
		Selector	:in std_logic_vector(2 downto 0);
		A,B		:in std_logic_vector(7 downto 0);
		Resultado:out std_logic_vector(7 downto 0));
end component;

Component Control_unit is Port ( 
	CLOK, Reset : IN std_logic; 
	ADDRAM : OUT std_logic_vector(2 downto 0);
	ADDROM : OUT std_logic_vector(2 downto 0);
	WE_M, CLOK_M :OUT std_logic);
	end component;

Component ROM IS
	generic (
		DATA_WIDTH : natural := 19;
		ADDR_WIDTH : natural := 3
);
	PORT (
		clock: IN STD_LOGIC;
		data: OUT STD_LOGIC_VECTOR (DATA_WIDTH-1 DOWNTO 0);
		add: IN STD_LOGIC_VECTOR(ADDR_WIDTH-1 DOWNTO 0)
	);
end component;

Component RAM_E is
port(
	clock : in std_logic:='1';
	address : in std_logic_vector(2 downto 0);
	data : in std_logic_vector(7 downto 0);
	wren : in std_logic;
	q : out std_logic_vector(7 downto 0));
end component;
begin

A1: Control_unit port map (CLOK, Reset, S_ADDRAM, S_ADDROM, S_WE_M, S_CLK_M);
A2: ROM generic map (19,3) port map(S_CLK_M, ROM_out, S_ADDROM);
A3: ALU port map (
			Selector (2 downto 0) => ROM_out (18 downto 16), 
			B => ROM_out (15 downto 8),
			A =>ROM_out (7 downto 0), 
			Resultado => ALU_out);
A4: RAM_E port map(S_CLK_M, S_ADDRAM, ALU_out, S_WE_M, Salida);


end Behavioral;

