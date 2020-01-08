
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_static_memory is
--  Port ( );
end TB_static_memory;

architecture Behavioral of TB_static_memory is


component static_memory is
Port (
rd: in std_logic;
wr: in std_logic;
address: in std_logic_vector (23 downto 0);
data_in: in std_logic_vector(7 downto 0);
data_out: out std_logic_vector(15 downto 0)
);
end component;

signal rd, wr: std_logic;
signal address: std_logic_vector(23 downto 0);
signal data_in: std_logic_vector(7 downto 0);
signal data_out: std_logic_vector(15 downto 0);

begin

map1: static_memory port map (rd, wr, address, data_in, data_out);

process
begin


wr<='1';
rd<='0';
address<= "110000000000000000000011";
wait for 15 ns;

data_in <= x"99";
wr<='0';
rd<='0';
address<= "110000000000000000000011";
wait for 15 ns;

wr<='1';
rd<='0';
address<= "110000000000000000000011";
wait for 15 ns;

wr<='1';
rd<='0';
address<= "110001000000000000000011";
wait;
end process;

end Behavioral;
