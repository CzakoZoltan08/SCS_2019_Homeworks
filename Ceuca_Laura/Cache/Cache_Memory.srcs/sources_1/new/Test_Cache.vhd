library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Test_Cache is
--  Port ( );
end Test_Cache;

architecture Behavioral of Test_Cache is

component Cache_Memory is
Port(clk: in std_logic;
         address: in std_logic_vector(31 downto 0);
         data_in: in std_logic_vector(63 downto 0);
         read, write : in std_logic;
         hit_block_0, hit_block_1: out std_logic;
         data_out: out std_logic_vector(7 downto 0));
end component;

signal address: std_logic_vector(31 downto 0);
signal data_i: std_logic_vector(63 downto 0);
signal read, write: std_logic;
signal hit_0, hit_1: std_logic;
signal data_o: std_logic_vector(7 downto 0);
signal clk: std_logic;
begin

cache_map: cache_memory port map(clk, address, data_i, read, write, hit_0, hit_1, data_o);

process
begin 
    clk <= '0';
    wait for 10ns;
    clk <= '1';
    wait for 10ns;
end process;

process
begin
    
    address <= B"00000000000000000011_000000011_000";              -- read hit                        
    --data_i <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";     
    read <= '1';
    write <= '0';
    wait for 100ns;
    
    address <= B"00000000000000000100_000000010_000";              --read miss + fetch 
    --data_i <= "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX";
    read <= '1';
    write <= '0';
    --wait for 100ns;
    wait;

--    address <= B"00000000000000001100_000000001_000";              -- write miss                           
--    data_i <= B"00000001_00000001_00000001_00000001_00000001_00000001_00000001_00000001";     
--    read <= '0';
--    write <= '1';
--    wait for 100ns;
    
--    address <= B"00000000000000000011_000000011_000";              -- write hit                            
--    data_i <= B"00000010_00000010_00000010_00000010_00000010_00000010_00000010_00000010";    
--    read <= '0';
--    write <= '1';
--    wait for 100ns;
        

end process;


end Behavioral;
