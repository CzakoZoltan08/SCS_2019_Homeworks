LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
USE work.procmem_definitions.ALL;
entity pc is
	port 
	(
		clk    : in STD_ULOGIC;
		rst_n  : in STD_ULOGIC;
		pc_in  : in STD_ULOGIC_VECTOR(width - 1 DOWNTO 0);
		pc_en  : in STD_ULOGIC;
		pc_out : out STD_ULOGIC_VECTOR(width - 1 DOWNTO 0);
		en : in std_logic
	);
end pc;

architecture Behavioural of pc is
begin

process(clk, rst_n)
	variable pc_temp : STD_ULOGIC_VECTOR(width - 1 DOWNTO 0);
	begin
		if rst_n = '0' then
			pc_temp := (others => '0');
		ELSIF RISING_EDGE(clk) THEN
		  IF en = '1' THEN
			IF pc_en = '1' THEN
				pc_temp := pc_in;
			END IF;
		  end if;
		END IF;
		pc_out <= pc_temp;
end process;

end Behavioural;