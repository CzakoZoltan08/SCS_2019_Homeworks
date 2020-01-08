library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Address_Amplifier is
  Port (
  SA: in std_logic_vector(16 downto 1);
  Address: out std_logic_vector(16 downto 1)
  );
end Address_Amplifier;

architecture Behavioral of Address_Amplifier is

begin
Address <= SA;
end Behavioral;