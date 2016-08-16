LIBRARY ieee;
USE ieee.std_logic_1164.all;
----------------------------------------- 
ENTITY muxOuts IS
	port (
		s: IN std_logic;
		a: IN std_logic;
		b: IN std_logic;
		c: IN std_logic;
		d: IN std_logic;
		f: OUT std_logic);
 	end muxOuts;

   ARCHITECTURE circuitDesign OF muxOuts IS
   begin
   	process(a, b, c, d)
     begin
   	f <= d when s = '1' else
   		(((NOT a) AND (NOT b)) OR (a AND c)) AND d ;
   	end process;	
   	end circuitDesign;
