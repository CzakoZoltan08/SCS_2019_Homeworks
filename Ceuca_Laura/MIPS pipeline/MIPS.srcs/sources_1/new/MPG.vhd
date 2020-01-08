library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity MPG is
    Port(btn: in STD_LOGIC;
    clk:in STD_LOGIC;
    en:out STD_LOGIC);
end MPG;

architecture Behavioral of MPG is

signal Q1,Q2,Q3: STD_LOGIC:= '0';
signal counter:STD_LOGIC_VECTOR(15 downto 0) := "0000000000000000";
signal en1:STD_LOGIC:= '0';

begin

process(clk)
begin
    if counter="1111111111111111" then
        counter<="0000000000000000";
        en1<='1';
    elsif rising_edge(clk) then
        counter<=counter + 1;
        en1<='0';
    end if;
end process;

process(clk, btn)
begin
    if rising_edge(clk) then
        if en1='1' then 
            Q1<=btn;
        end if;
    end if;
end process;

process(clk)
begin
    if rising_edge(clk) then
        Q2<=Q1;
    end if;
end process;

process(clk)
begin
    if rising_edge(clk) then 
        Q3<=Q2;
    end if;
end process;

en<=Q2 and (not Q3);

end Behavioral;

