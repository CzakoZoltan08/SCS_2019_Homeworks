LIBRARY ieee;
USE ieee.std_logic_1164.ALL;



ENTITY RippleCarryAdderTest IS
END RippleCarryAdderTest;
 
 
 
ARCHITECTURE TestBehavior OF RippleCarryAdderTest IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT RippleCarryAdder
		PORT ( 
			   cin  :  in STD_LOGIC;
			   a    :  in STD_LOGIC_VECTOR (3 downto 0); 
			   b    :  in STD_LOGIC_VECTOR (3 downto 0); 
			   cout : out STD_LOGIC;
			   s    : out STD_LOGIC_VECTOR (3 downto 0)
			  );
    END COMPONENT;
    

   --Inputs
    SIGNAL CIN : STD_LOGIC := '0';
   SIGNAL A   : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
   SIGNAL B   : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
   

 	--Outputs
	SIGNAL COUT : STD_LOGIC;
   SIGNAL S    : STD_LOGIC_VECTOR(3 downto 0);

   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   CONSTANT period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: RippleCarryAdder 
		PORT MAP (
					 cin  => CIN,
                a    => A,
                b    => B,
                cout => COUT,
                s    => S          
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
   BEGIN		
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
		
   END PROCESS;

END;
