----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/07/2020 10:11:41 PM
-- Design Name: 
-- Module Name: mem_MICA - Behavioral
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

entity mem_MICA is
          Port (A:in std_logic_vector(15 downto 0);
                CS: in std_logic;
                WR:in std_logic;
                D:inout std_logic_vector(7 downto 0) );
end mem_MICA;

architecture Behavioral of mem_MICA is
type mem is array(0 to 2**16-1) of std_logic_vector(7 downto 0);
signal ram : mem:=(others=> x"FF");
begin
        process(A,cs,wr,D, ram)
        begin
                if(cs='0') then
                    if(wr='0') then
                        Ram(conv_integer(A))<=D;
                        else
                        D<=Ram(conv_integer(A));
                        end if;
                    else
                        D<=(others=>'Z');
                end if;
          end process;      

end Behavioral;
