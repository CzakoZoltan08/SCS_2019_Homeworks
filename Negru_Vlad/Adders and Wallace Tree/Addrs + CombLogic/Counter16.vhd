----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/16/2019 06:25:33 PM
-- Design Name: 
-- Module Name: Counter16 - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;



-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Counter16 is
    Port ( clk : in STD_LOGIC;
           en : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR(7 downto 0));
end Counter16;

architecture Behavioral of Counter16 is
signal val:std_logic_vector(7 downto 0):="00000000";
begin
cnt: process(clk)
begin

if(rising_edge(clk)) then
if(en = '1') then
val<=val+1;
end if;
end if;

end process;
Q<=val;
end Behavioral;
