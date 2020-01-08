library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity complete_circuit is
    Port ( data_in : in  STD_LOGIC_VECTOR (7 downto 0);
           btn_rd : in  STD_LOGIC;
           btn_wr : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           sseg : out  STD_LOGIC_VECTOR (6 downto 0);
           anode : out  STD_LOGIC_VECTOR (3 downto 0);
           empty : out  STD_LOGIC;
           full : out  STD_LOGIC);
end complete_circuit;

architecture Behavioral of complete_circuit is

component debounce_filter is
    Port ( d_in : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           q_out : out  STD_LOGIC);
end component;

component fifo_ctrl is
    Port ( rd : in  STD_LOGIC;
           wr : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           rd_inc : out  STD_LOGIC;
           wr_inc : out  STD_LOGIC;
           empty : out  STD_LOGIC;
           full : out  STD_LOGIC);
end component;

component fifo_8x8 is
    Port ( data_in : in  STD_LOGIC_VECTOR (7 downto 0);
           rd : in  STD_LOGIC;
           wr : in  STD_LOGIC;
           rd_inc : in  STD_LOGIC;
           wr_inc : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (7 downto 0));
end component;

component displ_7seg is
	port ( clk, rst : in std_logic;
		    data : in std_logic_vector (15 downto 0);
		    sseg : out std_logic_vector (6 downto 0);
		    an : out std_logic_vector (3 downto 0));
end component;

---
component SegDisp is
Port ( 
    clk:in std_logic;
    CAT: out std_logic_vector(6 downto 0);
    AN:out std_logic_vector(3 downto 0);
    Digit0:in std_logic_vector(3 downto 0);
    Digit1:in std_logic_vector(3 downto 0);
    Digit2:in std_logic_vector(3 downto 0);
    Digit3:in std_logic_vector(3 downto 0)
);
end component;
---

signal rd: std_logic;
signal wr: std_logic;
signal rd_inc: std_logic;
signal wr_inc: std_logic;
signal data_out: std_logic_vector(7 downto 0);
signal data_out_2: std_logic_vector(15 downto 0);


signal an_output_displ_7seg : std_logic_vector (3 downto 0);
signal LED_output_hex2sseg :  STD_LOGIC_VECTOR (6 downto 0);

begin

PART1_1: debounce_filter port map (btn_rd, clk, rst, rd);
PART1_2: debounce_filter port map (btn_wr, clk, rst, wr);
PART2: fifo_ctrl port map (rd, wr, clk, rst, rd_inc, wr_inc, empty, full);
PART3: fifo_8x8 port map (data_in, rd, wr, rd_inc, wr_inc, clk, rst, data_out);

data_out_2 <= data_in & data_out;    -- data_in & data_out == data(15:8) & data(7:0)

PART4: SegDisp port map(clk => clk,
                        CAT => sseg,
                        AN => anode,
                        Digit0 => data_out_2(3 downto 0),
                        Digit1 => data_out_2(7 downto 4),
                        Digit2 => data_out_2(11 downto 8),
                        Digit3 => data_out_2(15 downto 12));
								
end Behavioral;