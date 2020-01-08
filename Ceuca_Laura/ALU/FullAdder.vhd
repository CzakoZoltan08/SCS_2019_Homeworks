library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity FullAdder is
port (a, b, cin: in std_logic;
       s, cout: out std_logic);
end FullAdder;

architecture Behavioural of FullAdder is
signal s1, s2, s3, s4: std_logic;
begin
    s1 <= b xor cin;
    s2 <= a and b;
    s3 <= a and cin;
    s4 <= b and cin;
    s <= a xor s1;
    cout <= s2 or s3 or s4;
end Behavioural;
