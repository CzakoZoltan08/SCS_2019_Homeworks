library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity fifo_module is
  Port (rd : in std_logic;
        data_in : in std_logic_vector(7 downto 0);
        wr : in std_logic;
        rst : in std_logic;
        clk : in std_logic;
        data_out : out std_logic_vector(7 downto 0);
        empty: out std_logic;
        full: out std_logic);
end fifo_module;

architecture Behavioral of fifo_module is
begin

	process (CLK)
		type FIFO_Memory is array (0 to 7) of STD_LOGIC_VECTOR (7 downto 0);
		variable Fifo_Mem : FIFO_Memory;
		variable Wrptr : integer range 0 to 7;
		variable Rdptr : integer range 0 to 7;
		variable Looped : std_logic;
	begin
	     Full<= '0';
	     Empty <= '1';
		if rising_edge(CLK) then
			if RST = '1' then
				Wrptr := 0;
				Rdptr := 0;
				Looped := '0';
				Full  <= '0';
				Empty <= '1';
				Data_Out <= Fifo_Mem(Rdptr);
				
			else
				if (rd = '1') then
					if ((Looped = '1') or (Wrptr /= Rdptr)) then
						Data_Out <= Fifo_Mem(Rdptr);
						if (Rdptr = 7) then
							Rdptr := 0;
							Looped := '0';
						else
							Rdptr := Rdptr + 1;
						end if;
					end if;
				end if;
				
				if (wr = '1') then
					if ((Looped = '0') or (Wrptr /= Rdptr)) then
						Fifo_Mem(Wrptr) := Data_In;
						if (Wrptr = 7) then
							Wrptr := 0;
							Looped := '1';
						else
							Wrptr := Wrptr + 1;
						end if;
					end if;
				end if;
				if (Wrptr = Rdptr) then
					if Looped = '1' then
						Full <= '1';
					else
						Empty <= '1';
					end if;
				else
					Empty	<= '0';
					Full	<= '0';
				end if;
			end if;
		end if;
	end process;
end Behavioral;

