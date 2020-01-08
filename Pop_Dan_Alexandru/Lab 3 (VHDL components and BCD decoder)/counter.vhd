library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

entity counter is
port (enable: in std_logic;
		clk: in std_logic;
		count: out std_logic_vector(3 downto 0));
end counter;

architecture Behavioral of counter is
signal temp: std_logic_vector(3 downto 0);
begin

process(clk, enable)
begin
	if rising_edge(clk) then
		if enable = '1' then
			temp <= temp + 1;
		end if;
	end if;
end process;

count <= temp;

end Behavioral;