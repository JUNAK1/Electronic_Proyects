--Juan Camilo Serrano Correa
library ieee;
use ieee.std_logic_1164.all;
entity FF_D is
	port (
	clk,rst: in std_logic;
	d:in std_logic;
	q:out std_logic
	);
end entity FF_D;
architecture ARCH of FF_D is
Signal D0, D1, D2, D3: STD_logic;
begin 
	Shift :process(clk,rst)
begin 
if rst = '0' then 
	D0<= '0'; D1<= '0'; D2<= '0'; D3<= '0'; 
elsif(clk' event and clk = '1') then 
		D0<=D; D1 <=D0; D2 <=D1; D3 <=D2; 
end if;end process;
   q <= D1;---D1
end ARCH;
--Juan Camilo Serrano Correa