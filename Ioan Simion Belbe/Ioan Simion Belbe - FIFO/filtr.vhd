library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


ENTITY filtr IS
	PORT ( 
			clk   :  in STD_LOGIC;
			rst   :  in STD_LOGIC;
			D_IN  :  in STD_LOGIC;
			Q_OUT : out STD_LOGIC
		  );
END filtr;



ARCHITECTURE filtrBehavioral OF filtr IS

	SIGNAL Q1 : STD_LOGIC;
	SIGNAL Q2 : STD_LOGIC; 
	SIGNAL Q3 : STD_LOGIC;

	BEGIN

	PROCESS(clk)
	BEGIN
	
		IF (clk'event AND clk = '1') THEN
		
			IF(rst = '1') THEN
				Q1 <= '0';
				Q2 <= '0';
				Q3 <= '0';
				
			ELSE
				Q1 <= D_IN;
				Q2 <= Q1;
				Q3 <= Q2;
				
			END IF;
		END IF;
		
	END PROCESS;
	 
	Q_OUT <= Q1 AND Q2 AND (NOT Q3);


END filtrBehavioral;