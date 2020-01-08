library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- componenta de baza din Decode Circuit

entity decoder is
port(
	input: in std_logic_vector(2 downto 0);	-- A, B, C
	e_1: in std_logic;
	e_2: in std_logic;
	e_3: in std_logic;
	output: out std_logic_vector(7 downto 0)
);
end decoder;

architecture Behavioral of decoder is
begin

	process(input, e_1, e_2, e_3)
	begin
		output <= "11111111";	-- all bits are initially '1' (deactivated) (no signal active)
		if (e_1 = '0' AND e_2 = '0' AND e_3 = '1') then  -- active high enable pin
			  case input is
					when "000" => output(7) <= '0';	-- '0' because selections are active on 0
					when "001" => output(6) <= '0';
					when "010" => output(5) <= '0';
					when "011" => output(4) <= '0';
					when "100" => output(3) <= '0';
					when "101" => output(2) <= '0';
					when "110" => output(1) <= '0';
					when others => output(0) <= '0';
			  end case;
		 end if;
	end process;

end Behavioral;