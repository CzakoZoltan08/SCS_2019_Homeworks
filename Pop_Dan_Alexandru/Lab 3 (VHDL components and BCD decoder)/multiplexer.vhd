library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity multiplexer is
port (input: in std_logic_vector(3 downto 0);
		selection_bits: in std_logic_vector(1 downto 0);
		output: out std_logic);
end multiplexer;

architecture Behavioral of multiplexer is
begin

process(selection_bits, input)
begin
	case selection_bits is
		when "00" => output <= input(3);
		when "01" => output <= input(2);
		when "10" => output <= input(1);
		when others => output <= input(0);
	end case;
end process;

end Behavioral;