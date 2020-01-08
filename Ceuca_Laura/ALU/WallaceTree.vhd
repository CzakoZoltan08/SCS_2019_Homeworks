library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity WallaceTree is
    port(
    a,b: in std_logic_vector(3 downto 0);
    product: out std_logic_vector(7 downto 0)
    );
end WallaceTree;

architecture Behavioral of WallaceTree is

component FullAdder is
port (a, b, cin: in std_logic;
       s, cout: out std_logic);
end component;

signal s_internal: std_logic_vector(15 downto 0);
signal c_internal: std_logic_vector(15 downto 0);
signal p0,p1,p2,p3 : std_logic_vector(6 downto 0);

begin

process(a,b)
begin
    for i in 0 to 3 loop
        p0(i) <= a(i) and b(0);
        p1(i) <= a(i) and b(1);
        p2(i) <= a(i) and b(2);
        p3(i) <= a(i) and b(3);
    end loop;       
end process;
    
ha11 : FullAdder port map(a => p0(1), b => p1(0), cin => '0', s => s_internal(0),cout => c_internal(0));
fa12 : FullAdder port map(a=> p0(2),b => p1(1),cin => p2(0),s => s_internal(1),cout => c_internal(1));
fa13 : FullAdder port map(a => p0(3),b => p1(2),cin => p2(1),s => s_internal(2),cout => c_internal(2));
fa14 : FullAdder port map(a => p1(3),b => p2(2),cin => p3(1),s => s_internal(3),cout => c_internal(3));
ha15 : FullAdder port map(a => p2(3),b => p3(2), cin=> '0', s => s_internal(4),cout => c_internal(4));

ha22 : FullAdder port map(a => c_internal(0),b => s_internal(1), cin => '0', s => s_internal(5), cout => c_internal(5));
fa23 : FullAdder port map(a => p3(0),b => c_internal(1),cin => s_internal(2),s => s_internal(6),cout => c_internal(6));
fa24 : FullAdder port map(a => c_internal(2),b => c_internal(10),cin => s_internal(3),s => s_internal(7),cout => c_internal(7));
fa25 : FullAdder port map(a => c_internal(3),b => c_internal(7),cin => s_internal(4),s => s_internal(8),cout => c_internal(8));
fa26 : FullAdder port map(a => c_internal(4),b => c_internal(8),cin => p3(3),s => s_internal(9),cout => c_internal(9));

ha32 : FullAdder port map(a => c_internal(5),b => s_internal(5),cin => '0', s => s_internal(10), cout => c_internal(10));
ha34 : FullAdder port map(a => c_internal(6),b => s_internal(7),cin => '0', s => s_internal(12),cout => c_internal(12));
ha35 : FullAdder port map(a => c_internal(12),b => s_internal(8),cin => '0', s => s_internal(13),cout => c_internal(13));
ha36 : FullAdder port map(a => c_internal(13),b => s_internal(9),cin => '0', s => s_internal(14),cout => c_internal(14));
ha37 : FullAdder port map(a => c_internal(14),b => c_internal(9),cin => '0', s=> s_internal(15),cout => c_internal(15));

product(0) <= p0(0);
product(1) <= s_internal(0);
product(2) <= s_internal(5);
product(3) <= s_internal(10);
product(4) <= s_internal(12);
product(5) <= s_internal(13);
product(6) <= s_internal(14);
product(7) <= s_internal(15);

end Behavioral;
