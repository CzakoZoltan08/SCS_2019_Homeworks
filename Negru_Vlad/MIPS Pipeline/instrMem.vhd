----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/14/2019 02:20:03 PM
-- Design Name: 
-- Module Name: Rom - Behavioral
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

entity Rom is
  Port (
     Addr:in std_logic_vector(31 downto 0);
    Digits:out std_logic_vector(31 downto 0)
   
   );
end Rom;

architecture Behavioral of Rom is

type ram_type is array (0 to 255) of std_logic_vector (31 downto 0);
 signal ROM: ram_type:=(
 "10001100111000010000000000001001", -- 0 R(1) = Mem(R(7) + 9)
 "10001100111000100000000000001010", -- 1 R(2) = Mem(R(7) + 10)
 "00000011111111111111100000100000", -- 2 NO OP
 "00000011111111111111100000100000", -- 3 NO OP
 "00000011111111111111100000100000", -- 4 NO OP
 "00000000001000100001100000100000", -- 5 R3 = R1 + R2
 "00000000001000100010000000100010", -- 6 R4 = R1 - R2
 "00000011111111111111100000100000", -- 7 NO OP
 "00000011111111111111100000100000", -- 8 NO OP
 "00000011111111111111100000100000", -- 9 NO OP
 "00000000001000100010000000100100", -- 10 R4 = R1 and R2
 "00000011111111111111100000100000", -- 11 NO OP
 "00000011111111111111100000100000", -- 12 NO OP
 "00000011111111111111100000100000", -- 13 NO OP
 "00000000001000100010000000100101", -- 14 R4 = R1 or R2
 "00000011111111111111100000100000", -- 15 NO OP
 "00000011111111111111100000100000", -- 16 NO OP
 "00000011111111111111100000100000", -- 17 NO OP
 "10101100111000110000000000001111", -- 18 Mem(15 + R(7)) = R3 
 "00000011111111111111100000100000", -- 19 NO OP
 "00000011111111111111100000100000", -- 20 NO OP
 "00000011111111111111100000100000", -- 21 NO OP
 "10001100111000000000000000001111", -- 22 R0 = Mem(15 + R(7))
 "00000011111111111111100000100000", -- 23 NO OP
 "00000011111111111111100000100000", -- 24 NO OP
 "00000011111111111111100000100000", -- 25 NO OP
 "00000000000001110001100000100000", -- 26 R3 = R0 + R7


others=>x"00000000" --restul
 );
begin

Digits<=ROM(conv_integer(Addr(7 downto 0)));




end Behavioral;
