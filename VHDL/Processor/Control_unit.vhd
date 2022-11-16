--Juan Camilo Serrano Correa
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control_unit is
Port ( 
	CLOK,Reset : IN std_logic; 
	ADDRAM : OUT std_logic_vector(2 downto 0);
	ADDROM : OUT std_logic_vector(2 downto 0);
	WE_M, CLOK_M:OUT std_logic
);
end Control_unit;
architecture Behavioral of Control_unit is
Signal  S_clok_d, S_WE,DIV_CLK: std_logic;
Signal ADD,ADD_D : std_logic_vector(2 downto 0);
Component CONTADOR is Port (
	CLK : IN std_logic; 
	Reset : IN std_logic;
	Salida : OUT std_logic_vector(2 downto 0));
end component;
Component CONTADOR_DOWN is Port (
	CLK : IN std_logic; 
	Reset : IN std_logic;
	Salida : OUT std_logic_vector(2 downto 0));
end component;
Component FF_D is port (
	clk,rst: in std_logic;
	d:in std_logic;
	q:out std_logic);
	end component;
Component W_E is port (
	CLK, Reset: in std_logic;
	Salida:out std_logic);
	end component;	
component FFT is port (
t,r,clk : in std_logic; 
q : out std_logic);
end component;
	
begin
CLK1 : CONTADOR port map (DIV_CLK, Reset, ADD);
CLK2 : CONTADOR_DOWN port map (S_clok_d, Reset, ADD_D);
Delay_1bit:FF_D port map (CLOK, Reset, DIV_CLK, S_clok_d);
WRITE_READ: W_E port map (ADD_D(0), Reset, WE_M);--ADD_D(1)

DIV2 : FFT port map ('1', Reset, CLOK, DIV_CLK);

CLOK_M <= DIV_CLK;

ADDROM <= ADD;
ADDRAM <= ADD_D;
end Behavioral;
--Juan Camilo Serrano Correa