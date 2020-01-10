library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Submodule is
  Port (
  address: in std_logic_vector(16 downto 0);
  WR: in std_logic;
  cs: in std_logic;
  A: in std_logic_vector(15 downto 0);
  D: out std_logic_vector(15 downto 0);
  clk: in std_logic
  );
end Submodule;

architecture Behavioral of Submodule is
signal selectHigh, selectLow, BHE : std_logic := '0';
type memory64x8 is array(0 to 65535) of std_logic_vector(7 downto 0);
signal RAM1, RAM2: memory64x8 := (others => X"FF");
begin

selectHigh <= cs OR NOT A(0);
selectLow <=  cs OR  NOT BHE;
    process (address, WR, cs)
    begin
        if (cs = '0') then
            if WR = '0' then
               RAM1(to_integer(unsigned(address(16 downto 1)))) <=  A(7 downto 0);
            end if;
        end if;
         if (cs = '0') then
            if WR = '0' then
               RAM2(to_integer(unsigned(address(16 downto 1)))) <=  A(15 downto 8);
            end if;
    end if;
    D <= RAM2(to_integer(unsigned(address(16 downto 1)))) & RAM1(to_integer(unsigned(address(16 downto 1))));
    end process; 
     
end Behavioral;