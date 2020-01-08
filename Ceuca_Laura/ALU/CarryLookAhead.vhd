library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity CarryLookAhead is
generic (n: integer := 4);
    port (a, b: in std_logic_vector(n-1 downto 0);
        cin: in std_logic;
        s: out std_logic_vector(n-1 downto 0);
        cout: out std_logic);
end CarryLookAhead;

architecture Behavioral of CarryLookAhead is

signal intermediate_carry_out: std_logic_vector(n downto 0);
signal g,p: std_logic_vector(n-1 downto 0);
signal c: std_logic_vector(n downto 0);

component FullAdder is
port (a, b, cin: in std_logic;
       s, cout: out std_logic);
end component;

begin

GEN_ADDERS: for I in 0 to n-1 generate
      MAP_ADDERS: FullAdder 
      port map (a => a(I),b => b(I),cin => c(I),s => s(I),cout => intermediate_carry_out(I));   
 end generate GEN_ADDERS;

 process(a,b,cin,g,p,c)
 begin
    c(0) <= cin;
    for k in 0 to n-1 loop
        p(k) <= a(k) or b(k);
        g(k) <= a(k) and b(k);
        c(k+1) <= g(k) or (p(k) and c(k));
    end loop;       
 end process;
 
  cout <= c(n);

end Behavioral;
