library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MPG is
port (  clk : in STD_LOGIC;
        inp : in STD_LOGIC;
        oup : out STD_LOGIC);
end MPG;

architecture Behavioral of MPG is

signal cnt: STD_LOGIC_VECTOR(15 downto 0);
signal d1,d2 : STD_LOGIC;
begin

    counter:process (clk)
    begin
        if rising_edge(clk) then
            cnt <= cnt + 1;
        end if;
    end process;
     
    d_uri:process(clk,inp)
    begin
        if rising_edge(clk) then
            if cnt = x"FFFF" then
                d1 <= inp;
            end if;
            d2 <= d1;
        end if;
        
    end process;
    
    oup <= d1 and (not d2);
    
end Behavioral;
