--Juan Camilo Serrano Correa
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all; 
Entity CONTADOR_TB is 
End entity;

Architecture Test of CONTADOR_TB is 

signal CLK,Reset : std_logic:='0'; 
signal Salida: std_logic_vector(2 downto 0):=(others=>'0');

Begin 
DUT:entity work.CONTADOR
	Port map( 
			CLK	=>CLK,
			Reset	=>Reset,
			Salida=>Salida
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
        Reset <= '0';
        wait for 40 ns;
        Reset <= '1';
        wait;
   end process;
	
	
End Test; 