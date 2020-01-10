----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    11:39:32 10/23/2019 
-- Design Name: 
-- Module Name:    carry_lookahead - Behavioral 
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

entity carry_lookahead is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
           cin : in  STD_LOGIC;
           sum : out  STD_LOGIC_VECTOR (3 downto 0);
           cout : out  STD_LOGIC);
end carry_lookahead;

architecture Behavioral of carry_lookahead is

component full_adder is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           cin : in  STD_LOGIC;
           s : out  STD_LOGIC;
           cout : out  STD_LOGIC);
end component;

component carry_generator is
    Port ( xi : in  STD_LOGIC_vector(3 downto 0);
           yi : in  STD_LOGIC_vector(3 downto 0);
           cin : in  STD_LOGIC;
           cout : out  STD_LOGIC);
end component;

signal Carryv: std_logic_vector(4 downto 0);

begin
	Carryv(0) <= Cin;
	
	Adder: FOR k IN 3 downto 0 generate
		FA: full_adder port map (A(k), B(k), Carryv(k), sum(k), open);
	end generate Adder;
	
	Carry_gen: carry_generator port map(A, B, cin, cout);
	
end Behavioral;
