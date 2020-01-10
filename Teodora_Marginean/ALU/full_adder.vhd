----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:22:38 10/23/2019 
-- Design Name: 
-- Module Name:    full_adder - Behavioral 
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity full_adder is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           cin : in  STD_LOGIC;
           s : out  STD_LOGIC;
           cout : out  STD_LOGIC);
end full_adder;

architecture Behavioral of full_adder is

signal s1, s2, s3, s4: std_logic;

begin

	p1: process (b, cin)
	begin
		s1 <= b xor cin;
	end process p1;
	
	p2: process (a, b)
	begin
		s2 <= a and b;
	end process p2;

	p3: process (a, cin)
	begin
		s3 <= a and cin;
	end process p3;
	
	p4: process (b, cin)
	begin
		s4 <= b and cin;
	end process p4;
	
	p5: process (a, s1)
	begin
		s <= a xor s1;
	end process p5;
	
	p6: process (s2, s3, s4)
	begin
		cout <= s2 or s3 or s4;
	end process p6;

end Behavioral;

