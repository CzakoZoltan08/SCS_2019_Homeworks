LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
 
 

ENTITY DivisionTest IS
END DivisionTest;
 
 
 
ARCHITECTURE behavior OF DivisionTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Division
    PORT(
         clk       :  IN  STD_LOGIC;
         Start     :  IN  STD_LOGIC;
         Divis     :  IN  STD_LOGIC_VECTOR(3 downto 0);
         Dividend  :  IN  STD_LOGIC_VECTOR(7 downto 0);
         Done      : OUT  STD_LOGIC;
         Remainder : OUT  STD_LOGIC_VECTOR(3 downto 0);
         Quotient  : OUT  STD_LOGIC_VECTOR(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   SIGNAL clk      : STD_LOGIC := '0';
   SIGNAL Start    : STD_LOGIC := '0';
   SIGNAL Divis    : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
   SIGNAL Dividend : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');

 	--Outputs
   SIGNAL Done      : STD_LOGIC;
   SIGNAL Remainder : STD_LOGIC_VECTOR(3 downto 0);
   SIGNAL Quotient  : STD_LOGIC_VECTOR(3 downto 0);

   -- Clock period definitions
   CONSTANT clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Division 
			PORT MAP (
			 			 clk       =>       clk,
          			 Start     =>     Start,
          			 Divis     =>     Divis,
          			 Dividend  =>  Dividend,
          			 Done      =>      Done,
          			 Remainder => Remainder,
          			 Quotient  =>  Quotient
       			   );

   -- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for clk_period*10;

      -- insert stimulus here
		
		Start    <= '1';
      Divis    <= "0010";
      Dividend <= "00001000";
		
		wait for clk_period*10;
		
		Start    <= '0';
		
		wait for clk_period*10;
		
		Start    <= '1';
      Divis    <= "0010";
      Dividend <= "00001001";
		
		wait for clk_period*10;
		
		Start    <= '0';

   end process;

END;
