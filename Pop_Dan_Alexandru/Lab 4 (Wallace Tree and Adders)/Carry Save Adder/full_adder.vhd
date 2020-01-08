library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;

entity full_adder is 
port(
    a, b, cin: in std_logic; 
    s, cout: out std_logic
); 
end full_adder; 

architecture processes of full_adder is 
    
    signal s1, s2, s3, s4: std_logic;
     
begin 

    p1: process (b, cin) 
    begin 
        s1 <= b xor cin; 
    end process p1; 
    
    p2: process (a, b) 
    begin 
        s2 <= a and b; 
    end process p2; 
    
    p3: process (a, cin) 
    begin 
        s3 <= a and cin; 
    end process p3; 
    
    p4: process (b, cin) 
    begin 
        s4 <= b and cin; 
    end process p4; 
    
    p5: process (a, s1) 
    begin 
        s <= a xor s1; 
    end process p5; 
    
    p6: process (s2, s3, s4) 
    begin 
        cout <= s2 or s3 or s4; 
    end process p6; 
    
end processes;
