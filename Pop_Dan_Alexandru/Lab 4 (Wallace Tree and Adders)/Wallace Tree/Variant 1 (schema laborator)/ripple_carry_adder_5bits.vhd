library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ripple_carry_adder_5bits is
generic (
    nr: integer := 5        -- error: formal generic 'nr' has no actual or default value
);      -- componenta generica
--Port ( 
--    x: in STD_LOGIC_VECTOR(nr-1 downto 0);
--    y: in STD_LOGIC_VECTOR(nr-1 downto 0);
--    Cin: in STD_LOGIC;
--    S: out STD_LOGIC_VECTOR(nr-1 downto 0);
--    Cout: out STD_LOGIC
--);

-- without CarryIn and CarryOut (ca in schema logica de pe site)
Port ( 
    x: in STD_LOGIC_VECTOR(nr-1 downto 0);
    y: in STD_LOGIC_VECTOR(nr-1 downto 0);
    S: out STD_LOGIC_VECTOR(nr-1 downto 0)
);
end ripple_carry_adder_5bits;

architecture Behavioral of ripple_carry_adder_5bits is

    component full_adder is 
    port(
        a, b, cin: in std_logic; 
        s, cout: out std_logic
    ); 
    end component;

    -- the Carry signals
    signal c: STD_LOGIC_VECTOR(nr-1 downto 0);

begin

    --FULL_ADDER_1: full_adder port map(x(0), y(0), Cin, S(0), c(0));
    FULL_ADDER_1: full_adder port map(x(0), y(0), x(0), S(0), c(0));     -- ca si schema site (CarryIn legat la X(0))
    
    GEN_ADDERS:                            -- intermediate adders (intermediate carry signals)
       for i in 1 to nr-2 generate
          COMPON : full_adder port map
            (x(i), y(i), c(i), S(i), c(i+1));
       end generate GEN_ADDERS;
		 
    FULL_ADDER_5: full_adder port map(x(4), y(4), c(nr-1), S(4), open);     -- ca si schema site (CarryOut liber)

end Behavioral;
