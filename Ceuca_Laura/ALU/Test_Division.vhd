
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Test_Division is
end Test_Division;

architecture Behavioral of Test_Division is

component Division is
    Port(x,y: in STD_LOGIC_VECTOR(3 downto 0);
         quot, r : out STD_LOGIC_VECTOR(3 downto 0));
end component;


signal x,y: std_logic_vector(3 downto 0);
signal q,r: std_logic_vector(3 downto 0);

begin

test_div: Division
        port map(x => x, y=> y, quot => q, r =>r);

process
begin
    x <= "1101";
    y <= "0101";
    wait for 100ns;
end process;

end Behavioral;
