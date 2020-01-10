----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/17/2019 03:39:12 PM
-- Design Name: 
-- Module Name: memory - Behavioral
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

entity memory is
  Port ( address:in std_logic_vector(23 downto 0);
         data:inout std_logic_vector(15 downto 0);
         wr:in std_logic;
         rd:in std_logic;
         bhe:in std_logic;
         selModule: out std_logic
  );
end memory;

architecture Behavioral of memory is
component SubModule is
  Port ( address: in std_logic_vector(16 downto 0);
           data:inout std_logic_vector(15 downto 0);
           wr: in std_logic;
           seli: in std_logic;
           bhe: in std_logic
  
   );
end component SubModule;

component Decoder is
 Port ( A:in std_logic_vector(2 downto 0);
        E1, E2, E3: in std_logic;
        O: out std_logic_vector(7 downto 0)
 
 
 );
end component Decoder;
signal sel:std_logic_vector(7 downto 0);
signal E1, E2, E3:std_logic;
begin

s0: SubModule port map(address(16 downto 0), data, wr, sel(0), bhe);
s1: SubModule port map(address(16 downto 0), data, wr, sel(1), bhe);
s2: SubModule port map(address(16 downto 0), data, wr, sel(2), bhe);
s3: SubModule port map(address(16 downto 0), data, wr, sel(3), bhe);
s4: SubModule port map(address(16 downto 0), data, wr, sel(4), bhe);
s5: SubModule port map(address(16 downto 0), data, wr, sel(5), bhe);
s6: SubModule port map(address(16 downto 0), data, wr, sel(6), bhe);
s7: SubModule port map(address(16 downto 0), data, wr, sel(7), bhe);

DCD: Decoder port map(address(19 downto 17), E1, E2, E3, sel);
E1<= not ((not address(20)) and (not address(21)) and address(22) and address(23));
    E2 <= RD and WR;
E3 <= '1';
selModule <= (RD and WR) or E1;
end Behavioral;
