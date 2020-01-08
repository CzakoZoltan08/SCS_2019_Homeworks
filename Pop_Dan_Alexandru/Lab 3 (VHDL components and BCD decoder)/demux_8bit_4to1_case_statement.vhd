library IEEE;
use IEEE.STD_LOGIC_1164.all;
 
entity demux_8bit_4to1_case_stetement is
port (input_data : in STD_LOGIC_VECTOR(7 downto 0);
  	   selection_bits: in STD_LOGIC_VECTOR(1 downto 0);
	   A, B, C, D: out STD_LOGIC_VECTOR(7 downto 0));
end demux_8bit_4to1_case_stetement;
 
architecture Behavioral of demux_8bit_4to1_case_stetement is
begin

process (input_data, selection_bits) is
begin
	case (selection_bits) is
		when "00" => A <= input_data;
		when "10" => B <= input_data;
		when "01" => C <= input_data;
		when others => D <= input_data;
	end case;
end process;

end Behavioral;