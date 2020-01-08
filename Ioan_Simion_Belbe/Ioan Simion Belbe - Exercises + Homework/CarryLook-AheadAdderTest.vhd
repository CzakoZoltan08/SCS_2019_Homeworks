LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 

 
ENTITY CarryLookaheadAdderTest IS
END CarryLookaheadAdderTest;
 
 
 
ARCHITECTURE TestBehavior OF CarryLookaheadAdderTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CarryLookaheadAdder
    PORT(
			cin  :  in STD_LOGIC;
			a    :  in STD_LOGIC_VECTOR (3 downto 0); 
			b    :  in STD_LOGIC_VECTOR (3 downto 0);
			cout : out STD_LOGIC;
			s    : out STD_LOGIC_VECTOR (3 downto 0) 
        );
    END COMPONENT;
    

   --Inputs
   SIGNAL a : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
   SIGNAL b : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
   SIGNAL cin : STD_LOGIC := '0';

 	--Outputs
   SIGNAL s : STD_LOGIC_VECTOR(3 downto 0);
   SIGNAL cout : STD_LOGIC;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   CONSTANT period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CarryLookaheadAdder PORT MAP (
          cin => cin,
			 a => a,
          b => b,
          cout => cout,
          s => s
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
   stim_proc: PROCESS
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for period*10;

      -- insert stimulus here 

      cin <= '0';
		
		a <= "0001";
		b <= "0010";
		
		wait for period*10;
		
		a <= "0010";
		b <= "0010";
		
		wait for period*10;
		
		a <= "1111";
		b <= "1111";
		
		wait for period*10;
		
   end process;

END;
