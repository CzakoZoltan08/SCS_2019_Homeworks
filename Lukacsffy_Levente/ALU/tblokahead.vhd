--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   15:35:33 10/23/2019
-- Design Name:   
-- Module Name:   C:/Users/Student/Desktop/lkf/l4/tblokahead.vhd
-- Project Name:  l4
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: rcadd
-- 
-- Dependencies:
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
--
-- Notes: 
-- This testbench has been automatically generated using types std_logic and
-- std_logic_vector for the ports of the unit under test.  Xilinx recommends
-- that these types always be used for the top-level I/O of a design in order
-- to guarantee that the testbench will bind correctly to the post-implementation 
-- simulation model.
--------------------------------------------------------------------------------
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
 
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--USE ieee.numeric_std.ALL;
 
ENTITY tblokahead IS
END tblokahead;
 
ARCHITECTURE behavior OF tblokahead IS 
 
    -- Component Declaration for the Unit Under Test (UUT)
 
    COMPONENT rcadd
    PORT(
         a : IN  std_logic_vector(7 downto 0);
         b : IN  std_logic_vector(7 downto 0);
         cin : IN  std_logic;
         s : OUT  std_logic_vector(7 downto 0);
         cout : OUT  std_logic
        );
    END COMPONENT;
    

   --Inputs
   signal a : std_logic_vector(7 downto 0) := (others => '0');
   signal b : std_logic_vector(7 downto 0) := (others => '0');
   signal cin : std_logic := '0';

 	--Outputs
   signal s : std_logic_vector(7 downto 0);
   signal cout : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
   constant period : time := 10 ns;
 
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: rcadd PORT MAP (
          a => a,
          b => b,
          cin => cin,
          s => s,
          cout => cout
        );

 

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      
      wait for period*10;

      -- insert stimulus here 
		a<="01101111";
		b<="00001001";
		cin<='1';
		wait for period*10;
      wait;
   end process;

END;
