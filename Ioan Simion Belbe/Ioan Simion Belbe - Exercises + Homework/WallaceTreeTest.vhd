LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

 
ENTITY WallaceTreeTest IS
END WallaceTreeTest;
 
 
 
ARCHITECTURE behavior OF WallaceTreeTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT Multiply
    PORT(
         a       :  IN  STD_LOGIC_VECTOR(3 downto 0);
         b       :  IN  STD_LOGIC_VECTOR(3 downto 0);
         Product : OUT  STD_LOGIC_VECTOR(7 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   SIGNAL a : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
   SIGNAL b : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');

 	--Outputs
   SIGNAL Product : STD_LOGIC_VECTOR(7 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   CONSTANT period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: Multiply 
				PORT MAP (
							 a       =>       a,
							 b       =>       b,
							 Product => Product
							);

   -- Clock process definitions
--   <clock>_process :process
--   begin
--		<clock> <= '0';
--		wait for <clock>_period/2;
--		<clock> <= '1';
--		wait for <clock>_period/2;
--   end process;
 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for period*10;

      -- insert stimulus here 

      a <= "0010";
		b <= "0010";
		
		wait for period*10;
		
		a <= "0101";
		b <= "0101";
		
		wait for period*10;
		
   end process;

END;
