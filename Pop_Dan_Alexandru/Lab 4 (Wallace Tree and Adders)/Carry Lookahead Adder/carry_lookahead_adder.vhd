library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity carry_lookahead_adder is
generic (
    nr: integer := 4
);      -- componenta generica 
Port ( 
    x: in STD_LOGIC_VECTOR(nr-1 downto 0);
    y: in STD_LOGIC_VECTOR(nr-1 downto 0);
    Cin: in STD_LOGIC;
    S: out STD_LOGIC_VECTOR(nr-1 downto 0);
    Cout: out STD_LOGIC_VECTOR(nr-1 downto 0)
);    
end carry_lookahead_adder;

architecture Behavioral of carry_lookahead_adder is

    component full_adder is 
    port(
        a, b, cin: in std_logic; 
        s, cout: out std_logic
    ); 
    end component;

    signal genera:      STD_LOGIC_VECTOR(nr-1 downto 0);
    signal propagate:   STD_LOGIC_VECTOR(nr-1 downto 0);
    signal carry:       STD_LOGIC_VECTOR(nr downto 0);
    signal final_sum:   STD_LOGIC_VECTOR(nr-1 downto 0);

begin

    GEN_ADDERS: for i in nr-1 downto 0 generate
        COMPON : full_adder port map
            (a => x(i), 
             b => y(i), 
             Cin => carry(i), 
             S => final_sum(i), 
             Cout => open);     -- Output Carry of the Full Adders is not used => "open" pin 
    end generate GEN_ADDERS; 
    
    -- FULL_ADDER_1: full_adder port map(x(0), y(0), carry, final_sum(0), open);
    
    -- generating the signals: Generate, Propagate and the Output Carry
    GEN_SIGNALS: for j in nr-1 downto 0 generate
        genera(j)    <= x(j) and y(j);  -- x(j) * y(j)
        propagate(j) <= x(j) or y(j);   -- x(j) + y(j)
        carry(j + 1) <= genera(j) or (propagate(j) and carry(j));   -- formula: Output Carry = G(i) + P(i) * C(i)
    end generate GEN_SIGNALS;
    
    S <= final_sum;         -- final rezult of addition
    
end Behavioral;