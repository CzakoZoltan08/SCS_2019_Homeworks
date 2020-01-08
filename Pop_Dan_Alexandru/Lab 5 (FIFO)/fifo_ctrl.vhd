library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use ieee.std_logic_unsigned.all;
use IEEE.STD_LOGIC_ARITH.ALL;

entity fifo_ctrl is
    Port ( rd : in  STD_LOGIC;
           wr : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           rd_inc : out  STD_LOGIC;
           wr_inc : out  STD_LOGIC;
           empty : out  STD_LOGIC;
           full : out  STD_LOGIC);
end fifo_ctrl;

architecture Behavioral of fifo_ctrl is

begin

process(clk)
begin
	if (clk'event and clk = '1') then
		rd_inc <= rd OR '1';		-- RD + 1
		wr_inc <= wr OR '1';		-- WR + 1
	end if;
end process;

end Behavioral;