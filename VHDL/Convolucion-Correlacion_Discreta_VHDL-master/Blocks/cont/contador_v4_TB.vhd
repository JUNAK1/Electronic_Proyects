--Juan Camilo Serrano Correa
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all; 
Entity contador_v4_TB is 
End entity;

Architecture Test of contador_v4_TB is 

SIGNAL  clk    :  STD_LOGIC:='0';
SIGNAL  reset :  STD_LOGIC:='0';
SIGNAL  cnt_out: STD_LOGIC_VECTOR(3 DOWNTO 0):=(others=>'0');

Begin 
DUT:entity work.contador_v4
	Port map( 
			CLK	=>CLK,
			Reset	=>Reset,
			cnt_out=>cnt_out
			);
	clok_process :process
   begin
        CLK <= '0';
        wait for 20 ns;
        CLK <= '1';
        wait for 20 ns;
   end process;
	
	Reset_process :process
   begin
        Reset <= '1';
        wait for 40 ns;
        Reset <= '0';
        wait;
   end process;
	
	
End Test; 