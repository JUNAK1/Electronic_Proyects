--Juan Camilo Serrano Correa
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity DMUX is
port(f:in std_logic;
s:in std_logic_vector(2 downto 0);
y:out std_logic_vector(7 downto 0));
end DMUX;

architecture behavioral of DMUX is
begin
y(0)<=f when s="000"else'0';
y(1)<=f when s="001"else'0';
y(2)<=f when s="010"else'0';
y(3)<=f when s="011"else'0';
y(4)<=f when s="100"else'0';
y(5)<=f when s="101"else'0';
y(6)<=f when s="110"else'0';
y(7)<=f when s="111"else'0';
end behavioral;
