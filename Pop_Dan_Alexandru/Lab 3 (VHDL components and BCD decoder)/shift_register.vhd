library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity shift_register is
port(clk: in std_logic;
	  enable: in std_logic;
	  input: in std_logic;
	  output: out std_logic);
end shift_register;

architecture Behavioral of shift_register is
signal tmp: std_logic_vector (7 downto 0);
begin

process(clk)
begin
	if (clk'event and clk = '1') then
		if (enable = '1') then
			for i in 0 to 3 loop
				tmp(i+1) <= tmp(i);
			end loop;
			
			tmp(0) <= input;
		end if;
	end if;
end process;

output <= tmp(7);

end Behavioral;