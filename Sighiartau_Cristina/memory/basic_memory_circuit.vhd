----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/30/2019 04:19:37 PM
-- Design Name: 
-- Module Name: basic_memory_circuit - Behavioral
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
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity basic_memory_circuit is
Port (
address_bus: in std_logic_vector(15 downto 0);
cs: in std_logic;
wr: in std_logic;
data_in: in std_logic_vector(7 downto 0);
data_out: out std_logic_vector(7 downto 0)
 );
end basic_memory_circuit;

architecture Behavioral of basic_memory_circuit is

type memory_type is array (0 to 63) of std_logic_vector(7 downto 0);
signal memory: memory_type := ( x"54", x"0F", x"74", x"AB",x"20", x"A5",x"B7", x"98",x"A8", x"C7",x"8D", x"DD",x"10", x"16",x"7F", x"EE",x"21", x"49",x"42", x"87", others => x"00");

begin

  data_out<= memory(conv_integer(address_bus)) when cs='0';
  memory(conv_integer(address_bus))<=data_in when wr='0' and cs='0';

end Behavioral;
