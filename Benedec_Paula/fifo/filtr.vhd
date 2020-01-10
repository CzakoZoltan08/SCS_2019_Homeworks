----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/10/2020 09:40:26 PM
-- Design Name: 
-- Module Name: filtr - Behavioral
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

entity filtr is
    Port ( d :in std_logic;
            clk:in std_logic;
            rst:in std_logic;
            q:out std_logic);
end filtr;

architecture Behavioral of filtr is
signal q1,q2,q3: std_logic;
begin
process(clk)
begin
   if (clk'event and clk = '1') then
      if (rst = '1') then
         Q1 <= '0';
         Q2 <= '0';
         Q3 <= '0';
      else
         Q1 <= D;
         Q2 <= Q1;
         Q3 <= Q2;
      end if;
   end if;
end process;

Q <= Q1 and Q2 and (not Q3);

end Behavioral;
