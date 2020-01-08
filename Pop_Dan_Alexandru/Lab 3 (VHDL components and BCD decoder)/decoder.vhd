library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder is
port (select_bits: in std_logic_vector(2 downto 0);
		output: out std_logic_vector(8 downto 0));
end decoder;
-- 3 to 8 Decoder
architecture Behavioral of decoder is
begin

process(select_bits)
begin
	case select_bits is
		when "000" => output <= "00000001";
		when "001" => output <= "00000010";
		when "010" => output <= "00000100";
		when "011" => output <= "00001000";
		when "100" => output <= "00010000";
		when "101" => output <= "00100000";
		when "110" => output <= "01000000";
		when others => output <= "10000000";
	end case;
end process;

end Behavioral;