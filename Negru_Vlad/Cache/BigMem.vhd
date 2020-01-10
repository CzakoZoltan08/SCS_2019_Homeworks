----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/07/2020 07:10:15 PM
-- Design Name: 
-- Module Name: DataRam - Behavioral
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

entity BigRam is
  Port (A: in std_logic_vector(31 downto 0);
        D: inout std_logic_vector(63 downto 0);
        CS: in std_logic;
        Write:in std_logic
        --WriteData: in std_logic_vector(63 downto 0)
  
   );
end BigRam;

architecture Behavioral of BigRam is
type mem is array (0 to 2**16-1) of std_logic_vector(63 downto 0);
signal DataR: mem:=(
x"1234567890123456",
x"2345678901234567",
x"3456789012345678",
others=> x"FFFFFFFFFFFFFFFF"
);
begin



process(CS, Write, D, A)
begin

if(Cs = '1') then
 if(Write ='1') then 
    DataR(conv_integer(A(18 downto 3))) <= D;
 else D<= DataR(conv_integer(A(18 downto 3)));
 end if;
else D<= (others => 'Z');
end if;

end process;
end Behavioral;
