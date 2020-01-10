----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/07/2020 06:59:34 PM
-- Design Name: 
-- Module Name: RAM_TAG - Behavioral
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
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.STD_LOGIC_arith.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity RAM_TAG is
         Port ( a:in std_logic_vector(8 downto 0);
                wrEn: in std_logic;
                writeData:in std_logic_vector(19 downto 0);
                dout:out std_logic_vector(19 downto 0)
                
                 );
end RAM_TAG;

architecture Behavioral of RAM_TAG is

type mem is array(0 to 511) of std_logic_vector(19 downto 0);
signal Ram_tag : mem;

begin
    dout<=Ram_tag(conv_integer(a));
    
    process(a, wrEn,writeData)
    begin
            if (wrEn='1') then
                Ram_tag(conv_integer(a))<=writeData;
            end if;
    end process;

end Behavioral;
