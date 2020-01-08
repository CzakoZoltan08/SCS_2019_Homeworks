library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debounce_filter is
    Port ( d_in : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           q_out : out  STD_LOGIC);
end debounce_filter;

architecture Behavioral of debounce_filter is

--  Provides a one-shot pulse from a non-clock input, with reset
--**Insert the following between the 'architecture' and
---'begin' keywords**
signal Q1, Q2, Q3 : std_logic;

begin

--**Insert the following after the 'begin' keyword**
process(clk)
begin
   if (clk'event and clk = '1') then
      if (rst = '1') then
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