library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity MemoryMatrix is
  Port (
  address: in std_logic_vector(16 downto 0);
  sel: in std_logic_vector(7 downto 0);
  WR: in std_logic;
  A: in std_logic_vector(15 downto 0);
  D: out std_logic_vector(15 downto 0);
  clk: in std_logic
  );
end MemoryMatrix;

architecture Behavioral of MemoryMatrix is

component Submodule is
  Port (
  address: in std_logic_vector(16 downto 0);
  WR: in std_logic;
  cs: in std_logic;
  A: in std_logic_vector(15 downto 0);
  D: out std_logic_vector(15 downto 0);
  clk: in std_logic
  );
end component;
signal DAux_0, DAux_1, DAux_2, DAux_3, DAux_4, DAux_5,DAux_6, DAux_7: std_logic_vector(15 downto 0);
begin

SubModule0: Submodule port map(address => address(16 downto 0), WR => WR,CS=> Sel(0),A =>A, D=>DAux_0,clk=> clk);
SubModule1: Submodule port map(address => address(16 downto 0), WR => WR,CS=> Sel(1),A =>A, D=>DAux_1,clk=> clk);
SubModule2: Submodule port map(address => address(16 downto 0), WR => WR,CS=> Sel(2),A =>A, D=>DAux_2,clk=> clk);
SubModule3: Submodule port map(address => address(16 downto 0), WR => WR,CS=> Sel(3),A =>A, D=>DAux_3,clk=> clk);
SubModule4: Submodule port map(address => address(16 downto 0), WR => WR,CS=> Sel(4),A =>A, D=>DAux_4,clk=> clk);
SubModule5: Submodule port map(address => address(16 downto 0), WR => WR,CS=> Sel(5),A =>A, D=>DAux_5,clk=> clk);
SubModule6: Submodule port map(address => address(16 downto 0), WR => WR,CS=> Sel(6),A =>A, D=>DAux_6,clk=> clk);
SubModule7: Submodule port map(address => address(16 downto 0), WR => WR,CS=> Sel(7),A =>A, D=>DAux_7,clk=> clk);

process(sel)
begin
        case sel is
        when "11111110" => D <= DAux_0;
        when "11111101" => D <= DAux_1;
        when "11111011" => D <= DAux_2;
        when "11110111" => D <= DAux_3;
        when "11101111" => D <= DAux_4;
        when "11011111" => D <= DAux_5;
        when "10111111" => D <= DAux_6;
        when "01111111" => D <= DAux_7;
        when others => D <= A;
    end case;
end process;

end Behavioral;