--Juan Camilo Serrano Correa
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all; 
Entity PIPO_TB is 
End entity;

Architecture Test of PIPO_TB is 



signal clk,rst,en : std_logic:='0'; 
signal d,qo: std_logic_vector(2 downto 0):=(others=>'0');

Begin 
DUT:entity work.pipo
	Port map( 
			clk	=>clk,
			rst	=>rst,
			en=>en,
			d=>d,
			qo=>qo
			);
			
	clok_process :process
   begin
        clk <= '0';
        wait for 10 ns;
        clk <= '1';
        wait for 10 ns;
   end process;

	en_process :process
   begin
        en<= '0';
        wait for 250 ns;
        en <= '1';
        wait for 250 ns;
   end process;
	
	Reset_process :process
   begin
        rst <= '0';
        wait for 40 ns;
        rst <= '1';
        wait;
   end process;
	
	d_process :process
   begin
        d <= "000";
        wait for 50 ns;
        d <= "001";
        wait for 50 ns;
        d <= "010";
        wait for 50 ns;
        d <= "011";
        wait for 50 ns;
        d <= "111";
        wait for 50 ns;
		  
   end process;
	
End Test; 