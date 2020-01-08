library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity submodule is
Port (
address_bus: in std_logic_vector(16 downto 0);
wr:in std_logic;
sel: in std_logic;
bhe: in std_logic;
data_in: in std_logic_vector(7 downto 0);
data_out: out std_logic_vector(15 downto 0));
end submodule;

architecture Behavioral of submodule is

component basic_memory_circuit is
Port (
address_bus: in std_logic_vector(15 downto 0);
cs: in std_logic;
wr: in std_logic;
data_in: in std_logic_vector(7 downto 0);
data_out: out std_logic_vector(7 downto 0)
 );
end component;

signal seliL, seliH: std_logic;
signal data_out_low, data_out_high: std_logic_vector(7 downto 0);

begin

low_lodule: basic_memory_circuit port map(address_bus(16 downto 1), seliL, wr, data_in, data_out_low);
high_lodule: basic_memory_circuit port map(address_bus(16 downto 1), seliH, wr, data_in, data_out_high);

seliL <= sel or address_bus(0);
seliH <= sel or bhe;

data_out<= data_out_high & data_out_low; 

end Behavioral;
