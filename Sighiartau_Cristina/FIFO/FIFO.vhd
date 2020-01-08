library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity FIFO is
Port(
data_in:in std_logic_vector(7 downto 0);
rd_btn, wr_btn, rst, clk: in std_logic;
anode : out std_logic_vector (3 downto 0);
empty_out, full_out: out std_logic;
cat : out std_logic_vector (6 downto 0)
);
end FIFO;

architecture Behavioral of FIFO is

component SSD is
    Port ( digit : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           cat : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component debouncer is
Port(clk: in std_logic;
rst, d_in: in std_logic;
q_out: out std_logic);
end component;

signal rdinc, wrinc: std_logic_vector(3 downto 0);
signal data_fifo_out: std_logic_vector(7 downto 0);
signal data_out: std_logic_vector(15 downto 0);
signal rd, wr: std_logic;
type fifo_type is array (0 to 7) of std_logic_vector(7 downto 0);
signal empty, full: std_logic;
signal fifo: fifo_type;

begin

deb1: debouncer port map(clk, rst, rd_btn, rd);
deb2: debouncer port map(clk, rst, wr_btn, wr);
ssdm: ssd port map(data_out, clk, cat, anode);

empty_out<=empty;
full_out<=full;

fifo_ctrl: process(clk, rd, wr, rst)
begin
    if rst='1' then
        rdinc<="0000";
        wrinc<="0000";
    end if;
    if clk'event and clk='1' then
        if rd='1' then 
            fifo(conv_integer(rdinc(2 downto 0))) <= data_in;
            rdinc<=rdinc + "0001";
        elsif wr='1' then
            data_fifo_out <= fifo(conv_integer(wrinc(2 downto 0)));
            wrinc<=wrinc + "0001";
        else
           data_fifo_out <= "ZZZZZZZZ";
        end if;
        if rdinc(2 downto 0)=wrinc(2 downto 0) then
            empty<= wrinc(3) xnor rdinc(3);
            full<= wrinc(3) xor rdinc(3);
        else
            empty<='0';
            full<='0';
        end if;
    end if;
end process;

ssd_proc: process(clk, rst)
begin
    if clk'event and clk='1' then
        data_out<= data_in & data_fifo_out;
    end if;
end process;

end Behavioral;
