library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
USE IEEE.numeric_std.ALL;

entity RAM is
port ( clk : in std_logic;
    we : in std_logic;
    addr : in std_ulogic_vector(31 downto 0);
    data_in_ram : in std_ulogic_vector(31 downto 0);
    data_out_ram : out std_ulogic_vector(31 downto 0);
    addr_ram_2: in std_ulogic_vector(31 downto 0);
    data_out_2 : out std_ulogic_vector(31 downto 0)
    );
end RAM;

architecture Behavioural of RAM is
 type RAM_32X256 is array (0 to 255) of std_ulogic_vector (31 downto 0);
 signal RAM_MEM: RAM_32X256 := (b"000000_00001_00010_00011_00000_100000", -- r3 = r1 + r2 
                           b"101011_00000_00011_0000000000000100", -- ram(4) = r3 
                           b"100011_00000_00101_0000000000000100", -- r5 = ram(4) 
                           b"000000_00011_00101_00100_00000_100100", -- r3 = r5 and r2   
                                                 
                                others=>x"00000000");
 
begin   
    process (clk)
     begin
         if rising_edge(clk) then
             if we = '1' then
                 RAM_MEM(to_integer(unsigned(addr(9 downto 2)))) <= data_in_ram;                    
             end if;
         end if;
     end process; 
     
    data_out_ram <= RAM_MEM( to_integer(unsigned((addr(9 downto 2)))));
    data_out_2 <= RAM_MEM( to_integer(unsigned((addr_ram_2(9 downto 2)))));

end Behavioural; 