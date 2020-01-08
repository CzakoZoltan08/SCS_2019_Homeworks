library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Multiplication is
    Port(a,b: in STD_LOGIC_VECTOR(3 downto 0);
         product : out STD_LOGIC_VECTOR(7 downto 0));
end Multiplication;

architecture Behavioural of Multiplication is

begin

process(a,b)
variable s0,s1,s2,s3: STD_LOGIC_VECTOR(7 downto 0) := "00000000";

begin

for i in 0 to 3 loop
    s0(i) := a(0) and b(i);
end loop;

for i in 0 to 3 loop
    s1(i + 1) := a(1) and b(i);
end loop;

for i in 0 to 3 loop
    s2(i+2) := a(2) and b(i);
end loop;

for i in 0 to 3 loop
    s3(i+3) := a(3) and b(i);
end loop;

product <= std_logic_vector(unsigned(s0)+unsigned(s1)+unsigned(s2)+unsigned(s3));

end process;

end Behavioural;