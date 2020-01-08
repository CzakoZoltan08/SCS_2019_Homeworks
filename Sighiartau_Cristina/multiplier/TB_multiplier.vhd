library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_multiplier is
--  Port ( );
end TB_multiplier;

architecture Behavioral of TB_multiplier is

component multiplier is
Port(clk: in std_logic;
X, Y: in std_logic_vector(3 downto 0);
result: out std_logic_vector(7 downto 0);
done: out std_logic);
end component;

signal A, B: std_logic_vector(3 downto 0);
signal R: std_logic_vector(7 downto 0);
signal clk, done: std_logic;

begin
map1: multiplier port map (clk=>clk, X=>A, Y=>B, result=>R, done=>done);

process
begin
clk<='0';
A<="1001";
B<="1100";
wait for 10ns;
clk<='1';
wait for 10 ns;
clk<='0';
wait for 10 ns;

clk<='1';
wait for 10 ns;
clk<='0';
wait for 10 ns;

clk<='1';
wait for 10 ns;
clk<='0';
wait for 10 ns;

clk<='1';
wait for 10 ns;
clk<='0';
wait for 10 ns;

clk<='1';
wait for 10 ns;
clk<='0';
wait for 10 ns;

clk<='1';
wait for 10 ns;
clk<='0';
wait for 10 ns;

clk<='1';
wait for 10 ns;
clk<='0';
wait for 10 ns;

clk<='1';
wait for 10 ns;
clk<='0';
wait for 10 ns;

clk<='1';
wait for 10 ns;
clk<='0';
wait for 10 ns;

clk<='1';
wait for 10 ns;
clk<='0';
wait for 10 ns;

clk<='1';
wait for 10 ns;
clk<='0';
wait for 10 ns;

clk<='1';
wait for 10 ns;
clk<='0';
wait for 10 ns;

clk<='1';
wait for 10 ns;
clk<='0';
wait for 10 ns;

clk<='1';
wait for 10 ns;
clk<='0';

wait;
end process;


end Behavioral;
