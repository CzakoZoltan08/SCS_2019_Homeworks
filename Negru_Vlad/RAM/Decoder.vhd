----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/17/2019 03:31:37 PM
-- Design Name: 
-- Module Name: Decoder - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Decoder is
 Port ( A:in std_logic_vector(2 downto 0);
        E1, E2, E3: in std_logic;
        O: out std_logic_vector(7 downto 0)
 
 
 );
end Decoder;


architecture Behavioral of Decoder is

begin

process(A, E1, E2, E3)
begin
if(E1 = '0' and E2 = '0' and E3='1') then
    O<= (conv_integer(A) => '0',
    others => '1');
else O<= (others=>'1');
end if;
end process;



end Behavioral;
