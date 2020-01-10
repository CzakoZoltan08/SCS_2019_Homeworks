----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/07/2020 10:50:16 PM
-- Design Name: 
-- Module Name: Decoder - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Decoder is
     Port ( input: in STD_LOGIC_VECTOR (2 downto 0);
            output : out  STD_LOGIC_VECTOR (7 downto 0);
            E1:in std_logic;
            E2:in std_logic;
            E3:in std_logic);
end Decoder;

architecture Behavioral of Decoder is
signal temp: std_logic_vector(7 downto 0);
begin
        process(input, E1, E2, E3)
        begin
                case input is
                  when "000" => temp <= "00000001";
                  when "001" => temp <= "00000010";
                  when "010" => temp <= "00000100";
                  when "011" => temp <= "00001000";
                  when "100" => temp <= "00010000";
                  when "101" => temp <= "00100000";
                  when "110" => temp <= "01000000";
                  when "111" => temp <= "10000000";
                     when others => temp <= "11111111";
             end case;
        if(E1='0' and E2='0' and E3='1') then     
            output <= temp;  
            else
            output<= "11111111";
        end if;
        end process;

end Behavioral;
