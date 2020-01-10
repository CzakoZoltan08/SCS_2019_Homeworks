----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:19:26 10/23/2019 
-- Design Name: 
-- Module Name:    rcadd - Behavioral 
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
use IEEE.std_logic_arith.all;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity rcadd is
Port ( a : in STD_LOGIC_VECTOR (7 downto 0);
b : in STD_LOGIC_VECTOR (7 downto 0);
cin : in STD_LOGIC;
s : out STD_LOGIC_VECTOR (7 downto 0);
cout : out STD_LOGIC);

end rcadd;

architecture Behavioral of rcadd is
component fadd is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           cin : in  STD_LOGIC;
           s : out  STD_LOGIC;
           cout : out  STD_LOGIC);
end component;

SIGNAL p :    STD_LOGIC_VECTOR(8 DOWNTO 0);	
SIGNAL q :    STD_LOGIC_VECTOR(8 DOWNTO 0);	
SIGNAL imi :    STD_LOGIC_VECTOR(8 DOWNTO 0);	

begin

imi(0)<=cin;
l1:for i in 7 downto 0 generate
      begin
			l2:fadd port map(a(i),b(i),imi(i),s(i),imi(i+1));
			p(i)<=a(i)and  b(i);
			q(i)<=a(i)or b(i);
			imi(i+1)<=(q(i) and p(i)) or imi(i);
   end generate;
cout<=imi(8);	
end Behavioral;

