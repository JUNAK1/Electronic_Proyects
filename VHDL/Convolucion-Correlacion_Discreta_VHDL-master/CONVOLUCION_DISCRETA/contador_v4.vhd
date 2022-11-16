library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
 
entity contador_v4 is
    PORT (
        clk    : IN  STD_LOGIC;
        reset : IN  STD_LOGIC;
        cnt_out: OUT STD_LOGIC_VECTOR(3 DOWNTO 0)
    );
end contador_v4;
 
architecture Behavioral of contador_v4 is
    -- Señal temporal para el contador.
    signal cnt_tmp,data: STD_LOGIC_VECTOR(3 DOWNTO 0) := "0000";
	 signal aload: std_LOGIC:='0';
begin
    proceso_contador: process (aload, reset, clk, data) begin
        if reset = '1' then
            cnt_tmp <= "0000";
        elsif aload = '1' then
            cnt_tmp <= data;
        elsif rising_edge(clk) then
            if cnt_tmp = "1110" then
                cnt_tmp <= "0000";
            else
                cnt_tmp <= cnt_tmp + 1;
            end if;
        end if;
    end process;
 
    cnt_out <= cnt_tmp;
end Behavioral;