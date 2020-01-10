----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.11.2019 10:33:53
-- Design Name: 
-- Module Name: MEM - Behavioral
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

entity MEM is
  Port (    clk:in std_logic;
            en: in std_logic;
            wrEn: in std_logic;
            readAddr :in std_logic_vector(31 downto 0);
            readData:in std_logic_vector(31 downto 0);
            writeData:out std_logic_vector(31 downto 0));
end MEM;

architecture Behavioral of MEM is

type ram_array  is array(0 to 255 ) of 
    std_logic_vector(31 downto 0);
    
signal mem_ram : ram_array :=(
 "10001101111000000000000000000111", -- 0 load a
 "00000000000000000000100000100000", -- 1 a+a=2a
 "00000000001000000001000000100010", -- 2 2a-a
 "00000000001000000001100000100100", -- 3 and, 2a and a
 "10101101111000010000000000001111", -- 4 store 
 "10001101111000110000000000001111", -- 5 load 2a 
 "00000000000000110001000000100101", -- 6 or 2a a
 x"000000A4", -- 7

others=>x"00000000" --rest
 );
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if (en='1') then
                if(wrEn='1') then
                    mem_ram(conv_integer(readAddr(7 downto 0)))<= readData;
                end if;
            end if;
        end if;
    end process;
    
     writeData <= mem_ram( conv_integer(readAddr(7 downto 0)));


end Behavioral;
