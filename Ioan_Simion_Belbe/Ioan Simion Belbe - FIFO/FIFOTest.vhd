LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 


ENTITY FIFOTest IS
END FIFOTest;


 
ARCHITECTURE behavior OF FIFOTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT FIFO
    PORT(
         clk : IN  std_logic;
         rst : IN  std_logic;
         btn_rd : IN  std_logic;
         btn_wr : IN  std_logic;
         data_in : IN  std_logic_vector(7 downto 0);
         empty : OUT  std_logic;
         full : OUT  std_logic;
         an : OUT  std_logic_vector(3 downto 0);
         sseg : OUT  std_logic_vector(6 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';
   signal btn_rd : std_logic := '0';
   signal btn_wr : std_logic := '0';
   signal data_in : std_logic_vector(7 downto 0) := (others => '0');

 	--Outputs
   signal empty : std_logic;
   signal full : std_logic;
   signal an : std_logic_vector(3 downto 0);
   signal sseg : std_logic_vector(6 downto 0);

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: FIFO PORT MAP (
          clk => clk,
          rst => rst,
          btn_rd => btn_rd,
          btn_wr => btn_wr,
          data_in => data_in,
          empty => empty,
          full => full,
          an => an,
          sseg => sseg
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
		
		rst     <= '0';
		btn_wr  <= '1';
		btn_rd  <= '0';
		data_in <= "00000001";
		
		wait for clk_period*10; -- 2nd write
		
		rst     <= '0';
		btn_wr  <= '1';
		btn_rd  <= '0';
		data_in <= "00000010";
		
		wait for clk_period*10; -- 3rd write
		
		rst     <= '0';
		btn_wr  <= '1';
		btn_rd  <= '0';
		data_in <= "00000100";
		
		wait for clk_period*10; -- 4th write
		
		rst     <= '0';
		btn_wr  <= '1';
		btn_rd  <= '0';
		data_in <= "00001000";
		
		wait for clk_period*10; -- 5th write
		
		rst     <= '0';
		btn_wr  <= '1';
		btn_rd  <= '0';
		data_in <= "00010000";
		
		wait for clk_period*10; -- 6th write
		
		rst     <= '0';
		btn_wr  <= '1';
		btn_rd  <= '0';
		data_in <= "00100000";
		
		wait for clk_period*10; -- 7th write
		
		rst     <= '0';
		btn_wr  <= '1';
		btn_rd  <= '0';
		data_in <= "01000000";
		
		wait for clk_period*10; -- 1st read
		
		rst     <= '0';
		btn_wr  <= '0';
		btn_rd  <= '1';
		data_in <= "00000000";
		
		wait for clk_period*10; -- 7th write again
		
		rst     <= '0';
		btn_wr  <= '1';
		btn_rd  <= '0';
		data_in <= "10000000";
		
		wait for clk_period*10; -- 2nd read
		
		rst     <= '0';
		btn_wr  <= '0';
		btn_rd  <= '1';
		data_in <= "00000000";
		
		wait for clk_period*10;

   end process;

END;
