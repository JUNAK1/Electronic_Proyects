library ieee;
use ieee.std_logic_1164.all;
entity shift2_sipo is
port (Clock, Sin : in std_logic;
Pout : out std_logic_vector(7 downto 0));
end shift2_sipo;

architecture behav of shift2_sipo is
signal temp: std_logic_vector(15 downto 0);
begin
process (Clock)
begin

if (Clock'event and Clock='1') then
for i in 0 to 6 loop
temp(i+1) <= temp(i);
end loop;
temp(0) <= Sin;
end if ;

end process;
--Pout <= temp;
Pout <= temp(15 downto 8);
end behav;
--