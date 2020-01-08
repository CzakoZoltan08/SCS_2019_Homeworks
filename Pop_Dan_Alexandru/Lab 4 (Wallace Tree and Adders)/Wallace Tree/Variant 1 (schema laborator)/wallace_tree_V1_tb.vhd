LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY wallace_tree_V1_tb IS
END wallace_tree_V1_tb;
 
ARCHITECTURE behavior OF wallace_tree_V1_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT wallace_tree_multiplier
    PORT(
         first_number_bits : IN  std_logic_vector(3 downto 0);
         second_number_bits : IN  std_logic_vector(3 downto 0);
         product : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal first_number_bits : std_logic_vector(3 downto 0) := (others => '0');
   signal second_number_bits : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal product : std_logic_vector(7 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: wallace_tree_multiplier PORT MAP (
          first_number_bits => first_number_bits,
          second_number_bits => second_number_bits,
          product => product
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;

      -- insert stimulus here 
		first_number_bits  <= "0010";		-- 2
		second_number_bits <= "0011";		-- 3

      wait;
   end process;

END;
