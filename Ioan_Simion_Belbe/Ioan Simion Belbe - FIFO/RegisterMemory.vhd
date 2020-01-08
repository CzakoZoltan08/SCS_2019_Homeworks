Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;



ENTITY RegisterMemory IS 
   PORT (
			clk      :  in STD_LOGIC;  
			fifo_we  :  in STD_LOGIC;  
			wptr     :  in STD_LOGIC_VECTOR (4 downto 0);
			rptr     :  in STD_LOGIC_VECTOR (4 downto 0);
			data_in  :  in STD_LOGIC_VECTOR (7 downto 0);
			data_out : out STD_LOGIC_VECTOR (7 downto 0)
   
   );
END RegisterMemory;



ARCHITECTURE RegisterMemoryBehavioral OF RegisterMemory IS
 
	 TYPE mem_array IS ARRAY (0 to 15) OF STD_LOGIC_VECTOR (7 downto 0);
	 SIGNAL data_out2 : mem_array;
	 
	 BEGIN  
	 
		 PROCESS(clk)
		 BEGIN 
				IF(rising_edge(clk)) THEN
			  
					IF(fifo_we = '1') THEN 
						data_out2(to_integer(unsigned(wptr(3 downto 0)))) <= data_in; 
						
					END IF;
				END IF;  
		  
		 END PROCESS;
		 
	 data_out <= data_out2(to_integer(unsigned(rptr(3 downto 0))));
 
END RegisterMemoryBehavioral;