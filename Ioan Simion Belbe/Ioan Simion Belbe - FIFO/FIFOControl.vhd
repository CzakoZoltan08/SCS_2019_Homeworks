library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


ENTITY FIFOControl IS
	PORT ( 
			clk   :  in STD_LOGIC;
			rst   :  in STD_LOGIC;
			rd    :  in STD_LOGIC;
			wr    :  in STD_LOGIC;
	      rdinc : out STD_LOGIC;
			wrinc : out STD_LOGIC
		  );
END FIFOControl;



ARCHITECTURE FIFOControlBehavioral OF FIFOControl IS

	BEGIN
	
		PROCESS(clk, rst)
		BEGIN
		
			IF rst = '1' THEN
					rdinc <= '0';
					wrinc <= '0';
			ELSE
					IF rising_edge(clk) THEN
						rdinc <= rd;
						wrinc <= wr;
						
					END IF;
			END IF;
			
	END PROCESS;
	
END FIFOControlBehavioral;

