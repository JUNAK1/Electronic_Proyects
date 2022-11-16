--Juan Camilo Serrano Correa
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all; 
Entity COR_TB is 
End entity;

Architecture Test of COR_TB is 

signal CLK,Reset : std_logic:='0'; 
signal CH_1, CH_2: std_logic_vector(2 downto 0):=(others=>'0');
signal EEXIT : std_logic_vector(9 downto 0):=(others=>'0');

Begin 
DUT:entity work.COR
	Port map( 
			CLK	=>CLK,
			Reset	=>Reset,
			CH_1 => CH_1,
			CH_2 => CH_2,
			EEXIT=>EEXIT
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
        Reset <= '1';
        wait;
   end process;
		CHANEL1_process :process
   begin
        CH_1 <= "001";
        wait for 40 ns;
        CH_1 <= "010";
        wait for 40 ns;
        CH_1 <= "011";
        wait for 40 ns;
        CH_1 <= "100";
        wait for 40 ns;
        CH_1 <= "011";
        wait for 40 ns;
        CH_1 <= "010";
        wait for 40 ns;
        CH_1 <= "001";
        wait for 40 ns;
        CH_1 <= "000";
        wait for 40 ns;
   end process;
	
	CHANEL2_process :process
   begin
        CH_2 <= "001";
        wait for 40 ns;
        CH_2 <= "010";
        wait for 40 ns;
        CH_2 <= "011";
        wait for 40 ns;
        CH_2 <= "100";
        wait for 40 ns;
        CH_2 <= "011";
        wait for 40 ns;
        CH_2 <= "010";
        wait for 40 ns;
        CH_2 <= "001";
        wait for 40 ns;
        CH_2 <= "000";
        wait for 40 ns;
   end process;
--	CHANEL1_process :process
--   begin
--        CH_1 <= "000";
--        wait for 40 ns;
--        CH_1 <= "001";
--        wait for 40 ns;
--        CH_1 <= "010";
--        wait for 40 ns;
--        CH_1 <= "011";
--        wait for 40 ns;
--        CH_1 <= "100";
--        wait for 40 ns;
--        CH_1 <= "101";
--        wait for 40 ns;
--        CH_1 <= "110";
--        wait for 40 ns;
--        CH_1 <= "111";
--        wait for 40 ns;
--   end process;
--	
--	CHANEL2_process :process
--   begin
--        CH_2 <= "000";
--        wait for 40 ns;
--        CH_2 <= "001";
--        wait for 40 ns;
--        CH_2 <= "010";
--        wait for 40 ns;
--        CH_2 <= "011";
--        wait for 40 ns;
--        CH_2 <= "100";
--        wait for 40 ns;
--        CH_2 <= "101";
--        wait for 40 ns;
--        CH_2 <= "110";
--        wait for 40 ns;
--        CH_2 <= "111";
--        wait for 40 ns;
--   end process;
End Test; 