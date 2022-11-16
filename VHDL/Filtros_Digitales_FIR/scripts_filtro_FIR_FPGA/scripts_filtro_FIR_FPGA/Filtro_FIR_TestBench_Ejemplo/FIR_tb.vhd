library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
USE std.textio.ALL;  -- libreria para simulacion con archivos

--Entidad del Testbech
entity FIR_tb is
end entity FIR_tb;


architecture rtl of FIR_tb is 
Constant Nbits :natural :=24;
--declaracion de objetos para trabajar con archivos de texto   
FILE vectorFileR	: TEXT OPEN READ_MODE is "senal.txt";
FILE vectorFileRes: TEXT OPEN WRITE_MODE is "Resultado.txt";

-- A partir de aqui puede hacer las modificaciones que necesite
-- Declaracion de las señales que se emplearan para dar los estimulos
--al diseño que requieren comprobar.
signal sclk_i			:std_logic :='0';
signal srst_i			:std_logic :='0';
signal sen_i			:std_logic :='0';
signal sinput_filter	:std_logic_vector(Nbits-1 downto 0)  := (others=>'0');
signal sresponse_filter	:std_logic_vector(Nbits-1 downto 0);

begin


--Haga la instancia de su diseño aqui
UUT: entity work.FIR
	generic map(Nbits => Nbits)
	 port map(
			clk_i			=>sclk_i,
			rst_i			=>srst_i,
			en_i			=>sen_i,
			input_filter	=>sinput_filter,
			response_filter	=>sresponse_filter 
			);

--Generacion de la señal de reloj			
	process
	begin
	sclk_i	<=	not sclk_i;
	wait for 10 ns;
	end process;

--cuando arranca la simulacion se debe reiniciar
--el diseño para que funcione adecuadamente, es el 
--equivalente a encender la TARJETA.
	process
	begin
	srst_i	<=	'0';
	wait for 500 ns;
	srst_i	<=	'1';
	wait;
	end process;

	
--Este es el proceso de generacion de estímulos a partir de archivos 
--de texto donde se encuentran los valores que deben ser 
--puestos en el modulo para comprobar el funcionamiento.
	process
		variable		Vectorline	:line;
		variable		VectorlineRes	:line;
		variable		data: integer;
		variable		resultado		:integer;
	begin
		wait for 600 ns;
		wait until falling_edge(sclk_i);	
			sen_i	<=	'1';
		WHILE NOT ENDFILE (vectorFileR) LOOP
			readline(vectorFileR, VectorLine);
			read(VectorLine,data);
			sinput_filter		<=	std_logic_vector(to_signed(data,Nbits));
			wait until falling_edge(sclk_i);			
			resultado			:=	to_integer(signed(sresponse_filter));
			write(VectorLineRes,resultado);
			writeline(vectorFileRes, VectorLineRes);
		end loop;
			wait until falling_edge(sclk_i);
			sen_i		<=	'0';
			resultado	:=	to_integer(unsigned(sresponse_filter));
			write(VectorLineRes,resultado);
			writeline(vectorFileRes, VectorLineRes);
		wait;
	end process;
end rtl;
		