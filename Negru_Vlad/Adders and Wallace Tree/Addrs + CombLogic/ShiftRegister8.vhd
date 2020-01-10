----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/16/2019 06:22:10 PM
-- Design Name: 
-- Module Name: ShiftRegister8 - Behavioral
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

entity ShiftRegister8 is
    Port ( clk : in STD_LOGIC;
           en : in STD_LOGIC;
           si : in STD_LOGIC;
           so : out STD_LOGIC);
end ShiftRegister8;

architecture Behavioral of ShiftRegister8 is
signal val:std_logic_vector(7 downto 0):="00000000";
begin

shft: process(clk)
begin

if(rising_edge(clk)) then
if(en='1') then

for i in 0 to 6 loop
val(i+1) <= val(i);
end loop;
val(0) <= si;

end if;
end if;

end process;
so<=val(7);
end Behavioral;
