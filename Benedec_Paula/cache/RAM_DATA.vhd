----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/07/2020 07:14:11 PM
-- Design Name: 
-- Module Name: RAM_DATA - Behavioral
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

entity RAM_DATA is
          Port ( a:in std_logic_vector(8 downto 0);
                 cs: in std_logic;
                 wrEn: in std_logic;
                 dout:inout std_logic_vector(63 downto 0) );
end RAM_DATA;

architecture Behavioral of RAM_DATA is

type mem is array(0 to 511) of std_logic_vector(63 downto 0);
signal Ram_data : mem;
begin
        process(a,cs,wrEn,dout)
        begin
                if(cs='1') then
                    if(wrEn='1') then
                        Ram_data(conv_integer(a))<=dout;
                        else
                        dout<=Ram_data(conv_integer(a));
                        end if;
                    else
                        dout<=(others=>'Z');
                end if;
                
                
        
        end process;

end Behavioral;
