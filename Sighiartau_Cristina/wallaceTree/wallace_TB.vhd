library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity wallace_TB is
--  Port ( );
end wallace_TB;

architecture Behavioral of wallace_TB is

component wallace is
Port(x: in std_logic_vector(3 downto 0);
y: in std_logic_vector(3 downto 0);
res: out std_logic_vector(8 downto 0));
end component;

signal clk: std_logic;
signal x, y: std_logic_vector(3 downto 0);
signal res: std_logic_vector(8 downto 0);

begin

portmap: wallace port map (x, y, res);

process
begin

x<="0001"; --1
y<="1111"; --F
wait for 10 ns;


x<="0011"; --3
y<="1000"; --8
wait for 10 ns;


x<="0000"; --0
y<="1111"; --F
wait for 10 ns;

x<="1000"; --8
y<="1111"; --F
wait;

end process;

end Behavioral;
