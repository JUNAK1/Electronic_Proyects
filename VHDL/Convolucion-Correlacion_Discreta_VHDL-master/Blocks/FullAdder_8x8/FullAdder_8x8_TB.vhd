--Juan Camilo Serrano Correa
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;
USE ieee.std_logic_unsigned.all; 
Entity FullAdder_8x8_TB is 
End entity;

Architecture Test of FullAdder_8x8_TB is 
signal Add0 : std_logic_vector(5 downto 0):=(others=>'0');
signal Add1 : std_logic_vector(5 downto 0):=(others=>'0');
signal Add2 : std_logic_vector(5 downto 0):=(others=>'0');
signal Add3 : std_logic_vector(5 downto 0):=(others=>'0');
signal Add4 : std_logic_vector(5 downto 0):=(others=>'0');
signal Add5 : std_logic_vector(5 downto 0):=(others=>'0'); 
signal Add6 : std_logic_vector(5 downto 0):=(others=>'0');
signal Add7 : std_logic_vector(5 downto 0):=(others=>'0');
signal Salida : std_logic_vector(9 downto 0):=(others=>'0');

Begin 
DUT:entity work.FullAdder_8x8
	Port map( 
Add0 => Add0,		
Add1 => Add1,	
Add2 => Add2,
Add3 => Add3,
Add4 => Add4,
Add5 => Add5,
Add6 => Add6,
Add7 => Add7,
Salida=>Salida
	);
			
	adds_process :process
   begin
	Add0 <= "110000";
	Add1 <= "110000";
	Add2 <= "110000";
	Add3 <= "110000";
	Add4 <= "110000";
	Add5 <= "110000";
	Add6 <= "110000";		
   Add7 <= "110000";  
        wait for 10 ns;

	Add0 <= "000110";	  
	Add1 <= "000110";	  
	Add2 <= "000110";	  
	Add3 <= "000110";	  
	Add4 <= "000110";	  
	Add5 <= "000110";	  
	Add6 <= "000110";	  
	Add7 <= "000110";	  
	wait for 10 ns;
		  
		  Add0 <= "000010";
		  Add1 <= "000010";
		  Add2 <= "000010";
		  Add3 <= "000010";
		  Add4 <= "000010";
		  Add5 <= "000010";
		  Add6 <= "000010";
		  Add7 <= "000010";
		  wait for 10 ns;
   end process;

End Test; 