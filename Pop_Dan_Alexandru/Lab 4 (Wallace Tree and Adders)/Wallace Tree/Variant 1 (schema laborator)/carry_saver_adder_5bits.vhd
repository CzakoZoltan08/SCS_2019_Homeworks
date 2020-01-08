-- schema circuit: https://www.researchgate.net/figure/Computation-Flow-of-Carry-Save-Adder_fig1_228892141
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Carry Saver Adder is used when 3 numbers of 'nr'-bits must be added, 
-- because is more time-efficient since it reduces propagation time
entity carry_saver_adder_5bits is
generic (
    nr: integer := 5    -- nr of bits
);
port(
    a: in std_logic_vector(nr-1 downto 0);
    b: in std_logic_vector(nr-1 downto 0);
    c: in std_logic_vector(nr-1 downto 0);
    --carry_in: in std_logic_vector(nr downto 0);
    sum: out std_logic_vector(nr-1 downto 0);
    carry_out: out std_logic_vector(nr-1 downto 0)
);
end entity;

architecture Behavioral of carry_saver_adder_5bits is

    component full_adder is 
    port(
        a, b, cin: in std_logic; 
        s, cout: out std_logic
    ); 
    end component;
    
    signal sum_1: std_logic_vector(nr-1 downto 0);
    signal cout_1: std_logic_vector(nr downto 1);
    
    component ripple_carry_adder_5bits is
    generic (
        nr: integer := 5
    );      -- componenta generica
    Port ( 
        x: in STD_LOGIC_VECTOR(nr-1 downto 0);
        y: in STD_LOGIC_VECTOR(nr-1 downto 0);
        --Cin: in STD_LOGIC;
        S: out STD_LOGIC_VECTOR(nr-1 downto 0)
        --Cout: out STD_LOGIC
    );
    end component;
    
    signal sum_2: std_logic_vector(nr-1 downto 0);
    --signal cout_2: std_logic; 
     
begin

    -- level 1
    GEN_ADDERS: for i in nr-1 downto 0 generate
        COMPON_1: full_adder port map
            (a => a(i), 
             b => b(i), 
             cin => c(i), 
             s => sum_1(i), 
             cout => cout_1(i+1));
    end generate GEN_ADDERS;
    
    -- level 2
    COMPON_2: ripple_carry_adder_5bits port map
            (x => sum_1,
             y => cout_1, 
             --Cin => , 
             S => sum_2);
             --Cout => );
    
end Behavioral;