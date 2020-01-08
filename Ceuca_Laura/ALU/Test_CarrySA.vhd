
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Test_CarrySA is
end Test_CarrySA;

architecture Behavioral of Test_CarrySA is

component CarrySaveAdder is
generic (n: integer := 4);
Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
       b : in STD_LOGIC_VECTOR (3 downto 0);
       c : in STD_LOGIC_VECTOR (3 downto 0);
       s : OUT STD_LOGIC_VECTOR (4 downto 0);
       cout : OUT STD_LOGIC);
end component;

signal a,b,c: std_logic_vector(3 downto 0);
signal cout: std_logic;
signal s: std_logic_vector(4 downto 0);

begin

sim1: CarrySaveAdder
    generic map(n => 4)
        port map(a=>a, b=>b, c=>c, cout=>cout, s=>s);

process
begin
    a<= "0100";
    b<= "0011";
    c <= "0101";
    wait for 100ns;
end process;

end Behavioral;
