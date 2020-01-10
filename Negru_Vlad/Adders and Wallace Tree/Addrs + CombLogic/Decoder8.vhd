----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/16/2019 06:32:14 PM
-- Design Name: 
-- Module Name: Decoder8 - Behavioral
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

entity Decoder8 is
    Port ( x : in STD_LOGIC_vector(2 downto 0);
           y : out STD_LOGIC_vector(7 downto 0));
end Decoder8;

architecture Behavioral of Decoder8 is

begin
y<="00000001" when x="000" else
"00000010" when x="001" else
"00000100" when x="010" else
"00001000" when x="011" else
"00010000" when x="100" else
"00100000" when x="101" else
"01000000" when x="110" else
"10000000";

end Behavioral;
