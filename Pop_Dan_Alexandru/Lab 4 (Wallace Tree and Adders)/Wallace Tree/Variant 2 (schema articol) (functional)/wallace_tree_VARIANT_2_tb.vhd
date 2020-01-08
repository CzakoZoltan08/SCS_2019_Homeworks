LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY wallace_tree_VARIANT_2_tb IS
END wallace_tree_VARIANT_2_tb;
 
ARCHITECTURE behavior OF wallace_tree_VARIANT_2_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT wallace_tree_VARIANT_2
    PORT(
         A : IN  std_logic_vector(3 downto 0);
         B : IN  std_logic_vector(3 downto 0);
         prod : OUT  std_logic_vector(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal A : std_logic_vector(3 downto 0) := (others => '0');
   signal B : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal prod : std_logic_vector(7 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: wallace_tree_VARIANT_2 PORT MAP (
          A => A,
          B => B,
          prod => prod
        ); 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      -- insert stimulus here 
		A <= "0010";	-- 2
		B <= "0011";	-- 3
		
      wait;
   end process;

END;
