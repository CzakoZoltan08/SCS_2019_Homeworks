library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Division is
    Port(x,y: in STD_LOGIC_VECTOR(3 downto 0);
         quot, r : out STD_LOGIC_VECTOR(3 downto 0));
end Division;

architecture Behavioural of Division is

begin

process(x,y)
variable a, b: std_logic_vector(4 downto 0);
variable q: std_logic_vector(3 downto 0);
variable n: integer;
begin
a := "00000";
b := "0" & y;
q := x;
n := 4;

for i in 0 to n-1 loop

    a(3 downto 0) := a(2 downto 0) & q(3);
    q(3 downto 0) := q(2 downto 0) & '0';
    
    a := std_logic_vector(signed(a) - signed(b));
    
    if signed(a) > 0 then 
        q(0) := '1';
    else
        a := std_logic_vector(signed(a) + signed(b));
        q(0) := '0';
    end if; 
end loop;

quot <= q;
r <= a(3 downto 0);

end process;

end Behavioural;