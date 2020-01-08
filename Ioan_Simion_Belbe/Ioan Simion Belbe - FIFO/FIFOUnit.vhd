Library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



ENTITY FIFOUnit IS 
   PORT (
			clk                :  in STD_LOGIC;  
			reset              :  in STD_LOGIC;  
			wr                 :  in STD_LOGIC;
			rd                 :  in STD_LOGIC;
			data_in            :  in STD_LOGIC_VECTOR (7 downto 0);
			
			full               : out STD_LOGIC;
			empty              : out STD_LOGIC;
			crossFIFOThreshold : out STD_LOGIC;	
			FIFOOverflowed     : out STD_LOGIC;
			FIFOUnderflowed    : out STD_LOGIC;
			data_out           : out STD_LOGIC_VECTOR (7 downto 0)
        );
END FIFOUnit;



ARCHITECTURE FIFOUnitBehavioral OF FIFOUnit IS 
 
	COMPONENT WriteIncrementer
		PORT (
				 clk       :  in STD_LOGIC;  
				 rst_n     :  in STD_LOGIC;  
				 wr        :  in STD_LOGIC;
		       fifo_full :  in STD_LOGIC;
				 fifo_we   : out STD_LOGIC;
				 wptr      : out STD_LOGIC_VECTOR (4 downto 0)
		);
	END COMPONENT;
	
	
	COMPONENT ReadIncrementer
		PORT (
				clk        :  in STD_LOGIC;  
				rst_n      :  in STD_LOGIC;  
				rd         :  in  STD_LOGIC;
				fifo_empty :  in STD_LOGIC;
				fifo_rd    : out STD_LOGIC;
				rptr       : out STD_LOGIC_VECTOR (4 downto 0)
			 );
	END COMPONENT;
	
	
	COMPONENT RegisterMemory
		PORT (		    
				clk      :  in STD_LOGIC;  
				fifo_we  :  in STD_LOGIC;  
				wptr     :  in STD_LOGIC_VECTOR (4 downto 0);
				rptr     :  in STD_LOGIC_VECTOR (4 downto 0);  				
				data_in  :  in STD_LOGIC_VECTOR (7 downto 0);
				data_out : out STD_LOGIC_VECTOR (7 downto 0)
		);
	END COMPONENT;
	
	
	COMPONENT StatusUnit
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
	END COMPONENT;
	
	
	SIGNAL emptySignal       : STD_LOGIC; 
	SIGNAL fullSignal        : STD_LOGIC;
	SIGNAL writeEnableSignal : STD_LOGIC; 
	SIGNAL readSignal        : STD_LOGIC;    
	SIGNAL writePointer      : STD_LOGIC_VECTOR (4 downto 0);
	SIGNAL readPointer       : STD_LOGIC_VECTOR (4 downto 0);
	
   
	BEGIN  

		 WritePointerUnit: WriteIncrementer 
		 PORT MAP 
				(   
				 wr        => wr,  
				 fifo_full => fullSignal,
				 clk       => clk,
				 rst_n     => reset,
				 fifo_we   => writeEnableSignal, 
				 wptr      => writePointer
			);
				
		 ReadPointerUnit: ReadIncrementer 
		 PORT MAP 
				(
				 rd         => rd,
				 fifo_empty => emptySignal,
				 clk        => clk,
				 rst_n      => reset,
				 fifo_rd    => readSignal,
				 rptr       => readPointer
				);
				
		 Registers: RegisterMemory 
		 PORT MAP 
				(
				 clk      => clk,
				 fifo_we  => writeEnableSignal,
				 wptr     => writePointer,
				 rptr     => readPointer,
				 data_in  => data_in,
				 data_out => data_out
				);
				
		 ControlUnit: StatusUnit 
		 PORT MAP 
				(
				 wr             => wr, 
				 rd             => rd, 
				 fifo_we        => writeEnableSignal,
				 fifo_rd        => readSignal,
			    clk            => clk,
				 rst_n          => reset,
				 wptr           => writePointer,
				 rptr           => readPointer,

				 fifo_full      => fullSignal,
				 fifo_empty     => emptySignal,
				 fifo_threshold => crossFIFOThreshold,
				 fifo_overflow  => FIFOOverflowed, 
				 fifo_underflow => FIFOUnderflowed
				);
				
		 empty <= emptySignal;
		 full  <= fullSignal;
	 
END FIFOUnitBehavioral; 