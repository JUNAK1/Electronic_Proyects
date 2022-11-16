library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CONTADOR is
Port (CLK : IN std_logic; 
Reset : IN std_logic;
Salida : OUT std_logic_vector(2 downto 0));
end CONTADOR;

architecture Behavioral of CONTADOR is

component FFT is port (
t,r,clk : in std_logic; 
q : out std_logic);
end component;
signal contador: std_logic_vector(2 downto 0);
begin
bit0 : FFT port map ('1', Reset, CLK, contador(0));
bit1 : FFT port map ('1', Reset, contador(0), contador(1));
bit2 : FFT port map ('1', Reset, contador(1), contador(2));
 
Salida <= not contador;
end Behavioral;