library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity RippleCarryAdder is
generic (n: integer := 4);
    port (a, b: in std_logic_vector(n-1 downto 0);
        cin: in std_logic;
        s: out std_logic_vector(n-1 downto 0);
        cout: out std_logic);
end RippleCarryAdder;



architecture Behavioral of RippleCarryAdder is

signal intermediate_carry_out: std_logic_vector(n downto 0);

component FullAdder is
port (a, b, cin: in std_logic;
       s, cout: out std_logic);
end component;

begin

GEN_ADDERS: for I in 0 to n-1 generate
      MAP_ADDERS: FullAdder 
      port map (a(I), b(I), intermediate_carry_out(I), s(I), intermediate_carry_out(I+1));   
 end generate GEN_ADDERS;
 
 intermediate_carry_out(0) <= cin;
 cout <= intermediate_carry_out(n);

end Behavioral;
