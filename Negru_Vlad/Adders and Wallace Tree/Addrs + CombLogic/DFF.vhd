----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/16/2019 06:17:27 PM
-- Design Name: 
-- Module Name: DFF - Behavioral
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

entity DFF is
    Port ( D : in STD_LOGIC;
           Q : out STD_LOGIC;
           clk : in STD_LOGIC;
           en : in STD_LOGIC);
end DFF;

architecture Behavioral of DFF is

begin
DF: process(clk)
begin
if(rising_edge(clk)) then
if(en = '1') then

Q<=D;

end if;
end if;
end process;

end Behavioral;
