----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/20/2019 02:59:31 PM
-- Design Name: 
-- Module Name: Memory - Behavioral
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

entity Memory is
  Port (addr: in std_logic_vector(31 downto 0);
       dataIn:in std_logic_vector(31 downto 0);
       dataOut:out std_logic_vector(31 downto 0);
       we:in std_logic;
       en: in std_logic;
       clk:in std_logic
   );
end Memory;

architecture Behavioral of Memory is
type ram_type is array (0 to 255) of std_logic_vector (31 downto 0);
 signal RAM: ram_type:=(
 "10001100111000010000000000001001", -- 0 R(1) = Mem(R(7) + 9)
 "10001100111000100000000000001010", -- 1 R(2) = Mem(R(7) + 10)
 "00000000001000100001100000100000", -- 2 R3 = R1 + R2
 "00000000001000100010000000100010", -- 3 R4 = R1 - R2
 "00000000001000100010000000100100", -- 4 R4 = R1 and R2
 "00000000001000100010000000100101", -- 5 R4 = R1 or R2
 "10101100111000110000000000001111", -- 6 Mem(15 + R(7)) = R3 
 "10001100111000000000000000001111", -- 7 R0 = Mem(15 + R(7))
 "00000000000001110001100000100000", -- 8 R3 = R0 + R7
 x"00000014", -- 9 --memory
 x"0000002F", -- 10 -- memory
others=>x"00000000" --restul
 );
 
begin
 process(clk, addr)
 begin
 if clk'event and clk = '1' then
 if en = '1' then
 if we = '1' then
 RAM(conv_integer(addr(7 downto 0))) <= dataIn;
 
 end if;
 end if;
 end if;
  dataOut <= RAM( conv_integer(addr(7 downto 0)));
 end process;
end Behavioral;
