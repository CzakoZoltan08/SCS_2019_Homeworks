library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity simple_register is
port(input: in std_logic;
	  enable: in std_logic;
	  clk: in std_logic;
	  output: out std_logic);
end simple_register;

architecture Behavioral of simple_register is
begin

process(clk, enable)
begin
	if (rising_edge(clk) and enable='1') then
		output <= input;
	end if;
end process;

end Behavioral;