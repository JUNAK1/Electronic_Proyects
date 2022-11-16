--Juan Camilo Serrano Correa
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity DMUX_7_3 is
port(f:in std_logic_vector(2 downto 0);
s:in std_logic_vector(2 downto 0);
y1,y2,y3:out std_logic_vector(7 downto 0));
end DMUX_7_3;

architecture Behavioral of DMUX_7_3 is

component DMUX is port(
f:in std_logic;
s:in std_logic_vector(2 downto 0);
y:out std_logic_vector(7 downto 0));
end component;
--signal contador: std_logic_vector(2 downto 0);
begin
bit0 : DMUX port map (f(0), s, y1);
bit1 : DMUX port map (f(1), s, y2);
bit2 : DMUX port map (f(2), s, y3);
end Behavioral;