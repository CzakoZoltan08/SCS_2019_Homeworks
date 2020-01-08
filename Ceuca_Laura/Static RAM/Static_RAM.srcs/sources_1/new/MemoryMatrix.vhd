library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MemoryMatrix is
  Port (
  address: in std_logic_vector(16 downto 0);
  sel: in std_logic_vector(7 downto 0);
  WR: in std_logic;
  data_in: in std_logic_vector(15 downto 0);
  data_out: out std_logic_vector(15 downto 0);
  clk: in std_logic
  );
end MemoryMatrix;

architecture Behavioral of MemoryMatrix is

component Submodule is
  Port (
  address: in std_logic_vector(16 downto 0);
  WR: in std_logic;
  sel: in std_logic;
  data_in: in std_logic_vector(15 downto 0);
  data_out: out std_logic_vector(15 downto 0);
  clk: in std_logic
  );
end component;
signal data_0, data_1, data_2, data_3, data_4, data_5,data_6, data_7: std_logic_vector(15 downto 0) := (others => '0');
begin

b0: Submodule port map(address(16 downto 0), WR, Sel(0),data_in, data_0, clk);
b1: Submodule port map(address(16 downto 0), WR, Sel(1),data_in, data_1, clk);
b2: Submodule port map(address(16 downto 0), WR, Sel(2),data_in, data_2, clk);
b3: Submodule port map(address(16 downto 0), WR, Sel(3),data_in, data_3, clk);
b4: Submodule port map(address(16 downto 0), WR, Sel(4),data_in, data_4, clk);
b5: Submodule port map(address(16 downto 0), WR, Sel(5),data_in, data_5, clk);
b6: Submodule port map(address(16 downto 0), WR, Sel(6),data_in, data_6, clk);
b7: Submodule port map(address(16 downto 0), WR, Sel(7),data_in, data_7, clk);

process(clk, WR, sel)
begin
        case sel is
        when "11111110" => data_out <= data_0;
        when "11111101" => data_out <= data_1;
        when "11111011" => data_out <= data_2;
        when "11110111" => data_out <= data_3;
        when "11101111" => data_out <= data_4;
        when "11011111" => data_out <= data_5;
        when "10111111" => data_out <= data_6;
        when "01111111" => data_out <= data_7;
        when others => data_out <= data_in;
    end case;
end process;

end Behavioral;