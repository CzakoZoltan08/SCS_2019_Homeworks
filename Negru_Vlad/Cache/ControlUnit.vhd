----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/07/2020 07:19:01 PM
-- Design Name: 
-- Module Name: ControlUnit - Behavioral
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

entity ControlUnit is
  Port (Match1: in std_logic;
        Match2: in std_logic;
        CS1: out std_logic;
        CS2: out std_logic;
        WR1: out std_logic;
        WR2: out std_logic;
        CSBig: out std_logic;
        WRBig: out std_logic
   );
end ControlUnit;

architecture Behavioral of ControlUnit is
signal sel:std_logic:='0';
begin


process(Match1, Match2)
begin

CS1<='0';
CS2<='0';
WR1<='0';
WR2<='0';
WRBig<='0';
CSBig<='0';

if(Match1 = '1') then CS1<='1';
elsif(Match2 = '1') then CS2<='1';
else
    CSBig<='1';
   
    if(sel = '1') then CS1<='1'; WR1<='1';  sel<='0';
    else CS2<='1'; WR2<='1'; sel<='1';
    end if;
end if;
end process;

end Behavioral;
