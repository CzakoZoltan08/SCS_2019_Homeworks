library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity static_memory is
Port (
rd: in std_logic;
wr: in std_logic;
address: in std_logic_vector (23 downto 0);
data_in: in std_logic_vector(7 downto 0);
data_out: out std_logic_vector(15 downto 0)
);
end static_memory;

architecture Behavioral of static_memory is

component memory_matrix is
Port (
address_bus: in std_logic_vector(16 downto 0);
wr:in std_logic;
sel: in std_logic_vector(7 downto 0);
bhe: in std_logic;
data_in: in std_logic_vector(7 downto 0);
data_out: out std_logic_vector(15 downto 0));
end component;

component decoder_circuit is
Port (
address_bus: in std_logic_vector(6 downto 0);
wr:in std_logic;
rd: in std_logic;
sel_module: out std_logic;
sel: out std_logic_vector(7 downto 0));
end component;

signal sel_module: std_logic;
signal sel: std_logic_vector(7 downto 0);

begin

map1: decoder_circuit port map (address(23 downto 17), wr, rd, sel_module, sel);
map2: memory_matrix port map (address(16 downto 0), wr, sel,address(17), data_in, data_out);

end Behavioral;
