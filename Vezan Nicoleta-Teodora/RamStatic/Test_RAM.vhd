library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Test_RAM is
end Test_RAM;

architecture Behavioral of Test_RAM is

component RAM is
Port (
  address: in std_logic_vector(23 downto 0);
  A: in std_logic_vector(15 downto 0);
  D: out std_logic_vector(15 downto 0);
  RD: in std_logic;
  WR: inout std_logic;
  clk: in std_logic 
);
end component;

signal address: std_logic_vector(23 downto 0) := (others => '0');
signal RD: std_logic := '1';
signal WR: std_logic := '1';
signal A: std_logic_vector(15 downto 0) := (others => '0');
signal D: std_logic_vector(15 downto 0) := (others => '0');
signal clk: std_logic;

begin
map_ram: RAM port map (address => address, A => A, D => D, RD => RD, WR => WR, clk => clk);

 clockP :process
  begin
  clk<= '0';
  wait for 5 ns;
  clk <= '1';
  wait for 5 ns;
  end process;

  simulationP: process
  begin 
  
  -- READ 
  WR <= '1'; 
  RD <= '0';
  address <= B"0000000001_0000000001_0001"; 
  wait for 100 ns; 
    
  -- READ 
  WR <= '1'; 
  RD <= '0';
  address <= B"1000001000_1000000001_1001"; 
  wait for 100 ns;

  -- WRITE
  address <= B"0000000001_0000000001_0001";
  A <= x"0102";
  WR <= '0';
  RD <= '1';
  wait for 100 ns;
  
   -- WRITE
  A <= x"1204";
  address <= B"1000001000_1000000001_1001";
  WR <= '0';
  RD <= '1';
  wait for 100 ns;
  
-- READ 
  address <= B"0000000001_0000000001_0001"; 
  WR <= '1'; 
  RD <= '0';
  wait for 100 ns; 
    
  -- READ 
  WR <= '1'; 
  RD <= '0';
  address <= B"1000001000_1000000001_1001"; 
  wait;

  
  end process;
end Behavioral;
