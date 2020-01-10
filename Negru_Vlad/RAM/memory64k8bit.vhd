----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/17/2019 03:15:51 PM
-- Design Name: 
-- Module Name: memory64k8bit - Behavioral
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

entity memory64k8bit is
  Port ( address: in std_logic_vector(15 downto 0);
           cs:in std_logic;
           wr:in std_logic;
           data:inout std_logic_vector(7 downto 0)
  
  
  
  );
end memory64k8bit;

architecture Behavioral of memory64k8bit is
 type ram_type is array (0 to 2**16-1) of std_logic_vector (7 downto 0);
signal RAM: ram_type:=(
x"0F",
x"0F",
x"0F",
x"0F",
x"0F",
x"0F",
others=> x"BF"
);
signal data_out:std_logic_vector(7 downto 0);
begin

process(cs, wr, ram, address, data)
begin
if(cs = '0') then
if(wr='0') then
ram(conv_integer(address)) <= data;
else data<=ram(conv_integer(address));
end if;
else data<=(others=>'Z');
end if;
end process;
end Behavioral;
