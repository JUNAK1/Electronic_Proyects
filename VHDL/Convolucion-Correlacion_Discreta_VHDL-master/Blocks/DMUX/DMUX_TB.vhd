--Juan Camilo Serrano Correa
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all; 
Entity DMUX_TB is 
End entity;

Architecture Test of DMUX_TB is 
Signal	f : std_logic:='0'; 
Signal   s: std_LOGIC_VECTOR(2 downto 0):=(others=>'0');
Signal   y: std_LOGIC_VECTOR(7 downto 0):=(others=>'0');

Begin 
DUT:entity work.DMUX
	Port map( 
			f	=>f,
			s	=>s,
			y=>y
			);
	f_process :process
   begin
        f <= '1';
        wait for 5 ns;
   end process;

	s_process :process
   begin
        s <= "000";
        wait for 10 ns;
		  s <= "001";
        wait for 10 ns;
        s <= "010";
        wait for 10 ns;
		  s <= "011";
        wait for 10 ns;
		  s <= "100";
        wait for 10 ns;
		  s <= "101";
        wait for 10 ns;
		  s <= "110";
        wait for 10 ns;
		  s <= "111";
        wait for 10 ns;
   end process;
	
--	s_process :process
--   begin
--        f <= "000";
--        wait for 10 ns;
--		  f <= "001";
--        wait for 10 ns;
--        f <= "010";
--        wait for 10 ns;
--		  f <= "011";
--        wait for 10 ns;
--        f <= "100";
--        wait for 10 ns;
--		  f <= "101";
--        wait for 10 ns;
--        f <= "110";
--        wait for 10 ns;
--		  f <= "111";
--        wait for 10 ns;
--        
--        wait;
--   end process;
End Test; 