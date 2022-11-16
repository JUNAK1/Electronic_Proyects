--Juan Camilo Serrano Correa
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all; 
Entity Processor_TB is 
End entity;

Architecture Test of Processor_TB is 
Signal	CLOK,Reset : std_logic:='0'; 
Signal   Salida: std_LOGIC_VECTOR(7 downto 0):=(others=>'0');

Begin 
DUT:entity work.Processor
	Port map( 
			CLOK	=>CLOK,
			Reset	=>Reset,
			Salida=>Salida
			);
	clok_process :process
   begin
        CLOK <= '1';
        wait for 5 ns;
        CLOK <= '0';
        wait for 5 ns;
   end process;
	
	Reset_process :process
   begin
        Reset <= '1';-- '0'
        wait for 10 ns;
        Reset <= '1';
        wait;
   end process;
End Test; 
