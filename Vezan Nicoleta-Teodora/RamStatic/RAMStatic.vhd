library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity RAMStatic is
  Port (
  address: in std_logic_vector(23 downto 0);
  A: in std_logic_vector(15 downto 0);
  D: out std_logic_vector(15 downto 0);
  RD: in std_logic;
  WR: in std_logic ;
  clk: in std_logic
  );
end RAMStatic;

architecture Behavioral of RAMStatic is

component MemoryMatrix is
  Port (
  address: in std_logic_vector(16 downto 0);
  sel: in std_logic_vector(7 downto 0);
  WR: in std_logic;
  A: in std_logic_vector(15 downto 0);
  D: out std_logic_vector(15 downto 0);
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
DecoderComponent: Decoder port map (address => address(23 downto 17), RD => RD, WR => WR, sel => sel, sel_module => sel_module);
MemoryMatrixComponent: MemoryMatrix port map (address => address(16 downto 0), sel => sel, WR => WR, A => A, D => D, clk => clk);
end Behavioral;