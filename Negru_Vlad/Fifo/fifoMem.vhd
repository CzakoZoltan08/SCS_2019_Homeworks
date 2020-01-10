----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/30/2019 06:32:32 PM
-- Design Name: 
-- Module Name: fifoMem - Behavioral
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

entity fifoMem is
 Port ( dataIn:in std_logic_vector(7 downto 0);
        rd:in std_logic;
        wr:in std_logic;
        rdinc:in std_logic;
        wrinc:in std_logic;
        clk:in std_logic;
        reset:in std_logic;
        dataOut:out std_logic_vector(7 downto 0)
 
 
 );
end fifoMem;

architecture Behavioral of fifoMem is
type MEM is array(0 to 7) of std_logic_vector(7 downto 0);
signal wrAddr, rdAddr: std_logic_vector(2 downto 0):="000";
signal fifo:MEM;
begin

process(clk, reset)
begin
if(reset = '1') then

for i in 0 to 7 loop
    fifo(i)<="00000000";
end loop; 

elsif(rising_edge(clk)) then

if(rd = '1') then 
dataOut <= fifo(conv_integer(rdAddr));

elsif(wr = '1') then 
fifo(conv_integer(wrAddr)) <= dataIn;

end if;

end if;
end process;

process(clk, reset)
begin

if(reset='1') then

wrAddr<= "000";
rdAddr<= "000";


elsif(rising_edge(clk)) then
if(rdInc ='1') then rdAddr<= rdAddr + 1;
elsif(wrInc = '1') then wrAddr<=wrAddr+1;
end if;
end if;
end process;
end Behavioral;


