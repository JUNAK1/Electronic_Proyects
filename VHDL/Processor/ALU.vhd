--Juan Camilo Serrano Correa
Library ieee;
Use ieee.std_logic_1164.all;
Use ieee.numeric_std.all;

Entity ALU is 
	Port( 
		Selector	:in std_logic_vector(2 downto 0);
		A,B		:in std_logic_vector(7 downto 0);
		Resultado:out std_logic_vector(7 downto 0)
	);
End entity;

Architecture  Circuito of ALU is 
Signal B_Bloque,Out_Sumador:std_logic_vector(7 downto 0);
Signal A_and_B,A_or_B,A_xor_B,A_sll_B,A_srl_B,A_mul_B:std_logic_vector(7 downto 0);
Begin 
---Sumador_restador_8_bits--------
Bloque_xor:entity work.Bloque_cxor
	port map( 
		Entrada	=>B,
		Salida	=>B_Bloque,
		Ci			=>Selector(0)
	);
Sumador:entity work.Sumador_8_bits 
	Port map( 
		 X		=>A ,
		 Y		=>B_Bloque ,
		 Ci	=>Selector(0) ,
		 S		=>Out_Sumador
		);
-------Operaciones Logicas----
A_sll_B<= std_logic_vector(shift_left(unsigned(A), to_integer(unsigned(B))));
A_srl_B<= std_logic_vector(shift_right(unsigned(A), to_integer(unsigned(B))));
-------Multiplexor-----------
Mux:entity work.Mux_8_1_8bits	--00000011 01010000
	Port map( 						--B=3  ,A=80
		Cero	=>Out_Sumador,		--83                 SUMA
		Uno	=>Out_Sumador,		--77						RESTA
		Dos	=>A_and_B,			--0
		Tres	=>A_or_B,			--83
		Cuatro=>A_xor_B,			--83
		Cinco	=>A_sll_B,			--128
		Seis	=>A_srl_B,			--10
		Siete	=>A_mul_B,			--240
		S		=>Selector,
		R		=>Resultado
	);
And_AB:entity work.Bloque_and
	Port map( 
	A			=>A,
	B			=>B,
	A_and_B	=>A_and_B
	);
Or_AB:entity work.Bloque_or
	Port map( 
	A			=>A,
	B			=>B,
	A_or_B	=>A_or_B
	);
Xor_AB:entity work.Bloq_xor
	Port map( 
	A			=>A,
	B			=>B,
	A_xor_B	=>A_xor_B
	);
Multi_AB:entity work.Bloque_multiplicacion
	Port map( 
	A			=>A,
	B			=>B,
	A_mul_B	=>A_mul_B
	);
End circuito;
--Juan Camilo Serrano Correa