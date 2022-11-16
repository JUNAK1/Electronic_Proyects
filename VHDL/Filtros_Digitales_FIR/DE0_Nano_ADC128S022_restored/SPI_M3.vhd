library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity SPI_M3 is
generic(Nbits	:natural	:= 8);
port(
	 clk		:in 	std_logic;   --señal de reloj al doble de la frecuencia de sck
	 rst_n	:in	std_logic;
	 start	:in	std_logic;
	 ready	:out 	std_logic;
	 finish	:out	std_logic;
	 data_tx	:in	std_logic_vector(Nbits-1 downto 0);
	 data_rx	:out	std_logic_vector(Nbits-1 downto 0);
	 miso		:in	std_logic;
	 mosi		:out	std_logic;
	 sck		:out	std_logic;
	 cs_n		:out	std_logic
	 );
end entity SPI_M3;


architecture rtl of SPI_M3 is
type estados is(s0,s1,s2,s3,s4,s5,s6);
signal estado_p, estado_s :estados;

signal	en_cnt	:std_logic;
signal	en_rrx	:std_logic;
signal	en_rtx	:std_logic;
signal	ld_cnt	:std_logic;
signal	sl_rtx	:std_logic;
signal   sck_s		:std_logic;
signal   cs_s		:std_logic;
signal	txreg	:std_logic_vector(Nbits-1 downto 0);
signal	rxreg	:std_logic_vector(Nbits-1 downto 0);
signal   counters :unsigned(7 downto 0);
signal	div_freq	:unsigned(7 downto 0);
begin


-- registro de transmision de datos
process(clk,rst_n)
begin
	if rst_n='0' then
		txreg	<= (others=>'0');
	elsif rising_edge(clk) then
		if en_rtx='1' then
			if sl_rtx='1' then
				txreg <= data_tx;
			else
				txreg <= txreg(Nbits-2 downto 0)&'0';
			end if;
		end if;
	end if;
end process;

--registro de recepcion de datos
process(clk,rst_n)
begin
	if rst_n='0' then
		rxreg	<= (others=>'0');
	elsif rising_edge(clk) then
		if en_rrx='1' then
			rxreg <= rxreg(Nbits-2 downto 0)&miso;
		end if;
	end if;
end process;

--contador de numero de bits transmitidos
process(clk,rst_n)
begin
	if rst_n='0' then
		counters	<= (others=>'0');
	elsif rising_edge(clk) then
		if en_cnt='1' then
			if ld_cnt='1' then
				counters <= (others=>'0');
			else
				counters <= counters+1;
			end if;			
		end if;
	end if;
end process;


--maquina de estados con datapath

process(estado_p,counters,start)
begin
	case estado_p is
		when s0 =>
			if start='1' then
				estado_s	<= s1;
			else
				estado_s	<= s0;
			end if;
		when s1 =>
			estado_s	<= s2;
		when s2 =>
			estado_s	<= s3;
		when s3 =>
			estado_s	<= s4;
		when s4 =>
			if counters=Nbits-2 then
				estado_s	<= s5;
			else
				estado_s	<= s3;
			end if;
		when s5 =>
			estado_s	<= s6;
		when s6 =>
			estado_s	<=	s0;
		when others =>
			estado_s	<= s0;
	end case;
end process;


process(clk,rst_n)
begin
	if rst_n='0' then
		estado_p	<= s0;
	elsif rising_edge(clk) then	
		estado_p	<= estado_s;
	end if;
end process;

process(estado_p,counters,sck_s)
begin
	case estado_p is
		when s0 =>
			en_cnt	<= '1';		
			ld_cnt	<= '1';		
			en_rrx	<= '0';		
			en_rtx	<= '0';		
			sl_rtx	<= '0';		
			sck_s		<= '1';	
			cs_s		<= '1';	
			ready		<= '1';	
			finish	<= '0';		
		when s1 =>
			en_cnt	<= '1';		
			ld_cnt	<= '1';		
			en_rrx	<= '0';		
			en_rtx	<= '0';		
			sl_rtx	<= '1';		
			sck_s		<= '1';	
			cs_s		<= '0';	
			ready		<= '0';	
			finish	<= '0';	
		when s2 =>
			en_cnt	<= '0';		
			ld_cnt	<= '0';		
			en_rrx	<= '0';		
			en_rtx	<= '1';		
			sl_rtx	<= '1';		
			sck_s		<= '0';	
			cs_s		<= '0';	
			ready		<= '0';	
			finish	<= '0';	
		when s3 =>
			en_cnt	<= '0';		
			ld_cnt	<= '0';		
			en_rrx	<= '1';		
			en_rtx	<= '0';		
			sl_rtx	<= '0';		
			sck_s		<= '1';	
			cs_s		<= '0';	
			ready		<= '0';	
			finish	<= '0';
		when s4 =>				
			en_rrx	<= '0';		
			en_rtx	<= '1';		
			sl_rtx	<= '0';		
			sck_s		<= '0';	
			cs_s		<= '0';	
			ready		<= '0';	
			finish	<= '0';
			if counters=Nbits-2 then
				en_cnt	<= '0';		
				ld_cnt	<= '0';
			else
				en_cnt	<= '1';		
				ld_cnt	<= '0';
			end if;
		when s5 =>
			en_cnt	<= '0';		
			ld_cnt	<= '0';		
			en_rrx	<= '1';		
			en_rtx	<= '0';		
			sl_rtx	<= '0';		
			sck_s		<= '1';	
			cs_s		<= '0';	
			ready		<= '0';	
			finish	<= '0';
		when s6 =>
			en_cnt	<= '0';		
			ld_cnt	<= '0';		
			en_rrx	<= '0';		
			en_rtx	<= '1';		
			sl_rtx	<= '0';		
			sck_s		<= '1';	
			cs_s		<= '1';	
			ready		<= '0';	
			finish	<= '1';
		when others =>			
	end case;
end process;

mosi	<= txreg(Nbits-1);
data_rx	<= rxreg;

--sck	<= sck_s;
--cs_n	<= cs_s;

process(clk,rst_n)
begin
	if rst_n='0' then
		sck	<= '1';
		cs_n	<= '1';
	elsif rising_edge(clk) then
		sck	<= sck_s;
		cs_n	<= cs_s;
	end if;
end process;




end rtl;