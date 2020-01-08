library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;



ENTITY displ_7seg IS
	PORT ( 
			clk      :  in STD_LOGIC;
			rst      :  in STD_LOGIC;
		   data     :  in STD_LOGIC_VECTOR (15 downto 0);
		   sseg     : out STD_LOGIC_VECTOR ( 6 downto 0);
		   an       : out STD_LOGIC_VECTOR ( 3 downto 0)
		  );
END displ_7seg;



ARCHITECTURE Behavioral OF displ_7seg IS


	COMPONENT hex2sseg IS
    	PORT ( 
				 hex  :  in STD_LOGIC_VECTOR (3 downto 0);
           	 sseg : out STD_LOGIC_VECTOR (6 downto 0)
			  );
	END COMPONENT hex2sseg;
	
	
	SIGNAL ledsel  : STD_LOGIC_VECTOR ( 1 downto 0);
   SIGNAL segdata : STD_LOGIC_VECTOR ( 3 downto 0);
	SIGNAL cntdiv  : STD_LOGIC_VECTOR (10 downto 0);

	
	BEGIN
		PROCESS (clk, rst)
		BEGIN
		
			IF rst = '1' THEN
				cntdiv <= (OTHERS => '0');
				
			ELSIF (clk'event AND clk = '1') THEN
				cntdiv <= cntdiv + 1;
				
			END IF;
			
		END PROCESS;
		
		ledsel <= cntdiv(10 downto 9);
		
		an <= "1110" WHEN ledsel = "00" ELSE
				"1101" WHEN ledsel = "01" ELSE
				"1011" WHEN ledsel = "10" ELSE
				"0111" WHEN ledsel = "11";
				
		segdata <= data ( 3 downto 0)  WHEN ledsel = "00" ELSE
					  data ( 7 downto 4)  WHEN ledsel = "01" ELSE
					  data (11 downto 8)  WHEN ledsel = "10" ELSE
					  data (15 downto 12) WHEN ledsel = "11";
					  
					  
		HexadecimalToSegments: hex2sseg
			PORT MAP (
						 hex  => segdata, 
						 sseg => sseg
						);
		
	
	
END Behavioral;
