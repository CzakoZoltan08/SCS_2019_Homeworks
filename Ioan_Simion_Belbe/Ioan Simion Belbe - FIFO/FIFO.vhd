library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



ENTITY FIFO IS
		PORT ( 
				 clk     :  in STD_LOGIC;
				 rst     :  in STD_LOGIC;
				 btn_rd  :  in STD_LOGIC;
				 btn_wr  :  in STD_LOGIC;
				 data_in :  in STD_LOGIC_VECTOR (7 downto 0);
				 
				 empty   : out STD_LOGIC; 
				 full    : out STD_LOGIC;
				 an      : out STD_LOGIC_VECTOR (3 downto 0);
				 sseg    : out STD_LOGIC_VECTOR (6 downto 0) 
				);
END FIFO;



ARCHITECTURE FIFOBehavioral OF FIFO IS


		COMPONENT filtr IS
			PORT ( 
					clk   :  in STD_LOGIC;
					rst   :  in STD_LOGIC;
					D_IN  :  in STD_LOGIC;
					Q_OUT : out STD_LOGIC
				  );
		END COMPONENT;
		
		
		COMPONENT FIFOControl IS
			PORT ( 
					clk   :  in STD_LOGIC;
					rst   :  in STD_LOGIC;
					rd    :  in STD_LOGIC;
					wr    :  in STD_LOGIC;
					rdinc : out STD_LOGIC;
					wrinc : out STD_LOGIC
				  );
		END COMPONENT;
		
		
		COMPONENT FIFOUnit IS
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
		END COMPONENT;
		
		
		COMPONENT displ_7seg IS
			PORT ( 
					clk      :  in STD_LOGIC;
					rst      :  in STD_LOGIC;
					data     :  in STD_LOGIC_VECTOR (15 downto 0);
					sseg     : out STD_LOGIC_VECTOR ( 6 downto 0);
					an       : out STD_LOGIC_VECTOR ( 3 downto 0)
				  );
		END COMPONENT;
		
		
		SIGNAL rd       : STD_LOGIC;
		SIGNAL wr       : STD_LOGIC;
		
		SIGNAL rdinc    : STD_LOGIC; 
		SIGNAL wrinc    : STD_LOGIC;
		
		SIGNAL threshold : STD_LOGIC;	
		SIGNAL overflow  : STD_LOGIC;
		SIGNAL underflow : STD_LOGIC;
		
		SIGNAL data_out   : STD_LOGIC_VECTOR (7 downto 0);
		
		
	BEGIN

		debounceRead: filtr 
			PORT MAP (
						 clk   => clk, 
						 rst   => rst, 
						 D_IN  => btn_rd, 
						 Q_OUT => rd
						 );
						 
						 
		debounceWrite: filtr 
			PORT MAP (
						 clk   => clk, 
						 rst   => rst, 
						 D_IN  => btn_wr, 
						 Q_OUT => wr
						);
		
		ControlUnit: FIFOControl 
			PORT MAP (
						 clk   => clk,
						 rst   => rst,
						 rd    => rd,
						 wr    => wr,
						 rdinc => rdinc,
						 wrinc => wrinc
					  );
					  
					  
		FIFOFunctional: FIFOUnit 
			PORT MAP (
						 clk                => clk, 
						 reset              => rst,
						 wr                 => wr,
						 rd                 => rd,
						 data_in            => data_in,
			
						 full               => full,
						 empty              => empty,
						 crossFIFOThreshold => threshold,
						 FIFOOverflowed     => overflow,
						 FIFOUnderflowed    => underflow,
						 data_out           => data_out
						);
		
		
		display: displ_7seg 
			PORT MAP (
						 clk  => clk, 
						 rst  => rst, 
						 data => data_in & data_out, 
						 sseg => sseg, 
						 an   => an
						);
	
	
END FIFOBehavioral;

