-- A Moore machine's outputs are dependent only on the current state.
-- The output is written only when the state changes.  (State
-- transitions are synchronous.)

library ieee;
use ieee.std_logic_1164.all;

entity MooreMachineState is port(
		clk		 : in	std_logic;
		data_in	 : in	std_logic;
		reset	 : in	std_logic;
		data_out	 : out	std_logic_vector(7 downto 0));
end entity;

architecture rtl of MooreMachineState is

	-- Build an enumerated type for the state machine
	type state_type is (s0, s1, s2, s3, s4, s5, s6, s7);--, s8, s9, s10, s11, s12, s13, s14, s15);
	
	-- Register to hold the current state
	signal state   : state_type;

begin
	-- Logic to advance to the next state
	process (clk, reset)
	begin
		if reset = '0' then
			state <= s0;
		elsif (rising_edge(clk)) then
			case state is
				when s0=>
					if data_in = '1' then
						state <= s1;
					else
						state <= s0;
					end if;
				when s1=>
					if data_in = '1' then
						state <= s2;
					else
						state <= s1;
					end if;
				when s2=>
					if data_in = '1' then
						state <= s3;
					else
						state <= s2;
					end if;
				when s3 =>
					if data_in = '1' then
						state <= s4;
					else
						state <= s3;
					end if;
				when s4 =>
					if data_in = '1' then
						state <= s5;
					else
						state <= s4;
					end if;
				when s5 =>
					if data_in = '1' then
						state <= s6;
					else
						state <= s5;
					end if;
				when s6 =>
					if data_in = '1' then
						state <= s7;
					else
						state <= s6;
					end if;
				when s7 =>
					if data_in = '1' then
						state <= s0;
					else
						state <= s7;
					end if;
--				when s8 =>
--					if data_in = '1' then
--						state <= s9;
--					else
--						state <= s8;
--					end if;
--				when s9 =>
--					if data_in = '1' then
--						state <= s10;
--					else
--						state <= s9;
--					end if;
--				when s10 =>
--					if data_in = '1' then
--						state <= s11;
--					else
--						state <= s10;
--					end if;
--				when s11 =>
--					if data_in = '1' then
--						state <= s12;
--					else
--						state <= s11;
--					end if;
--				when s12 =>
--					if data_in = '1' then
--						state <= s13;
--					else
--						state <= s12;
--					end if;
--				when s13 =>
--					if data_in = '1' then
--						state <= s14;
--					else
--						state <= s13;
--					end if;
--				when s14 =>
--					if data_in = '1' then
--						state <= s15;
--					else
--						state <= s14;
--					end if;
--				when s15 =>
--					if data_in = '1' then
--						state <= s0;
--					else
--						state <= s15;
--					end if;
			end case;
		end if;
	end process;
	
	-- Output depends solely on the current state
	process (state)
	begin
	
		case state is
			when s0 =>
				data_out <= "11111111";
			when s1 =>
				data_out <= "11111110";
			when s2 =>
				data_out <= "11111100";
			when s3 =>
				data_out <= "11111000";
			when s4 =>
				data_out <= "11110000";
			when s5 =>
				data_out <= "11100000";
			when s6 =>
				data_out <= "11000000";
			when s7 =>
				data_out <= "10000000";
--			when s8 =>
--				data_out <= "11111111";
--			when s9 =>
--				data_out <= "11111110";
--			when s10 =>
--				data_out <= "11111100";
--			when s11 =>
--				data_out <= "11111000";
--			when s12 =>
--				data_out <= "11110000";
--			when s13 =>
--				data_out <= "11100000";
--			when s14 =>
--				data_out <= "11000000";
--			when s15 =>
--				data_out <= "10000000";
		end case;
	end process;
	
end rtl;