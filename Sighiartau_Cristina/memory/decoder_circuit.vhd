library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity decoder_circuit is
Port (
address_bus: in std_logic_vector(6 downto 0);
wr:in std_logic;
rd: in std_logic;
sel_module: out std_logic;
sel: out std_logic_vector(7 downto 0));
end decoder_circuit;

architecture Behavioral of decoder_circuit is

signal e1, e2, e3: std_logic; 
signal casesig: std_logic_vector(2 downto 0);

begin

e1 <= not ((not address_bus(3)) and (not address_bus(4)) and address_bus(5) and address_bus(6));
e3 <= '1';
e2 <= rd and wr;

casesig<=  address_bus(0) & address_bus(1) & address_bus(2);
sel_module <= e1 or e2;

process(e1, e2, casesig)
begin
if (e1 = '0') and (e2='0') then
        case casesig is
            when "000" => sel<="11111110";
            when "001" => sel<="11111101";
            when "010" => sel<="11111011";
            when "011" => sel<="11110111";
            when "100" => sel<="11101111";
            when "101" => sel<="11011111";
            when "110" => sel<="10111111";
            when "111" => sel<="01111111";
            when others => sel<="11111111";
        end case;
    end if;
end process;
end Behavioral;
