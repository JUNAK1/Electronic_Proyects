Library ieee;
Use ieee.std_logic_1164.all;
Entity Mux_8_1_8bits is 
	Port( 
		Cero,Uno,Dos,Tres,Cuatro,Cinco,Seis,Siete:in std_logic_vector(7 downto 0);
		S:in std_logic_vector(2 downto 0);
		R:out std_logic_vector(7 downto 0)
	);
end entity;
Architecture behavior of Mux_8_1_8bits is 
Begin 
Process(S,Cero,Uno,Dos,Tres,Cuatro,Cinco,Seis,Siete)
	Begin 
		if s="000" then 
			R<=Cero;
		elsif s="001" then 
			R<=Uno;
		elsif s="010" then 
			R<=Dos;
		elsif S="011" then 
			R<=Tres;
		elsif S="100" then 
			R<=Cuatro;
		elsif S="101" then 
			R<=Cinco;
		elsif S="110" then 
			R<=Seis;
		else 
			R<=Siete;
		end if;
	end process;
end behavior;