LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY top_module_testbench IS
END top_module_testbench;
 
ARCHITECTURE behavior OF top_module_testbench IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT top_module
    PORT(
         address_bus : IN  std_logic_vector(23 downto 0);
         data_bus : INOUT  std_logic_vector(15 downto 0);
         --bhe : IN  std_logic;
         wr : IN  std_logic;
         rd : IN  std_logic
        );
    END COMPONENT;
    
   --Inputs
   signal address_bus : std_logic_vector(23 downto 0) := (others => '0');
   --signal bhe : std_logic := '0';
   signal wr : std_logic := '0';
   signal rd : std_logic := '0';

	--BiDirs
   signal data_bus : std_logic_vector(15 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: top_module PORT MAP (
          address_bus => address_bus,
          data_bus => data_bus,
          --bhe => bhe,
          wr => wr,
          rd => rd
        ); 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      -- insert stimulus here
		address_bus <= "110000100000000000000001";	-- BHE='1' (deactivated)
		--bhe <= '0';
		rd <= '0';	-- citirea valoarea unei adrese din MEM
		wr <= '1';
		
		wait for 60 ns;
		address_bus <= "110000100000000000000001";	-- BHE='1' (deactivated)
		wr <= '0';
		rd <= '1';

      wait;
   end process;

END;