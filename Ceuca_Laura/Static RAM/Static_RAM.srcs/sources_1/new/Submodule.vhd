library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Submodule is
  Port (
  address: in std_logic_vector(16 downto 0);
  WR: in std_logic;
  sel: in std_logic;
  data_in: in std_logic_vector(15 downto 0);
  data_out: out std_logic_vector(15 downto 0);
  clk: in std_logic
  );
end Submodule;

architecture Behavioral of Submodule is
type RAM_CELL_64K_X_8 is array(0 to 65535) of std_logic_vector(7 downto 0);
signal upper_RAM, lower_RAM: RAM_CELL_64K_X_8 := (others => X"FF");
begin

    process (address, WR, Sel)
    begin
        if (sel = '0') then
            if WR = '0' then
               upper_RAM(to_integer(unsigned(address(16 downto 1)))) <=  data_in(7 downto 0);
               lower_RAM(to_integer(unsigned(address(16 downto 1)))) <=  data_in(15 downto 8);
            end if;
    end if;
    data_out <= lower_RAM(to_integer(unsigned(address(16 downto 1)))) & upper_RAM(to_integer(unsigned(address(16 downto 1))));
    end process; 
     
end Behavioral;