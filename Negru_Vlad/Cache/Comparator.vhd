----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/07/2020 06:52:08 PM
-- Design Name: 
-- Module Name: Comparator - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
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
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Comparator is
  Port (A: in std_logic_vector(19 downto 0);
        B: in std_logic_vector(19 downto 0);
        res: out std_logic
  
   );
end Comparator;

architecture Behavioral of Comparator is

begin
process(a, b)
begin
if(a=b) then res<='1';
else res<='0';
end if;
end process;

end Behavioral;
