library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fifoMemory is
  Port (data_in : in std_logic_vector(7 downto 0);
        rd : in std_logic; 
        wr : in std_logic; 
        clk, rst : in std_logic;
        empty, full : out std_logic;
        data_out : inout std_logic_vector(7 downto 0);
        sseg : out std_logic_vector(6 downto 0);
        an : out std_logic_vector(3 downto 0) );
end fifoMemory;

architecture Behavioral of fifoMemory is

component fifoControl is
  Port (data_in : in std_logic_vector(7 downto 0);
        rd : in std_logic;
        wr : in std_logic;
        wrinc : in std_logic;
        rdinc : in std_logic;
        rst : in std_logic;
        clk : in std_logic;
        data_out : out std_logic_vector(7 downto 0) );
end component;

component displ_7seg is
	port ( clk, rst : in std_logic;
		    data : in std_logic_vector (15 downto 0);
		    sseg : out std_logic_vector (6 downto 0);
		    an : out std_logic_vector (3 downto 0));
end component;

signal dataDisplay : std_logic_vector(15 downto 0);

begin

        
dataDisplay <= data_in & data_out;

fifoControlComponent: fifoControl port map (data_in, rd, wr, rd, wr, clk, rst, data_out);
        
SevenSegmentDisplay: displ_7seg port map (clk, rst, dataDisplay, sseg, an);

        
end Behavioral;

