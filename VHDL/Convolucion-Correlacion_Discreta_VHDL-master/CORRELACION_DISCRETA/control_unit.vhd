--Juan Camilo Serrano Correa
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control_unit is
Port ( 
	CLOK,Reset : IN std_logic; 
	CHANNEL_1, CHANNEL_2 : in std_logic_vector(2 downto 0);
	SA0,SA1,SA2,SA3,SA4,SA5,SA6,SA7,B0,B1,B2,B3,B4,B5,B6,B7: out std_logic_vector (2 downto 0)
);
end Control_unit;
architecture Behavioral of Control_unit is
signal b0_or0,b0_or1,b0_or2,b0_or3,b0_or4,b0_or5,b0_or6,b0_or7 : std_logic;
signal b1_or0,b1_or1,b1_or2,b1_or3,b1_or4,b1_or5,b1_or6,b1_or7 : std_logic;
signal b2_or0,b2_or1,b2_or2,b2_or3,b2_or4,b2_or5,b2_or6,b2_or7 : std_logic;

signal or00,or01,or02,or10,or11,or12,or20,or21,or22,or30,or31,or32: std_logic_vector (14 downto 0);
signal or40,or41,or42,or50,or51,or52,or60,or61,or62,or70,or71,or72: std_logic_vector (14 downto 0);
signal A0,A1,A2,A3,A4,A5,A6,A7: std_logic_vector (2 downto 0);
signal O_CHANNEL_10,O_CHANNEL_11,O_CHANNEL_12 : std_logic_vector(7 downto 0);
signal O_CHANNEL_20,O_CHANNEL_21,O_CHANNEL_22 : std_logic_vector(7 downto 0);
Signal S_CHANNEL_1, S_CHANNEL_2 : std_logic_vector(2 downto 0);
signal x, M0,M1,M2,M3,M4,M5,M6,M7: std_logic_vector(2 downto 0);
Signal y: std_logic_vector(3 downto 0);
signal N0,N1,N2,N3,N4,N5,N6,N7: std_logic_vector(2 downto 0);
signal MachineMoore : std_logic_vector(7 downto 0);
signal S_cont : std_LOGIC_VECTOR(3 downto 0);

Component CONTADOR is Port (
	CLK : IN std_logic; 
	Reset : IN std_logic;
	Salida : OUT std_logic_vector(3 downto 0));
end component;

Component pipo is port(
clk,rst,en: in std_logic;
	d:in std_logic_vector(2 downto 0);
	qo:out std_logic_vector(2 downto 0)
);
end component;

Component DMUX_7_3 is port(
f:in std_logic_vector(2 downto 0);
s:in std_logic_vector(2 downto 0);
y1,y2,y3:out std_logic_vector(7 downto 0));
end component;

Component MooreMachineState is port(
		clk		 : in	std_logic;
		data_in	 : in	std_logic;
		reset	 : in	std_logic;
		data_out	 : out	std_logic_vector(7 downto 0));
end component;

component DMUX_15_3 is port(
f:in std_logic_vector(2 downto 0);
s:in std_logic_vector(3 downto 0);
y1,y2,y3:out std_logic_vector(14 downto 0));
end component;

component contador_v4 is port(
  clk    : IN  STD_LOGIC;
  reset : IN  STD_LOGIC;
  cnt_out: OUT STD_LOGIC_VECTOR(3 DOWNTO 0));
end component;


