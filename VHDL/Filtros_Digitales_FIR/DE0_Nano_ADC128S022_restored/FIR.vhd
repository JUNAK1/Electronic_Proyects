library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity FIR is
generic(Nbits :natural := 24);
port(
	clk_i			:in	std_logic;
	rst_i			:in	std_logic;
	en_i			:in	std_logic;
	input_filter	:in	std_logic_vector(Nbits-1 downto 0);
	response_filter	:out	std_logic_vector(Nbits-1 downto 0)
	);
end entity FIR;


architecture rtl of FIR is
constant  N   :natural :=201;--numero de coeficientes
Constant  fix :natural :=16;-- cantidad de bits de la parte fraccionaria
Constant  K   :natural :=16;-- Cantidad de bits requeridos para los coeficientes

type coef	is array(0 to N-1) of signed(K-1 downto 0);
constant coeficiente : coef :=(to_signed(0,K),
to_signed(0,K),
to_signed(0,K),
to_signed(0,K),
to_signed(0,K),
to_signed(0,K),
to_signed(0,K),
to_signed(0,K),
to_signed(0,K),
to_signed(0,K),
to_signed(0,K),
to_signed(0,K),
to_signed(0,K),
to_signed(0,K),
to_signed(0,K),
to_signed(1,K),
to_signed(1,K),
to_signed(0,K),
to_signed(-2,K),
to_signed(-4,K),
to_signed(-5,K),
to_signed(-3,K),
to_signed(-1,K),
to_signed(1,K),
to_signed(2,K),
to_signed(0,K),
to_signed(-2,K),
to_signed(-2,K),
to_signed(2,K),
to_signed(12,K),
to_signed(21,K),
to_signed(24,K),
to_signed(16,K),
to_signed(0,K),
to_signed(-15,K),
to_signed(-22,K),
to_signed(-17,K),
to_signed(-4,K),
to_signed(1,K),
to_signed(-8,K),
to_signed(-34,K),
to_signed(-60,K),
to_signed(-67,K),
to_signed(-40,K),
to_signed(15,K),
to_signed(74,K),
to_signed(104,K),
to_signed(90,K),
to_signed(44,K),
to_signed(2,K),
to_signed(0,K),
to_signed(44,K),
to_signed(102,K),
to_signed(120,K),
to_signed(57,K),
to_signed(-80,K),
to_signed(-231,K),
to_signed(-313,K),
to_signed(-274,K),
to_signed(-133,K),
to_signed(24,K),
to_signed(101,K),
to_signed(55,K),
to_signed(-60,K),
to_signed(-126,K),
to_signed(-35,K),
to_signed(221,K),
to_signed(528,K),
to_signed(700,K),
to_signed(599,K),
to_signed(241,K),
to_signed(-199,K),
to_signed(-488,K),
to_signed(-483,K),
to_signed(-241,K),
to_signed(0,K),
to_signed(-19,K),
to_signed(-388,K),
to_signed(-926,K),
to_signed(-1259,K),
to_signed(-1053,K),
to_signed(-259,K),
to_signed(804,K),
to_signed(1608,K),
to_signed(1732,K),
to_signed(1162,K),
to_signed(341,K),
to_signed(-83,K),
to_signed(292,K),
to_signed(1284,K),
to_signed(2115,K),
to_signed(1827,K),
to_signed(-95,K),
to_signed(-3248,K),
to_signed(-6320,K),
to_signed(-7652,K),
to_signed(-6105,K),
to_signed(-1774,K),
to_signed(3885,K),
to_signed(8637,K),
to_signed(10485,K),
to_signed(8637,K),
to_signed(3885,K),
to_signed(-1774,K),
to_signed(-6105,K),
to_signed(-7652,K),
to_signed(-6320,K),
to_signed(-3248,K),
to_signed(-95,K),
to_signed(1827,K),
to_signed(2115,K),
to_signed(1284,K),
to_signed(292,K),
to_signed(-83,K),
to_signed(341,K),
to_signed(1162,K),
to_signed(1732,K),
to_signed(1608,K),
to_signed(804,K),
to_signed(-259,K),
to_signed(-1053,K),
to_signed(-1259,K),
to_signed(-926,K),
to_signed(-388,K),
to_signed(-19,K),
to_signed(0,K),
to_signed(-241,K),
to_signed(-483,K),
to_signed(-488,K),
to_signed(-199,K),
to_signed(241,K),
to_signed(599,K),
to_signed(700,K),
to_signed(528,K),
to_signed(221,K),
to_signed(-35,K),
to_signed(-126,K),
to_signed(-60,K),
to_signed(55,K),
to_signed(101,K),
to_signed(24,K),
to_signed(-133,K),
to_signed(-274,K),
to_signed(-313,K),
to_signed(-231,K),
to_signed(-80,K),
to_signed(57,K),
to_signed(120,K),
to_signed(102,K),
to_signed(44,K),
to_signed(0,K),
to_signed(2,K),
to_signed(44,K),
to_signed(90,K),
to_signed(104,K),
to_signed(74,K),
to_signed(15,K),
to_signed(-40,K),
to_signed(-67,K),
to_signed(-60,K),
to_signed(-34,K),
to_signed(-8,K),
to_signed(1,K),
to_signed(-4,K),
to_signed(-17,K),
to_signed(-22,K),
to_signed(-15,K),
to_signed(0,K),
to_signed(16,K),
to_signed(24,K),
to_signed(21,K),
to_signed(12,K),
to_signed(2,K),
to_signed(-2,K),
to_signed(-2,K),
to_signed(0,K),
to_signed(2,K),
to_signed(1,K),
to_signed(-1,K),
to_signed(-3,K),
to_signed(-5,K),
to_signed(-4,K),
to_signed(-2,K),
to_signed(0,K),
to_signed(1,K),
to_signed(1,K),
to_signed(0,K),
to_signed(0,K),
to_signed(0,K),
to_signed(0,K),
to_signed(0,K),
to_signed(0,K),
to_signed(0,K),
to_signed(0,K),
to_signed(0,K),
to_signed(0,K),
to_signed(0,K),
to_signed(0,K),
to_signed(0,K),
to_signed(0,K),
to_signed(0,K));


