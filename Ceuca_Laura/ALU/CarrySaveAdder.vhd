library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 
entity CarrySaveAdder is
generic (n: integer := 4);
Port ( a : in STD_LOGIC_VECTOR (3 downto 0);
       b : in STD_LOGIC_VECTOR (3 downto 0);
       c : in STD_LOGIC_VECTOR (3 downto 0);
       s : OUT STD_LOGIC_VECTOR (4 downto 0);
       cout : OUT STD_LOGIC);
end CarrySaveAdder;
 
architecture Behavioral of CarrySaveAdder is
 
component FullAdder is
port (a, b, cin: in std_logic;
       s, cout: out std_logic);
end component;

component RippleCarryAdder is
generic (n: integer := 4);
    port (a, b: in std_logic_vector(n-1 downto 0);
        cin: in std_logic;
        s: out std_logic_vector(n-1 downto 0);
        cout: out std_logic);
end component;
 
signal x,y: STD_LOGIC_VECTOR(3 downto 0);
 
begin

MAP_FIRST: FullAdder port map (a => a(0),b => b(0),cin => c(0),s => s(0),cout => x(0));
GEN_ADDERS: for I in 1 to n-1 generate
      MAP_ADDERS: FullAdder 
      port map (a => a(I),b => b(I),cin => c(I),s => y(I-1),cout => x(I));   
 end generate GEN_ADDERS;
 y(3) <= '0';

FINAL_SUM: RippleCarryAdder
    generic map ( n => 4)
        port map (a => x, b => y, cin => '0', s => s(4 downto 1),cout => cout);
  
end Behavioral;