begin
MOORE : MooreMachineState port map (clok, '1', Reset, MachineMoore );
Cont : contador_v4 port map (	clok, '0',S_cont );
SWITCH0 : DMUX_7_3 port map (S_CHANNEL_1, x, O_CHANNEL_10,O_CHANNEL_11,O_CHANNEL_12);
SWITCH1 : DMUX_7_3 port map (S_CHANNEL_2, x, O_CHANNEL_20,O_CHANNEL_21,O_CHANNEL_22);
CLK1 : CONTADOR port map (CLOK, Reset, y);
RETN0 : pipo port map(CLOK, Reset, '1', CHANNEL_1, S_CHANNEL_1);
RETN1 : pipo port map(CLOK, Reset, '1', CHANNEL_2, S_CHANNEL_2);
LOOOP0: DMUX_15_3 port map(A0,S_cont,or00,or01,or02);
LOOOP1: DMUX_15_3 port map(A1,S_cont,or10,or11,or12);
LOOOP2: DMUX_15_3 port map(A2,S_cont,or20,or21,or22);
LOOOP3: DMUX_15_3 port map(A3,S_cont,or30,or31,or32);
LOOOP4: DMUX_15_3 port map(A4,S_cont,or40,or41,or42);
LOOOP5: DMUX_15_3 port map(A5,S_cont,or50,or51,or52);
LOOOP6: DMUX_15_3 port map(A6,S_cont,or60,or61,or62);
LOOOP7: DMUX_15_3 port map(A7,S_cont,or70,or71,or72);
b0_or0 <= or00(0) or or10(1) or or20(2) or or30(3) or or40(4) or or50(5) or or60(6) or or70(7);
b0_or1 <= or00(1) or or10(2) or or20(3) or or30(4) or or40(5) or or50(6) or or60(7) or or70(8);
b0_or2 <= or00(2) or or10(3) or or20(4) or or30(5) or or40(6) or or50(7) or or60(8) or or70(9);
b0_or3 <= or00(3) or or10(4) or or20(5) or or30(6) or or40(7) or or50(8) or or60(9) or or70(10);
b0_or4 <= or00(4) or or10(5) or or20(6) or or30(7) or or40(8) or or50(9) or or60(10) or or70(11);
b0_or5 <= or00(5) or or10(6) or or20(7) or or30(8) or or40(9) or or50(10) or or60(11) or or70(12);
b0_or6 <= or00(6) or or10(7) or or20(8) or or30(9) or or40(10) or or50(11) or or60(12) or or70(13);
b0_or7 <= or00(7) or or10(8) or or20(9) or or30(10) or or40(11) or or50(12) or or60(13) or or70(14);

b1_or0 <= or01(0) or or11(1) or or21(2) or or31(3) or or41(4) or or51(5) or or61(6) or or71(7);
b1_or1 <= or01(1) or or11(2) or or21(3) or or31(4) or or41(5) or or51(6) or or61(7) or or71(8);
b1_or2 <= or01(2) or or11(3) or or21(4) or or31(5) or or41(6) or or51(7) or or61(8) or or71(9);
b1_or3 <= or01(3) or or11(4) or or21(5) or or31(6) or or41(7) or or51(8) or or61(9) or or71(10);
b1_or4 <= or01(4) or or11(5) or or21(6) or or31(7) or or41(8) or or51(9) or or61(10) or or71(11);
b1_or5 <= or01(5) or or11(6) or or21(7) or or31(8) or or41(9) or or51(10) or or61(11) or or71(12);
b1_or6 <= or01(6) or or11(7) or or21(8) or or31(9) or or41(10) or or51(11) or or61(12) or or71(13);
b1_or7 <= or01(7) or or11(8) or or21(9) or or31(10) or or41(11) or or51(12) or or61(13) or or71(14);

b2_or0 <= or02(0) or or12(1) or or22(2) or or32(3) or or42(4) or or52(5) or or62(6) or or72(7);
b2_or1 <= or02(1) or or12(2) or or22(3) or or32(4) or or42(5) or or52(6) or or62(7) or or72(8);
b2_or2 <= or02(2) or or12(3) or or22(4) or or32(5) or or42(6) or or52(7) or or62(8) or or72(9);
b2_or3 <= or02(3) or or12(4) or or22(5) or or32(6) or or42(7) or or52(8) or or62(9) or or72(10);
b2_or4 <= or02(4) or or12(5) or or22(6) or or32(7) or or42(8) or or52(9) or or62(10) or or72(11);
b2_or5 <= or02(5) or or12(6) or or22(7) or or32(8) or or42(9) or or52(10) or or62(11) or or72(12);
b2_or6 <= or02(6) or or12(7) or or22(8) or or32(9) or or42(10) or or52(11) or or62(12) or or72(13);
b2_or7 <= or02(7) or or12(8) or or22(9) or or32(10) or or42(11) or or52(12) or or62(13) or or72(14);

