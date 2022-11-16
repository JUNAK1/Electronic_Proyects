--Juan Camilo Serrano Correa
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DMUX_15_3 is
port(f:in std_logic_vector(2 downto 0);
s:in std_logic_vector(3 downto 0);
y1,y2,y3:out std_logic_vector(14 downto 0));
end DMUX_15_3;

architecture Behavioral of DMUX_15_3 is

component DMUX_15 is port(
f:in std_logic;
s:in std_logic_vector(3 downto 0);
y:out std_logic_vector(14 downto 0));
end component;
begin
bit0 : DMUX_15 port map (f(0), s, y1);
bit1 : DMUX_15 port map (f(1), s, y2);
bit2 : DMUX_15 port map (f(2), s, y3);
end Behavioral;