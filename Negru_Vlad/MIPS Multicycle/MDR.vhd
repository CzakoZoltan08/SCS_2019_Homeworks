----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/20/2019 02:39:12 PM
-- Design Name: 
-- Module Name: MDR - Behavioral
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

entity MDR is
  Port (clk:in std_logic;
  reset:in std_logic;
  writeEn: in std_logic;
  memdata:in std_logic_vector(31 downto 0);
  dataOut:out std_logic_vector(31 downto 0)
  
   );
end MDR;

architecture Behavioral of MDR is
signal dataBuff:std_logic_vector(31 downto 0):=x"00000000";
begin
process(clk, reset)
begin

if(reset = '1') then
dataBuff<= (others =>'0');
elsif(rising_edge(clk)) then
if(writeEn = '1') then

dataBuff<=memdata; 
end if;
end if;

end process;

dataOut<=dataBuff;

end Behavioral;
