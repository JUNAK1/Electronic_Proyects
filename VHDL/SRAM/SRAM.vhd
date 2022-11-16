-------------------------------------------------------------------
-- University: Universidad Pedagógica y Tecnológica de Colombia
-- Create Date: 25/05/2020
-- Project Name: SRAM
-- Description:
-------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity SRAM is
	generic(
		word_bits	:natural := 16;
		add_bits		:natural := 18
	);
	port(
		CE				:in std_logic;
		WE				:in std_logic;
		OE				:in std_logic;
		LB				:in std_logic;
		UB				:in std_logic;
		addr 			    :in std_logic_vector(add_bits - 1 downto 0);		
		data			:inout std_logic_vector(word_bits - 1 downto 0)
	);
end entity;

architecture behav of SRAM is
	type matrix is array (2**add_bits - 1 downto 0) of std_logic_vector(word_bits/2-1 downto 0);
	signal cell_LB		:matrix :=(Others=>(others=>'1'));
	signal cell_UB		:matrix :=(Others=>(others=>'1'));
	signal dec			:std_logic_vector(2**add_bits - 1 downto 0);
	signal WR_LB		:std_logic;
	signal WR_UB		:std_logic;
begin
	---------------------------------------------------------
	-- Decoder
	---------------------------------------------------------

	---------------------------------------------------------
	-- Memory
	---------------------------------------------------------
	-- Lower bits
	WR_LB <= (not WE) and (not CE) and (not LB);

				
	latch_LB: process(data, addr , WR_LB)
	begin
		if ((WR_LB) = '1') then
			for i in 0 to word_bits/2-1 loop
				if data(i)='Z' then
					cell_LB(to_integer(unsigned(addr )))(i) <= '1';
				else
					cell_LB(to_integer(unsigned(addr )))(i) <= data(i);
				end if;			
			end loop;
			--cell_LB(to_integer(unsigned(addr ))) <= data(word_bits/2 -1 downto 0);	
		end if;
	end process;
	
	
	data(word_bits/2 -1 downto 0) <= cell_LB(to_integer(unsigned(addr ))) when ((not CE) and (not OE) and WE and (not LB)) = '1' else (others=>'Z');

	
	-- Upper bits
	WR_UB <= (not WE) and (not CE) and (not UB);
	
					
	latch_UB: process(data, addr , WR_UB)
	begin
		if ((WR_UB) = '1') then
			for i in word_bits/2 to word_bits-1 loop
				if data(i)='Z' then
					cell_UB(to_integer(unsigned(addr )))(i-word_bits/2) <= '1';
				else
					cell_UB(to_integer(unsigned(addr )))(i-word_bits/2) <= data(i);
				end if;			
			end loop;
			--cell_UB(to_integer(unsigned(addr ))) <= data(word_bits -1 downto word_bits/2);
		end if;
	end process;
		
	data(word_bits -1 downto word_bits/2) <= cell_UB(to_integer(unsigned(addr ))) when ((not CE) and (not OE) and WE and (not UB)) = '1' else (others=>'Z');


	-- process
	-- begin	
	-- wait on addr ,CE,OE,WE,UB,LB,cell_LB,cell_UB;
	-- wait for 8 ns;
	-- if(((not CE) and (not OE) and WE and (not UB)) = '1' ) then
		-- data(word_bits -1 downto word_bits/2) <= cell_UB(to_integer(unsigned(addr )));
	-- else
		-- data(word_bits -1 downto word_bits/2) <= (others=>'Z');
	-- end if;
	-- if(((not CE) and (not OE) and WE and (not LB)) = '1' ) then
		-- data(word_bits/2 -1 downto 0) <= cell_LB(to_integer(unsigned(addr )));
	-- else
		-- data(word_bits/2 -1 downto 0) <= (others=>'Z');
	-- end if;
	-- end process;
	


end architecture;