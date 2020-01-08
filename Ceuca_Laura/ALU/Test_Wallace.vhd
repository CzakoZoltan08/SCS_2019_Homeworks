library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Test_Wallace is
end Test_Wallace;

architecture Behavioral of Test_Wallace is

component WallaceTree is
    port(
    a,b: in std_logic_vector(3 downto 0);
    product: out std_logic_vector(7 downto 0)
    );
end component;

signal a,b: std_logic_vector(3 downto 0);
signal c: std_logic_vector(7 downto 0);

begin

wall: WallaceTree
        port map(a=>a, b=>b, product=>c);

process
begin
    a<= "0100";
    b<= "0011";
    wait for 100ns;
end process;

end Behavioral;
