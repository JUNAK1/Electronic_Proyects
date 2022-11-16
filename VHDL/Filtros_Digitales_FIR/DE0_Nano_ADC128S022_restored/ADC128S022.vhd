library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity ADC128S022 is
port(
	 clk		:in 	std_logic;
	 rst_n	:in	std_logic;
	 adc_dat :out	std_logic_vector(11 downto 0);
	 miso		:in	std_logic;
	 mosi		:out	std_logic;
	 sck		:out	std_logic;
	 cs_n		:out	std_logic
	 );
end entity ADC128S022;


architecture rtl of ADC128S022 is
signal	start 	:std_logic;
signal	clk_s 	:std_logic;
signal	s_ready 	:std_logic;
signal	s_finish	:std_logic;
signal	Dato_adc	:std_logic_vector(15 downto 0);

signal input_filter: std_logic_vector(11 downto 0);
signal output_filter:std_logic_vector(11 downto 0);

begin

--PLL configurada para generar clk a 6MHZ a partir de clk 50MHz
PLL_M: entity work.PLL_3MHz
	port map(
				areset	=> not rst_n,
				inclk0	=> clk,
				c0			=> clk_s
				);

				
--Muestreador genera un pulso a 150KHz
-- Modulo=Fin/Fout=6MHz/150KHz=40				
process(clk_s,rst_n)
variable counter :unsigned(7 downto 0);
begin
	if rst_n='0' then
		counter	:=(others=>'0');
		start	<=	'0';
	elsif rising_edge(clk_s) then
		if (counter=39) then
			start	<=	'1';
			counter	:= (others=>'0');
		else
			start	<=	'0';
			counter	:= counter+1;
		end if;
	end if;
end process;

U1: entity work.SPI_M3
	generic map(Nbits	=> 16)
	port map(
				clk		=> clk_s,			
				rst_n		=> rst_n,	
				start		=> start,		
		      ready		=> s_ready,		
	         finish	=> s_finish,			
	         data_tx	=> "00"&"001"&"00000000000",			
	         data_rx	=> Dato_adc,			
	         miso		=> miso,			
	         mosi		=> mosi,			
	         sck		=> sck,			
	         cs_n		=> cs_n			
				);

--process(clk_s,rst_n)
--begin
--if rst_n='0' then
--	adc_dat	<= (others=>'0');
--elsif rising_edge(clk_s) then
--	if s_finish='1' then
--		adc_dat	<= Dato_adc(11 downto 0);
--	end if;
--end if;
--end process;


--Conversion de Unipolar 12 bits a Bipolar 12 bits
-- Unsigned a signed
-- Conversion de 0 -> 4095 a -2048 -> +2047
process(clk_s,rst_n)
begin
if rst_n='0' then
	input_filter	<= (others=>'0');
elsif rising_edge(clk_s) then
	if s_finish='1' then
		input_filter	<= std_logic_vector(to_signed(to_integer(unsigned(Dato_adc(11 downto 0)))-(2**11),12));
	end if;
end if;
end process;


U2: entity work.FIR
	generic map(Nbits	=> 12)
	port map(
				clk_i				 => clk_s,			
				rst_i				 => rst_n,	
				en_i				 => s_finish,	
				input_filter	 => input_filter,	
				response_filter => output_filter			
				);

		
--Conversion de Bipolar 12 bits a Unipolar 12 bits
-- Signed a Unsigned
-- Conversion de -2048 -> +2047 a 0 -> 4095		
process(clk_s,rst_n)
begin
if rst_n='0' then
	adc_dat	<= (others=>'0');
elsif rising_edge(clk_s) then
	if s_finish='1' then
		adc_dat	<= std_logic_vector(to_unsigned(to_integer(signed(output_filter))+(2**11),12));
	end if;
end if;
end process;

end rtl;