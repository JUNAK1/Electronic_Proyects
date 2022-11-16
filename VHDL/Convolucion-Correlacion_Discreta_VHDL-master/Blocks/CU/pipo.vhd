library ieee;
use ieee.std_logic_1164.all;
entity pipo is
port (
clk,rst,en: in std_logic;
	d:in std_logic;
	qo:out std_logic
);
end entity pipo;

architecture Registro of pipo is
 begin 
 process(clk,rst)
  begin 
	if rst = '0' then qo<= '0';
	elsif rising_edge(clk) then 
	if en ='0' then qo<=d;
	end if;end if;end process;
end registro;