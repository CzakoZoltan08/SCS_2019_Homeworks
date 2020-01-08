library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity fifo_top is
  Port (data_in : in std_logic_vector(7 downto 0);
        btn_rd, btn_wr, clk, rst : in std_logic;
        empty, full : out std_logic;
        sseg : out std_logic_vector(6 downto 0);
        an : out std_logic_vector(3 downto 0) );
end fifo_top;

architecture Behavioral of fifo_top is

component fifo_module is
  Port (rd : in std_logic;
        data_in : in std_logic_vector(7 downto 0);
        wr : in std_logic;
        rst : in std_logic;
        clk : in std_logic;
        data_out : out std_logic_vector(7 downto 0);
        empty: out std_logic;
        full: out std_logic );
end component;

component displ_7seg is
	port ( clk, rst : in std_logic;
		    data : in std_logic_vector (15 downto 0);
		    sseg : out std_logic_vector (6 downto 0);
		    an : out std_logic_vector (3 downto 0));
end component;

component MPG is
port (  clk : in STD_LOGIC;
        inp : in STD_LOGIC;
        oup : out STD_LOGIC);
end component;

signal rd, wr : std_logic;
signal data_seg : std_logic_vector(15 downto 0);
signal data_out : std_logic_vector(7 downto 0);
begin

debounceRd:mpg port map(clk => clk, inp => btn_rd, oup => rd);
doubounceWr: mpg port map(clk=>clk, inp => btn_wr, oup => wr);

fifoMap: fifo_module port map (data_in => data_in, rd => rd, wr => wr, clk => clk, rst => rst, data_out => data_out, empty => empty, full => full);     
segmap: displ_7seg port map (clk=>clk, rst=>rst, data => data_seg, sseg => sseg, an => an);
        
data_seg <= data_in & data_out;
        
end Behavioral;
