
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Test_RippleCarry is
end Test_RippleCarry;

architecture Behavioral of Test_RippleCarry is

component RippleCarryAdder is
generic (n: integer := 4);
    port (a, b: in std_logic_vector(n-1 downto 0);
        cin: in std_logic;
        s: out std_logic_vector(n-1 downto 0);
        cout: out std_logic);
end component;

signal a,b,s: std_logic_vector(3 downto 0);
signal cin, cout: std_logic;

begin

sim1: RippleCarryAdder 
    generic map(n => 4)
        port map(a=>a,b=>b,cin=>cin,cout=>cout,s=>s);

process
begin
    a<= "0001";
    b<= "0011";
    cin <= '1';
    wait for 100ns;
end process;

end Behavioral;