--fix debe ser igual a: 16
--N debe ser igual a: 201
--K debe ser igual a: 16


type taps	is array(0 to N-1) of signed(Nbits-1 downto 0);
signal taps_delay 	:taps;

type mult	is array(0 to N-1) of signed(K+Nbits-1 downto 0);
signal product 	:mult;

type add	is array(0 to N-1) of signed(K+Nbits+3 downto 0);
signal acum 	:add;

signal resultado	: signed(K+Nbits+3-fix downto 0);
signal p_entera	: signed(Nbits-1 downto 0);

constant max: signed(Nbits-1 downto 0):=to_signed(((2**(Nbits-1))-1),Nbits);
constant min: signed(Nbits-1 downto 0):=to_signed(-((2**(Nbits-1))),Nbits);
begin

process(clk_i,rst_i)
begin
	if rst_i='0' then
		taps_delay	<=	(others=>(others=>'0'));
		response_filter<=(others=>'0');
	elsif rising_edge(clk_i) then
		if en_i='1' then
			taps_delay(1 to N-1) <=	taps_delay(0 to N-2);
			taps_delay(0) <= signed(input_filter);
			response_filter<=std_logic_vector(p_entera);
		end if;
	end if;
end process;

resultado	<= acum(N-1)(K+Nbits+3 downto fix);

p_entera	<=  max when resultado>max else
			    min when resultado<min else
			    resultado(Nbits-1 downto 0);

Filter: for i in 0 to N-1 generate
	product(i) 	<=	taps_delay(i)*coeficiente(i);
	sum1: if i=1 generate
		acum(i)<=resize(product(i-1),K+Nbits+4)+resize(product(i),K+Nbits+4);
	end generate sum1;
	sumt: if i>1 generate
		acum(i)<=resize(acum(i-1),K+Nbits+4)+resize(product(i),K+Nbits+4);
	end generate sumt;
end generate Filter;

--response_filter<=std_logic_vector(acum(N-1)(fix+23 downto fix));

end rtl;
		