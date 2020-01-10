library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fifoTest is
end fifoTest;

architecture Behavioral of fifoTest is
component fifoMemory is
  Port (data_in : in std_logic_vector(7 downto 0);
        rd, wr, clk, rst : in std_logic;
        empty, full : out std_logic;
        data_out : inout std_logic_vector(7 downto 0);
        sseg : out std_logic_vector(6 downto 0);
        an : out std_logic_vector(3 downto 0) );
end component;
signal data_in :  std_logic_vector(7 downto 0);
signal     rd, wr, clk, rst :  std_logic;
signal     empty, full :  std_logic;
signal    data_out :  std_logic_vector(7 downto 0);
signal    sseg :  std_logic_vector(6 downto 0);
signal   an :  std_logic_vector(3 downto 0);

begin
 fifoPortL: fifoMemory port map(data_in, rd, wr, clk, rst,empty, full, data_out, sseg, an);


clockProcess :process
  begin
  clk<= '0';
  wait for 5ns;
  clk <= '1';
  wait for 5ns;
 end process;
 
 simulationProcess: process
    begin
    wr <= '1';
    rd <= '0';
    data_in <=x"01";
    wait for 100 ns;
    wr <= '1';
    rd <= '0';
    data_in <=x"02";
    wait for 100 ns;
    wr <= '1';
    rd <= '0';
    data_in <=x"03";
    wait for 100 ns;
    rd <= '1';
    wr <= '0';
    data_in <=x"01";
    wait for 100 ns;
    rd <= '1';
    wr <= '0';
    data_in <=x"02";
    wait;
end process;

end Behavioral;
