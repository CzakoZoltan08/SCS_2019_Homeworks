----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/17/2019 03:15:16 PM
-- Design Name: 
-- Module Name: TopModule - Behavioral
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

entity TopModule is
 -- Port ( );
end TopModule;

architecture Behavioral of TopModule is
component memory is
  Port ( address:in std_logic_vector(23 downto 0);
         data:inout std_logic_vector(15 downto 0);
         wr:in std_logic;
         rd:in std_logic;
         bhe:in std_logic;
         selModule: out std_logic
  
  );
end component memory;

component SubModule is
  Port ( address: in std_logic_vector(16 downto 0);
           data:inout std_logic_vector(15 downto 0);
           wr: in std_logic;
           seli: in std_logic;
           bhe: in std_logic
  
  
   );
end component SubModule;
component memory64k8bit is
  Port ( address: in std_logic_vector(15 downto 0);
           cs:in std_logic;
           wr:in std_logic;
           data:inout std_logic_vector(7 downto 0)
  
  
  
  );
end component memory64k8bit;

signal address:std_logic_vector(23 downto 0);
signal data: std_logic_vector(15 downto 0):=(others=>'Z');
signal wr, rd, bhe:std_logic:='1';
signal cs:std_logic:='1';
signal seli:std_logic;
begin

memory1: memory port map(address, data, wr, rd, bhe);

process
begin
address(23 downto 20)<="1100";
address(19 downto 0) <= (others => '0');
wr<='1';
rd<='0';
bhe<='1';
wait for 20ns;
bhe<='0';
rd<='0';
wait for 20ns;
bhe<='1';
rd<='1';
wr<='1';
data<=x"DDDD";

wait for 20ns;

wr<='0';
rd<='1';

wait for 20ns;

wr<='1';
data<=(others=>'Z');
rd<='0';
bhe<='0';
wait for 20ns;

address(19 downto 1)<=(others=>'1');
wait for 20ns;
data<=x"ABCD";
address(0) <='1';
rd<='1';
wait for 20ns;
wr<='0';
wait for 20ns;
wr<='1';
address(0)<='0';
data<=(others=>'Z');
wait for 20ns;
rd<='0';
wait;



end process;

end Behavioral;
