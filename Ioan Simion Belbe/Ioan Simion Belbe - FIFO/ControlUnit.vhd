--developed with the help of a tutorial
Library IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE ieee.STD_LOGIC_arith.all;  
USE ieee.STD_LOGIC_unsigned.all;  



ENTITY StatusUnit IS 
   PORT (
			wr             :  in STD_LOGIC;
			rd             :  in STD_LOGIC;
			fifo_we        :  in STD_LOGIC; 
			fifo_rd        :  in STD_LOGIC;
			clk            :  in STD_LOGIC;
			rst_n          :  in STD_LOGIC;  
			wptr           :  in STD_LOGIC_VECTOR (4 downto 0);
			rptr           :  in STD_LOGIC_VECTOR (4 downto 0);
				
			fifo_full      : out STD_LOGIC;
			fifo_empty     : out STD_LOGIC;
			fifo_threshold : out STD_LOGIC;    
			fifo_overflow  : out STD_LOGIC;
			fifo_underflow : out STD_LOGIC 
   );
END StatusUnit;



ARCHITECTURE StatusUnitBehavioral OF StatusUnit IS  

	  SIGNAL fbit_comp     : STD_LOGIC;
	  SIGNAL overflow_set  : STD_LOGIC;
	  SIGNAL underflow_set : STD_LOGIC;
	  SIGNAL pointer_equal : STD_LOGIC;
	  
	  SIGNAL full  : STD_LOGIC; 
	  SIGNAL empty : STD_LOGIC;
	  
	  SIGNAL pointer_result : STD_LOGIC_VECTOR (4 downto 0);

	  
	  BEGIN  
	 
		  fbit_comp     <= wptr(4) XOR rptr(4);
		  pointer_equal <= '1' 


		  WHEN (wptr(3 downto 0) = rptr(3 downto 0)) ELSE '0';
		  
		  
		  pointer_result <= wptr - rptr;
		  
		  overflow_set   <= full AND wr;
		  underflow_set  <= empty AND rd;
		  
		  full  <= fbit_comp AND  pointer_equal;
		  empty <= (NOT fbit_comp) AND  pointer_equal;
		  
		  fifo_threshold <=  '1' 


		  WHEN (pointer_result(4) OR pointer_result(3)) = '1' ELSE '0';
		  
		  
		  fifo_full  <= full;
		  fifo_empty <= empty;
		  
		  PROCESS(clk, rst_n)
			  BEGIN
			  
				  IF(rst_n = '0') THEN 
						fifo_overflow <= '0';
						
				  ELSIF(rising_edge(clk)) THEN 
				  
						IF ((overflow_set = '1') AND (fifo_rd = '0')) THEN 
								fifo_overflow <= '1';
								
						ELSIF(fifo_rd='1') THEN 
								fifo_overflow <= '0';
								
						END IF;
				  END IF;
				  
		  END PROCESS;
		  
		  
		  PROCESS(clk, rst_n)
		  BEGIN
		  
			  IF(rst_n = '0') THEN  
						fifo_underflow <= '0';
						
			  ELSIF(rising_edge(clk)) THEN
			  
					IF((underflow_set = '1') AND (fifo_we = '0')) THEN
							fifo_underflow <='1';
						
					ELSIF(fifo_we = '1') THEN 
							fifo_underflow <= '0';
							
					END IF;
				END IF;
				
		  END PROCESS;
	  
	  
END StatusUnitBehavioral;