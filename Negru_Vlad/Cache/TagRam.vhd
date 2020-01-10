----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/07/2020 06:55:23 PM
-- Design Name: 
-- Module Name: TagRam - Behavioral
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

entity TagRam is
Port ( A: in std_logic_vector(8 downto 0);
       D: out std_logic_vector(19 downto 0);
       Write: in std_logic;
       WriteData: in std_logic_vector(19 downto 0)

 );
end TagRam;

architecture Behavioral of TagRam is
type mem is array(0 to 511) of std_logic_vector(19 downto 0);
signal TagR: mem:=(others => (others => 'U'));
begin


D<= TagR(conv_integer(A));

process(Write, A, WriteData)
begin

if(Write = '1') then
     TagR(conv_integer(A))<= WriteData;
end if;


end process;


end Behavioral;
