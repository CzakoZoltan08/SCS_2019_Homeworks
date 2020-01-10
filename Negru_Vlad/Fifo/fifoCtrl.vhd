----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/30/2019 06:43:49 PM
-- Design Name: 
-- Module Name: fifoCtrl - Behavioral
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

entity fifoCtrl is
  Port (
    rd:in std_logic;
    wr: in std_logic;
    clk:in std_logic;
    reset:in std_logic;
    rdInc:out std_logic;
    wrInc:out std_logic;
    empty:out std_logic;
    full:out std_logic
  
  
   );
end fifoCtrl;

architecture Behavioral of fifoCtrl is
signal wrAddr, rdAddr: std_logic_vector(3 downto 0):="0000";
signal emptyBuffer, fullBuffer:std_logic;
begin

fullBuffer<= (wrAddr(3) xor rdAddr(3)) and (not (wrAddr(2) xor  rdAddr(2))) and (not (wrAddr(1) xor  rdAddr(1))) and (not (wrAddr(0) xor  rdAddr(0)));
emptyBuffer<= (not(wrAddr(3) xor rdAddr(3))) and (not (wrAddr(2) xor  rdAddr(2))) and (not (wrAddr(1) xor  rdAddr(1))) and (not (wrAddr(0) xor  rdAddr(0)));

empty <= emptyBuffer;
full <= fullBuffer;

process(clk, reset) 
begin
if(reset ='1') then
rdAddr<="0000";
wrAddr<="0000";
 rdInc<='0';
 wrInc<='0';
elsif(rising_edge(clk)) then

if(rd='1') then
    if(emptyBuffer='1') then
    rdInc<='0';
    else rdInc<='1';
    rdAddr<= rdAddr + 1;
    end if;
    
elsif(wr='1') then
    if(fullBuffer='1') then 
    wrInc<='0';
    else wrInc<='1';
    wrAddr <= wrAddr+1;
    end if;
else
    wrInc<='0';
    rdInc<='0';    
end if;
end if;
end process;

end Behavioral;
