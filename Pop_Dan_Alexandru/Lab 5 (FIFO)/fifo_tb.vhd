LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY fifo_tb IS
END fifo_tb;
 
ARCHITECTURE behavior OF fifo_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT) 
    COMPONENT complete_circuit
    PORT(
         data_in : IN  std_logic_vector(7 downto 0);
         btn_rd : IN  std_logic;
         btn_wr : IN  std_logic;
         clk : IN  std_logic;
         rst : IN  std_logic;
         sseg : OUT  std_logic_vector(6 downto 0);
         anode : OUT  std_logic_vector(3 downto 0);
         empty : OUT  std_logic;
         full : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal data_in : std_logic_vector(7 downto 0) := (others => '0');
   signal btn_rd : std_logic := '0';
   signal btn_wr : std_logic := '0';
   signal clk : std_logic := '0';
   signal rst : std_logic := '0';

 	--Outputs
   signal sseg : std_logic_vector(6 downto 0);
   signal anode : std_logic_vector(3 downto 0);
   signal empty : std_logic;
   signal full : std_logic;

   -- Clock period definitions
   constant clk_period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: complete_circuit PORT MAP (
          data_in => data_in,
          btn_rd => btn_rd,
          btn_wr => btn_wr,
          clk => clk,
          rst => rst,
          sseg => sseg,
          anode => anode,
          empty => empty,
          full => full
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
      data_in <= "00000001";
      btn_rd <= '1';
      btn_wr <= '0';
      rst <= '0';

      wait;
   end process;

END;
