library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity memory_matrix is
Port (
address_bus: in std_logic_vector(16 downto 0);
wr:in std_logic;
sel: in std_logic_vector(7 downto 0);
bhe: in std_logic;
data_in: in std_logic_vector(7 downto 0);
data_out: out std_logic_vector(15 downto 0));
end memory_matrix;

architecture Behavioral of memory_matrix is

component submodule is
Port (
address_bus: in std_logic_vector(16 downto 0);
wr:in std_logic;
sel: in std_logic;
bhe: in std_logic;
data_in: in std_logic_vector(7 downto 0);
data_out: out std_logic_vector(15 downto 0));
end component;

type outdatavec is array(0 to 7) of std_logic_vector(15 downto 0);
signal data_outs: outdatavec;

begin

GEN_MEMORY_MATRIX: 
   for i in 7 downto 0 generate
      submodule_generation: submodule port map (address_bus, wr, sel(i), bhe, data_in, data_outs(i));
   end generate GEN_MEMORY_MATRIX;
   
        data_out <= data_outs(0) when sel(0) = '0' else
                    data_outs(1) when sel(1) = '0' else
                    data_outs(2) when sel(2) = '0' else
                    data_outs(3) when sel(3) = '0' else
                    data_outs(4) when sel(4) = '0' else
                    data_outs(5) when sel(5) = '0' else
                    data_outs(6) when sel(6) = '0' else
                    data_outs(7) when sel(7) = '0';

end Behavioral;
