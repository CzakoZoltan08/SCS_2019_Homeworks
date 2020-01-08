LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

 
ENTITY FIFOUnitTest IS
END FIFOUnitTest;
 
 
 
ARCHITECTURE behavior OF FIFOUnitTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FIFOUnit
    PORT(
         clk : IN  std_logic;
         reset : IN  std_logic;
         wr : IN  std_logic;
         rd : IN  std_logic;
         data_in : IN  std_logic_vector(7 downto 0);
         full : OUT  std_logic;
         empty : OUT  std_logic;
         crossFIFOThreshold : OUT  std_logic;
         FIFOOverflowed : OUT  std_logic;
         FIFOUnderflowed : OUT  std_logic;
         data_out : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal reset : std_logic := '0';
   signal wr : std_logic := '0';
   signal rd : std_logic := '0';
   signal data_in : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal full : std_logic;
   signal empty : std_logic;
   signal crossFIFOThreshold : std_logic;
   signal FIFOOverflowed : std_logic;
   signal FIFOUnderflowed : std_logic;
   signal data_out : std_logic_vector(7 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FIFOUnit PORT MAP (
          clk => clk,
          reset => reset,
          wr => wr,
          rd => rd,
          data_in => data_in,
          full => full,
          empty => empty,
          crossFIFOThreshold => crossFIFOThreshold,
          FIFOOverflowed => FIFOOverflowed,
          FIFOUnderflowed => FIFOUnderflowed,
          data_out => data_out
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

      -- insert stimulus here 
		wait for clk_period*10; -- 1st write
		
		reset   <= '0';
		wr      <= '1';
		rd      <= '0';
		data_in <= "00000001";
		
		wait for clk_period*10; -- 2nd write
		
		reset   <= '0';
		wr      <= '1';
		rd      <= '0';
		data_in <= "00000010";
		
		wait for clk_period*10; -- 3rd write
		
		reset   <= '0';
		wr      <= '1';
		rd      <= '0';
		data_in <= "00000100";
		
		wait for clk_period*10; -- 4th write
		
		reset   <= '0';
		wr      <= '1';
		rd      <= '0';
		data_in <= "00001000";
		
		wait for clk_period*10; -- 5th write
		
		reset   <= '0';
		wr      <= '1';
		rd      <= '0';
		data_in <= "00010000";
		
		wait for clk_period*10; -- 6th write
		
		reset   <= '0';
		wr      <= '1';
		rd      <= '0';
		data_in <= "00100000";
		
		wait for clk_period*10; -- 7th write
		
		reset   <= '0';
		wr      <= '1';
		rd      <= '0';
		data_in <= "01000000";
		
		wait for clk_period*10; -- 1st read
		
		reset   <= '0';
		wr      <= '0';
		rd      <= '1';
		data_in <= "00000000";
		
		wait for clk_period*10; -- 7th write again
		
		reset   <= '0';
		wr      <= '1';
		rd      <= '0';
		data_in <= "10000000";
		
		wait for clk_period*10; -- 2nd read
		
		reset   <= '0';
		wr      <= '0';
		rd      <= '1';
		data_in <= "00000000";
		
		wait for clk_period*10;

   end process;

END;
