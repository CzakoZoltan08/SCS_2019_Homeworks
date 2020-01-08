library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Display is
generic (counterSize : natural := 15);
Port (  clk : in std_logic;
        d3,d2,d1,d0 : in std_logic_vector(3 downto 0);
        an : out std_logic_vector(3 downto 0);
        cat : out std_logic_vector(6 downto 0)
      );  
end Display;

architecture Behavioral of Display is

signal cnt : std_logic_vector(counterSize-1 downto 0);
signal muxDigits : std_logic_vector(3 downto 0);
signal sel : std_logic_vector(1 downto 0);

begin

    counter:process(clk)
        begin
            if rising_edge(clk) then
                cnt <= cnt + 1;
            end if;
        end process;
    
    sel <= cnt(counterSize - 1)&cnt(counterSize - 2);
    
    mux:process(sel,d0,d1,d2,d3)
    begin
        case sel is
            when "00" => muxDigits <= d0;
                         an <= "1110";                 
            when "01" => muxDigits <= d1;
                         an <= "1101";
            when "10" => muxDigits <= d2;
                         an <= "1011";
            when others => muxDigits <= d3;
                           an <= "0111";
        end case;
    end process;
    
    with muxDigits select
       cat<= "1111001" when "0001",   --1
             "0100100" when "0010",   --2
             "0110000" when "0011",   --3
             "0011001" when "0100",   --4
             "0010010" when "0101",   --5
             "0000010" when "0110",   --6
             "1111000" when "0111",   --7
             "0000000" when "1000",   --8
             "0010000" when "1001",   --9
             "0001000" when "1010",   --A
             "0000011" when "1011",   --b
             "1000110" when "1100",   --C
             "0100001" when "1101",   --d
             "0000110" when "1110",   --E
             "0001110" when "1111",   --F
             "1000000" when others;   --0
    
end Behavioral;