
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Test_Multiplier is
end Test_Multiplier;

architecture Behavioral of Test_Multiplier is

component Multiplication is
    Port(a,b: in STD_LOGIC_VECTOR(3 downto 0);
         product : out STD_LOGIC_VECTOR(7 downto 0));
end component;

signal a,b: std_logic_vector(3 downto 0);
signal product: std_logic_vector(7 downto 0);

begin

test_mult: Multiplication
        port map(a=>a, b=>b, product => product);

process
begin
    a<= "0100";
    b<= "0011";
    wait for 100ns;
end process;

end Behavioral;
