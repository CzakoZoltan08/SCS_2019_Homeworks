Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;  
use IEEE.STD_LOGIC_UNSIGNED.ALL; 



ENTITY WriteIncrementer IS 
   PORT (
			clk       :  in STD_LOGIC;  
			rst_n     :  in STD_LOGIC;  
         wr        :  in STD_LOGIC;
         fifo_full :  in STD_LOGIC;
	      fifo_we   : out STD_LOGIC;
	      wptr      : out STD_LOGIC_VECTOR(4 downto 0)
		  );
END WriteIncrementer;



ARCHITECTURE WriteIncrementerBehavioral OF WriteIncrementer IS  

	SIGNAL we           : STD_LOGIC;
	SIGNAL writeAddress : STD_LOGIC_VECTOR(4 downto 0);    
	
	BEGIN  
	
		 fifo_we <= we;
		 we      <= (NOT fifo_full) AND wr;
		 wptr    <= writeAddress;
		 
		 PROCESS(clk, rst_n)
		 BEGIN 
				IF(rst_n = '0') THEN 
					writeAddress <= (OTHERS => '0');
					
				ELSIF(rising_edge(clk)) THEN
					IF(we = '1') THEN 
						writeAddress <= writeAddress + "00001";
						
					END IF;
				END IF; 
				
		 END PROCESS;  
	 
END WriteIncrementerBehavioral; 