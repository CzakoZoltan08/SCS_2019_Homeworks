LIBRARY ieee;
USE ieee.std_logic_1164.ALL;


 
ENTITY CarrySaveAdderTest IS
END CarrySaveAdderTest;
 
ARCHITECTURE behavior OF CarrySaveAdderTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT CarrySaveAdder
    PORT(
         a : IN  std_logic_vector(3 downto 0);
         b : IN  std_logic_vector(3 downto 0);
         c : IN  std_logic_vector(3 downto 0);
         cout : OUT  std_logic;
         s : OUT  std_logic_vector(4 downto 0)
        );
    END COMPONENT;
    

   --Inputs
   SIGNAL a : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
   SIGNAL b : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
   SIGNAL c : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');

 	--Outputs
   SIGNAL cout : STD_LOGIC;
   SIGNAL s    : STD_LOGIC_VECTOR(4 downto 0);
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   CONSTANT period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: CarrySaveAdder 
				PORT MAP (
							 a => a,
							 b => b,
							 c => c,
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
		
		a <= "0001";
		b <= "0010";
		c <= "0100";
		
		wait for period*10;
		
		a <= "0010";
		b <= "0010";
		c <= "0100";
		
		wait for period*10;
		
		a <= "1111";
		b <= "1111";
		c <= "1111";
		
		wait for period*10;

      wait;
   END PROCESS;

END;
