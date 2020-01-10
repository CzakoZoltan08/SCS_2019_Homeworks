library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity filter is
  Port (
    clk:in std_logic;
    reset:in std_logic;
    d_in:in std_logic;
    q_out:out std_logic
  
  
   );
end filter;

architecture Behavioral of filter is
signal Q1, Q2, Q3:std_logic;
begin



process(clk)
begin
   if (clk'event and clk = '1') then
      if (reset = '1') then
         Q1 <= '0';
         Q2 <= '0';
         Q3 <= '0';
      else
         Q1 <= D_IN;
         Q2 <= Q1;
         Q3 <= Q2;
      end if;
   end if;
end process;

Q_OUT <= Q1 and Q2 and (not Q3);

end Behavioral;
				
				