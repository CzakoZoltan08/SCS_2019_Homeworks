----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:42:06 10/23/2019 
-- Design Name: 
-- Module Name:    carry_generator - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;

use IEEE.STD_LOGIC_1164.ALL;

use ieee.std_logic_unsigned.all;

use ieee.std_logic_arith.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity carry_generator is
    Port ( xi : in  STD_LOGIC_vector(3 downto 0);
           yi : in  STD_LOGIC_vector(3 downto 0);
           cin : in  STD_LOGIC;
           cout : out  STD_LOGIC);
end carry_generator;

architecture Behavioral of carry_generator is

signal pi: std_logic_vector(3 downto 0) := "0000";
signal gi: std_logic_vector(3 downto 0) := "0000";
signal cii: std_logic_vector(4 downto 0) := "00000";


begin

	cii(0) <= cin;

	p1: process(xi, yi)
	begin
		for count in 0 to 3 loop
			gi(count) <= xi(count) and yi(count);
			pi(count) <= xi(count) or yi(count);
			cii(count + 1) <= gi(count) or ( pi(count) and cii(count));
		end loop;
	end process p1;
	
	cout <= cii(4);
	
end Behavioral;

