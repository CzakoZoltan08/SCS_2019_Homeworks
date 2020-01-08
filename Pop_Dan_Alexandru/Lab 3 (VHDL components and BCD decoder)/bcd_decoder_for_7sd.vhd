library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity bcd_decoder_for_7sd is
port (clk : in std_logic;
      bcd : in std_logic_vector(3 downto 0);
      out_to_7sd : out std_logic_vector(6 downto 0)); -- output decoded on 7 bits
end bcd_decoder_for_7sd;

architecture Behavioral of bcd_decoder_for_7sd is
begin

process (clk, bcd)
begin
	if (rising_edge(clk)) then
		case bcd is
											--  gfedcba
			when "0001"=> out_to_7sd <="1111001";  -- 1
			when "0010"=> out_to_7sd <="0100100";  -- 2
			when "0011"=> out_to_7sd <="0110000";  -- 3
			when "0100"=> out_to_7sd <="0011001";  -- 4 
			when "0101"=> out_to_7sd <="0010010";  -- 5
			when "0110"=> out_to_7sd <="0000010";  -- 6
			when "0111"=> out_to_7sd <="1111000";  -- 7
			when "1000"=> out_to_7sd <="0000000";  -- 8
			when "1001"=> out_to_7sd <="0010000";  -- 9
			when "1010"=> out_to_7sd <="0001000";  -- A
			when "1011"=> out_to_7sd <="0000011";  -- B
			when "1100"=> out_to_7sd <="1000110";  -- C
			when "1101"=> out_to_7sd <="0100001";  -- D
			when "1110"=> out_to_7sd <="0000110";  -- E
			when "1111"=> out_to_7sd <="0001110";  -- F
			when others=> out_to_7sd <="1000000"; -- 0
		end case;
	end if;

end process;

end Behavioral;