SA0 <= b0_or0 & b1_or0 & b2_or0;
SA1 <= b0_or1 & b1_or1 & b2_or1;
SA2 <= b0_or2 & b1_or2 & b2_or2;
SA3 <= b0_or3 & b1_or3 & b2_or3;
SA4 <= b0_or4 & b1_or4 & b2_or4;
SA5 <= b0_or5 & b1_or5 & b2_or5;
SA6 <= b0_or6 & b1_or6 & b2_or6;
SA7 <= b0_or7 & b1_or7 & b2_or7;

--	
x <= y(2 downto 0);

M0 <= O_CHANNEL_10(0)&O_CHANNEL_11(0)&O_CHANNEL_12(0);
M1 <= O_CHANNEL_10(1)&O_CHANNEL_11(1)&O_CHANNEL_12(1);
M2 <= O_CHANNEL_10(2)&O_CHANNEL_11(2)&O_CHANNEL_12(2);
M3 <= O_CHANNEL_10(3)&O_CHANNEL_11(3)&O_CHANNEL_12(3);
M4 <= O_CHANNEL_10(4)&O_CHANNEL_11(4)&O_CHANNEL_12(4);
M5 <= O_CHANNEL_10(5)&O_CHANNEL_11(5)&O_CHANNEL_12(5);
M6 <= O_CHANNEL_10(6)&O_CHANNEL_11(6)&O_CHANNEL_12(6);
M7 <= O_CHANNEL_10(7)&O_CHANNEL_11(7)&O_CHANNEL_12(7);

N0 <= O_CHANNEL_20(0)&O_CHANNEL_21(0)&O_CHANNEL_22(0);
N1 <= O_CHANNEL_20(1)&O_CHANNEL_21(1)&O_CHANNEL_22(1);
N2 <= O_CHANNEL_20(2)&O_CHANNEL_21(2)&O_CHANNEL_22(2);
N3 <= O_CHANNEL_20(3)&O_CHANNEL_21(3)&O_CHANNEL_22(3);
N4 <= O_CHANNEL_20(4)&O_CHANNEL_21(4)&O_CHANNEL_22(4);
N5 <= O_CHANNEL_20(5)&O_CHANNEL_21(5)&O_CHANNEL_22(5);
N6 <= O_CHANNEL_20(6)&O_CHANNEL_21(6)&O_CHANNEL_22(6);
N7 <= O_CHANNEL_20(7)&O_CHANNEL_21(7)&O_CHANNEL_22(7);
																					
RAM10: pipo port map(CLOK, Reset, MachineMoore(0),M0,A0);
RAM11: pipo port map(CLOK, Reset, MachineMoore(1),M1,A1);
RAM12: pipo port map(CLOK, Reset, MachineMoore(2),M2,A2);
RAM13: pipo port map(CLOK, Reset, MachineMoore(3),M3,A3);
RAM14: pipo port map(CLOK, Reset, MachineMoore(4),M4,A4);
RAM15: pipo port map(CLOK, Reset, MachineMoore(5),M5,A5);
RAM16: pipo port map(CLOK, Reset, MachineMoore(6),M6,A6);
RAM17: pipo port map(CLOK, Reset, MachineMoore(7),M7,A7);

RAM20: pipo port map(CLOK, Reset, MachineMoore(0),N0,B0);
RAM21: pipo port map(CLOK, Reset, MachineMoore(1),N1,B1);
RAM22: pipo port map(CLOK, Reset, MachineMoore(2),N2,B2);
RAM23: pipo port map(CLOK, Reset, MachineMoore(3),N3,B3);
RAM24: pipo port map(CLOK, Reset, MachineMoore(4),N4,B4);
RAM25: pipo port map(CLOK, Reset, MachineMoore(5),N5,B5);
RAM26: pipo port map(CLOK, Reset, MachineMoore(6),N6,B6);
RAM27: pipo port map(CLOK, Reset, MachineMoore(7),N7,B7);
end Behavioral;
--Juan Camilo Serrano Correa