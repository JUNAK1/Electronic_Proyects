-------------------------------------------------------------------
-- University: Universidad Pedagógica y Tecnológica de Colombia
-- Create Date: 13/05/2020
-- Project Name: DAC
-- Description: 
-- 	This Test Bench script simulate an 8-bit DAC.
--		The formar for the voltages is: "sign - integer part - decimal part"
--
--		Example:
--			For represent 2.25V with bits_int = 3 and bits_res = 8
--				"0_010_01000000" => (without the "_" character)
--			
--			For represent -3.25V with bits_int = 3 and bits_res = 8
--				"1_100_11000000"
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Display_7seg_tb is 
end entity;

architecture behavior of Display_7seg_tb is
signal		segm_in	    : std_logic_vector(6 downto 0) :=(others =>'0');
signal		segm_out    : character;


begin

	DUT: entity work.Display_7seg
		port map(
		segm_in	 => segm_in	,
		segm_out => segm_out);
	
	
	process
	begin
	segm_in <= "0111111";
	wait for 10 ns;
	segm_in <= "0000110";
	wait for 10 ns;
	segm_in <= "1011011";
	wait for 10 ns;
	segm_in <= "1001111";
	wait for 10 ns;
	segm_in <= "1100110";
	wait for 10 ns;
	segm_in <= "1101101";
	wait for 10 ns;
	segm_in <= "1111101";
	wait for 10 ns;
	segm_in <= "0000111";
	wait for 10 ns;
	segm_in <= "1111111";
	wait for 10 ns;
	segm_in <= "1101111";
	wait for 10 ns;
	segm_in <= "1110111";
	wait for 10 ns;
	segm_in <= "0000000";
	wait for 10 ns;
	end process;




end architecture;