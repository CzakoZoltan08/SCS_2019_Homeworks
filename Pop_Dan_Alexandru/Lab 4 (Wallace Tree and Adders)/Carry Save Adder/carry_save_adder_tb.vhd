LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY carry_save_adder_tb IS
END carry_save_adder_tb;
 
ARCHITECTURE behavior OF carry_save_adder_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT carry_saver_adder
    PORT(
         a : IN  std_logic_vector(3 downto 0);
         b : IN  std_logic_vector(3 downto 0);
         c : IN  std_logic_vector(3 downto 0);
         sum : OUT  std_logic_vector(3 downto 0);
         carry_out : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(3 downto 0) := (others => '0');
   signal b : std_logic_vector(3 downto 0) := (others => '0');
   signal c : std_logic_vector(3 downto 0) := (others => '0');

 	--Outputs
   signal sum : std_logic_vector(3 downto 0);
   signal carry_out : std_logic_vector(3 downto 0);
	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: carry_saver_adder PORT MAP (
          a => a,
          b => b,
          c => c,
          sum => sum,
          carry_out => carry_out
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      -- insert stimulus here 
		a <= "0001";
		b <= "0001";
		c <= "0001";

      wait;
   end process;

END;
