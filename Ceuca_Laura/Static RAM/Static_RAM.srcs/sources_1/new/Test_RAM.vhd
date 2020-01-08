library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Test_RAM is
end Test_RAM;

architecture Behavioral of Test_RAM is

component RAM is
Port (
  address: in std_logic_vector(23 downto 0);
  data_in: in std_logic_vector(15 downto 0);
  data_out: out std_logic_vector(15 downto 0);
  RD: in std_logic;
  WR: inout std_logic;
  clk: in std_logic 
);
end component;

signal address: std_logic_vector(23 downto 0) := (others => '0');
signal RD: std_logic := '1';
signal WR: std_logic := '1';
signal data_in: std_logic_vector(15 downto 0) := (others => '0');
signal data_out: std_logic_vector(15 downto 0) := (others => '0');
signal clk: std_logic;

constant clock_period : time := 10 ns;

begin
map_ram: RAM port map (address => address, data_in => data_in, data_out => data_out, RD => RD, WR => WR, clk => clk);

  clk_process :process
  begin
  clk<= '0';
  wait for clock_period/2;
  clk <= '1';
  wait for clock_period/2;
  end process;

  stim_proc: process
  begin 
  
  -- READ 
  WR <= '1'; 
  RD <= '0';
  address <= x"C00004"; 
  wait for 100 ns; 

  -- WRITE
  address <= x"C00004";
  data_in <= x"4321";
  WR <= '0';
  RD <= '1';
  wait for 100 ns;
  
  -- READ
  WR <= '1'; 
  RD <= '0';
  address <= x"C00004";
  wait;
  
  end process;
end Behavioral;
