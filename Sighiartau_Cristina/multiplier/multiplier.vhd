library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;
use ieee.numeric_std.all;  

entity multiplier is
Port(clk: in std_logic;
X, Y: in std_logic_vector(3 downto 0);
result: out std_logic_vector(7 downto 0);
done: out std_logic);
end multiplier;

architecture Behavioral of multiplier is
type state_type is (START, COMPARE, SUM, SHIFT, STOP);
signal state: state_type :=START;
signal N : integer := 4;
signal Q: std_logic_vector(3 downto 0);
signal A, B: std_logic_vector(7 downto 0);

begin

process(clk)
begin
    if clk'event and clk='1' then
        case state is
            when START =>
                A<="00000000";
                B<="0000"&X;
                Q<=Y;
                N<=4;
                done<='0';
                result<="00000000";
                state<=COMPARE;
            when COMPARE=>
                if Q(0) = '1' then  
                    state<=SUM;
                else
                    state<=SHIFT;
                end if;
            when SUM =>
                A <= A + B;
               state <= SHIFT;
            when SHIFT =>
                B <= B(6 downto 0) & '0';
                Q <= '0' & Q(3 downto 1); --shift right
                N <= N-1;
                if N = 0 then 
                    state<=STOP;
                else
                    state<=COMPARE;
                end if;
            when STOP =>
                result<=A;
                done<='1';
                state<=START;
            end case;
    end if;
end process;     

end Behavioral;
