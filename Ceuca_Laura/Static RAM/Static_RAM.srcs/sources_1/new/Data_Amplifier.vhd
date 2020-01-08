library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Data_Amplifier is
  Port (
  SD: inout std_logic_vector(15 downto 0);
  RD: in std_logic;
  Sel_module: in std_logic;
  Data: inout std_logic_vector(15 downto 0)
  );
end Data_Amplifier;

architecture Behavioral of Data_Amplifier is

begin

process(RD, Sel_module)
begin

    if(Sel_module = '0') then 
        if(RD = '0') then
            SD <= Data;
        else
            Data <= SD;
        end if;
    end if;
end process;


end Behavioral;
