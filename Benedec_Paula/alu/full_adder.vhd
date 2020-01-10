----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.10.2019 16:59:24
-- Design Name: 
-- Module Name: full_adder - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity full_adder is
  Port ( i_bit1  : in  std_logic;
     i_bit2  : in  std_logic;
     i_carry : in  std_logic;
     o_sum   : out std_logic;
     o_carry : out std_logic );
end full_adder;

architecture Behavioral of full_adder is
   
    
begin
     o_sum<= i_bit1 xor i_bit2 xor i_carry;
     o_carry<=(i_bit1 and i_bit2) or((i_bit2 or i_bit2) and i_carry);

end Behavioral;
