Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;  
use IEEE.STD_LOGIC_UNSIGNED.ALL; 



ENTITY ReadIncrementer IS
   PORT (
			clk        :  in STD_LOGIC;  
			rst_n      :  in STD_LOGIC;  
			rd         :  in STD_LOGIC;
			fifo_empty :  in STD_LOGIC;
			fifo_rd    : out STD_LOGIC;
			rptr       : out STD_LOGIC_VECTOR (4 downto 0)
		  );
END ReadIncrementer;



ARCHITECTURE ReadIncrementerBehavioral OF ReadIncrementer IS  

	SIGNAL re           : STD_LOGIC;
	SIGNAL readAdddress : STD_LOGIC_VECTOR (4 downto 0); 
   
	BEGIN  
		 rptr    <= readAdddress;
		 fifo_rd <= re ;
		 re      <= (NOT fifo_empty) AND rd;
		 
		 PROCESS(clk,rst_n)
		 BEGIN 
				IF(rst_n = '0') THEN 
					readAdddress <= (others => '0');
					
				elsif(rising_edge(clk)) THEN
					IF(re = '1') then 
						readAdddress <= readAdddress + "00001"; 
						
					END IF;
				END IF;
		  
		 END PROCESS; 
		 
END ReadIncrementerBehavioral;