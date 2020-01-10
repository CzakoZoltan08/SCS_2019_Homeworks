----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.11.2019 10:20:08
-- Design Name: 
-- Module Name: regUniv - Behavioral
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

entity regUniv is
  Port ( clk: in std_logic;
         wrEn: in std_logic;
         input: in std_logic_vector(31 downto 0);
         output: out std_logic_vector(31 downto 0) );
end regUniv;

architecture Behavioral of regUniv is

signal aux: std_logic_vector(31 downto 0) :=x"00000000";
begin

process(clk,wrEn)
    begin
        if (rising_edge(clk)) then
            if(wrEn= '1') then
               aux<=input;
            end if;
        end if;
   end process;
   
   output<= aux;
        


end Behavioral;
