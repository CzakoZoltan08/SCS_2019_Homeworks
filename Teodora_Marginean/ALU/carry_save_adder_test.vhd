--------------------------------------------------------------------------------
-- Company: 
-- Engineer:
--
-- Create Date:   12:28:49 10/23/2019
-- Design Name:   
-- Module Name:   C:/Users/student/30433/lab_4/ripple_carry_test.vhd
-- Project Name:  lab_4
-- Target Device:  
-- Tool versions:  
-- Description:   
-- 
-- VHDL Test Bench Created by ISE for module: ripple_carry
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
 
ENTITY carry_save_test IS
END carry_save_test;
 
ARCHITECTURE behavior OF carry_save_test IS 
 
    -- Component Declaration for the Unit Under Test (UUT)

 component carry_save_adder is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
	   C : in  STD_LOGIC_VECTOR (3 downto 0);
           cin : in  STD_LOGIC;
           sum : out  STD_LOGIC_VECTOR (4 downto 0);
           cout : out  STD_LOGIC);
end component;
    

   --Inputs
   signal a : std_logic_vector(3 downto 0) := (others => '0');
   signal b : std_logic_vector(3 downto 0) := (others => '0');
   signal c : std_logic_vector(3 downto 0) := (others => '0');
   signal cin : std_logic := '0';

 	--Outputs
   signal sum : std_logic_vector(4 downto 0);
   signal cout : std_logic;
   -- No clocks detected in port list. Replace <clock> below with 
   -- appropriate port name 
 
 
	constant period : time := 10 ns;
	
	
BEGIN
 
	-- Instantiate the Unit Under Test (UUT)
   uut: carry_save_adder PORT MAP (
          a => a,
          b => b,
	  c => c,
          cin => cin,
          sum => sum,
          cout => cout
        );

  

   -- Stimulus process
   stim_proc: process
   begin		
      -- hold reset state for 100 ns.
      wait for 100 ns;	

      wait for period*10;

      -- insert stimulus here 

		A <= "0010";
		B <= "1111";
		C <= "0101";
		cin <= '1';
		
		wait for period * 10;
		
      wait;
   end process;

END;
