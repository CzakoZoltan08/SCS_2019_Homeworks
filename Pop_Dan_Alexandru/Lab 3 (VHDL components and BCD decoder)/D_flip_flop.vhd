library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity D_flip_flop is
port(input_data: in std_logic;
	  enable: in std_logic;
	  clk: in std_logic;
	  output: out std_logic);
end D_flip_flop;

architecture Behavioral of D_flip_flop is
begin

process(clk, enable)
begin
	if rising_edge(clk) then
		if enable = '1' then
			output <= input_data;
		end if;
	end if;
end process;

end Behavioral;