LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;
 
ENTITY carry_lookahead_adder_tb IS
END carry_lookahead_adder_tb;
 
ARCHITECTURE behavior OF carry_lookahead_adder_tb IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
    COMPONENT carry_lookahead_adder
    PORT(
         x : IN  std_logic_vector(3 downto 0);
         y : IN  std_logic_vector(3 downto 0);
         Cin : IN  std_logic;
         S : OUT  std_logic_vector(3 downto 0);
         Cout : OUT  std_logic_vector(3 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   signal x : std_logic_vector(3 downto 0) := (others => '0');
   signal y : std_logic_vector(3 downto 0) := (others => '0');
   signal Cin : std_logic := '0';

 	--Outputs
   signal S : std_logic_vector(3 downto 0);
   signal Cout : std_logic_vector(3 downto 0);
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: carry_lookahead_adder PORT MAP (
          x => x,
          y => y,
          Cin => Cin,
          S => S,
          Cout => Cout
        );

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      -- insert stimulus here 
		x <= "0110";
		y <= "0001";
		cin <= '1';
		
		wait for 60 ns;
		
		x <= "0001";
		y <= "0001";
		cin <= '0';

      wait;
   end process;

END;
