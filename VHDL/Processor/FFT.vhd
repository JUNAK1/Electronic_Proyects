library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FFT is
  Port (T,R,CLK :IN std_logic;
   Q: OUT std_logic );
end FFT;

architecture Behavioral of FFT is
SIGNAL Q_S : std_logic;
begin
Process (clk, r, t) 
begin
    if r = '0' then
        Q_S <= '1';
    elsif rising_edge (clk) and (T = '1') then
        Q_S <= NOT Q_S;
    elsif rising_edge (clk) and (T = '0') then
        Q_S <= Q_S;
    end if;
end process;
    Q <= Q_S;
end Behavioral;