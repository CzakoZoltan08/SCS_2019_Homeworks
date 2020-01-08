library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- memorie RAM (continuta intr-un submodul)

entity base_mem_8bits is
port(
	address: in std_logic_vector(15 downto 0);
	chip_select: in std_logic;		-- activ pe '0' == ENABLE
	wr: in std_logic;					-- activ pe '0'
	--clk: in std_logic;
	data: inout std_logic_vector(7 downto 0));
end base_mem_8bits;

architecture Behavioral of base_mem_8bits is

--(0 to 4GB) == (0 to 2**32-1)
type ram_type is array (0 to 255) of std_logic_vector (7 downto 0);
signal RAM: ram_type := (       -- declararea unui semnal de tipul 'ram_type' si INITIALIZAREA (pentru a se afisa valori)
	"00000001",
	"00000010",
	"00000101",
	others => "00000000"
);
	 
begin

process(chip_select)
begin
	if chip_select = '0' then
		if wr = '0' then
			RAM(conv_integer(address)) <= data;	-- add a 5
		else
			data <= RAM(conv_integer(address));
		end if;
		else data <= "ZZZZZZZZ";
	end if;
end process;

end Behavioral;