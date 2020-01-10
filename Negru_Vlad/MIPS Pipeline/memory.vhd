library IEEE;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;


entity Ram is
 port ( clk : in std_logic;
 we : in std_logic;
 en : in std_logic;
 addr : in std_logic_vector(7 downto 0);
 di : in std_logic_vector(31 downto 0);
 do : out std_logic_vector(31 downto 0)
 );
end Ram;


architecture syn of Ram is
 type ram_type is array (0 to 255) of std_logic_vector (31 downto 0);
 signal RAM: ram_type:=(
 x"000F000F",
 x"00F0000F",
 x"0F00000F",
 x"F000000F",
 x"F000000F",
 x"F000000F",
 others=> x"00000DBF"
 );
 
begin
 process (clk)
 begin
 if clk'event and clk = '1' then
 if en = '1' then
 if we = '1' then
 RAM(conv_integer(addr)) <= di;
 
 end if;
 end if;
 end if;
  do <= RAM( conv_integer(addr));
 end process;
end syn; 