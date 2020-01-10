----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/20/2019 04:12:48 PM
-- Design Name: 
-- Module Name: regA - Behavioral
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

entity regA is
  Port (dataIn: in std_logic_vector(31 downto 0);
        clk: in std_logic;
        wr: in std_logic;
        dataOut:out std_logic_vector(31 downto 0)
  
   );
end regA;

architecture Behavioral of regA is
signal dataBuff:std_logic_vector(31 downto 0);
begin

process(clk, wr)
begin
if(rising_edge(clk)) then
if(wr ='1') then 
    dataBuff<=dataIn;
end if;
end if;
end process;
dataOut<=dataBuff;
end Behavioral;
