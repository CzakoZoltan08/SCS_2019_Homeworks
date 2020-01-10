----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/17/2019 03:24:20 PM
-- Design Name: 
-- Module Name: SubModule - Behavioral
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

entity SubModule is
  Port ( address: in std_logic_vector(16 downto 0);
           data:inout std_logic_vector(15 downto 0);
           wr: in std_logic;
           seli: in std_logic;
           bhe: in std_logic
  
  
   );
end SubModule;

architecture Behavioral of SubModule is
component memory64k8bit is
  Port ( address: in std_logic_vector(15 downto 0);
           cs:in std_logic;
           wr:in std_logic;
           data:inout std_logic_vector(7 downto 0)
  
  
  
  );
end component memory64k8bit;
signal csLow, csHigh: std_logic;
begin
m1: memory64k8bit port map (address(16 downto 1), csLow, wr, data(7 downto 0));
m2: memory64k8bit port map (address(16 downto 1), csHigh, wr, data(15 downto 8));
csLow <= seli or address(0);    
csHigh <= seli or bhe;
end Behavioral;
