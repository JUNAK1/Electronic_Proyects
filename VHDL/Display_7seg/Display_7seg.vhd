-------------------------------------------------------------------
-- University: Universidad Pedagógica y Tecnológica de Colombia
-- Create Date: 27/05/2020
-- Project Name: 7 segment display simulation model
-- Description: 
-- 	This description emulates the ideal behavior of an 7 segment common cathode display
--		input: 7 segment pattern 
--  output: printable character on modelsim waveform
-------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity Display_7seg is
	generic(Mode :std_logic :='0'); --0 para catodo comun, 1 para anodo comun
	port(
		segm_in	    :in std_logic_vector(6 downto 0);
		segm_out    :out character
	);
end entity;

architecture behavior of Display_7seg is

signal letra :character;
signal dipslay_mode :std_logic_vector(6 downto 0);
begin
	
	dipslay_mode <= segm_in xor mode;
	
	with dipslay_mode select
		letra <=	'0' when "0111111", 
					'1' when "0000110",
					'2' when "1011011",
					'3' when "1001111",
					'4' when "1100110",
					'5' when "1101101",
					'6' when "1111101",
					'7' when "0000111",
					'8' when "1111111",
					'9' when "1101111",
					'A' when "1110111",
					-- 'B' when "",
					-- 'C' when "",
					-- 'D' when "",
					-- 'E' when "",
					-- 'F' when "",
					nul when others;

	process
	begin
		wait on letra;
		segm_out <= letra;
		report "DISPLAY = " & letra;
	end process;
	
end architecture;