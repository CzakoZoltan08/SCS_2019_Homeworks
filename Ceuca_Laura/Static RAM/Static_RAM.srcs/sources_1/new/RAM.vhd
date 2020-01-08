library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RAM is
  Port (
  address: in std_logic_vector(23 downto 0);
  data_in: in std_logic_vector(15 downto 0);
  data_out: out std_logic_vector(15 downto 0);
  RD: in std_logic;
  WR: in std_logic ;
  clk: in std_logic
  );
end RAM;

architecture Behavioral of RAM is

component MemoryMatrix is
  Port (
  address: in std_logic_vector(16 downto 0);
  sel: in std_logic_vector(7 downto 0);
  WR: in std_logic;
  data_in: in std_logic_vector(15 downto 0);
  data_out: out std_logic_vector(15 downto 0);
  clk: in std_logic
  );
end component;

component Decoder is
  Port (
  address: in std_logic_vector(23 downto 17);
  RD: in std_logic;
  WR: in std_logic;
  sel: out std_logic_vector(7 downto 0);
  sel_module: out std_logic
  );
end component;

signal sel_module: std_logic;
signal sel: std_logic_vector(7 downto 0);

begin

Dec: Decoder port map (address => address(23 downto 17), RD => RD, WR => WR, sel => sel, sel_module => sel_module);
Mem_Mat: MemoryMatrix port map (address => address(16 downto 0), sel => sel, WR => WR, data_in => data_in, data_out => data_out, clk => clk);

end Behavioral;