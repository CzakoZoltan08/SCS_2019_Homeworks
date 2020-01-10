library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Decoder is
  Port (
  address: in std_logic_vector(23 downto 17);
  RD: in std_logic;
  WR: in std_logic;
  sel: out std_logic_vector(7 downto 0);
  sel_module: out std_logic
  );
end Decoder;

architecture Behavioral of Decoder is
signal E: std_logic;
signal A: std_logic_vector(2 downto 0);
begin

 process(address)
 begin
            A <= address(17) & address(18) & address(19);
            case (A) is
            when "000" => sel <= "11111110";
            when "001" => sel <= "11111101";
            when "010" => sel <= "11111011";
            when "011" => sel <= "11110111";
            when "100" => sel <= "11101111";
            when "101" => sel <= "11011111";
            when "110" => sel <= "10111111";
            when "111" => sel <= "01111111";
            when others => sel <=  "11111111";
            end case;            
end process;

E <= not (address(23) AND address(22) AND (NOT address(21)) AND (NOT address(20)));
sel_module <= ((RD and WR) or E);

end Behavioral;