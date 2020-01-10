library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity fifoControl is
  Port (rd : in std_logic;
        data_in : in std_logic_vector(7 downto 0);
        wr : in std_logic;
        wrinc : in std_logic;
        rdinc : in std_logic;
        rst : in std_logic;
        clk : in std_logic;
        data_out : out std_logic_vector(7 downto 0) );
end fifoControl;

architecture Behavioral of fifoControl is

signal wrptr, rdptr : std_logic_vector(2 downto 0) :="000";

type fifo_memory is array (0 to 7) of std_logic_vector (7 downto 0);
signal fifoMemory : fifo_memory;
begin


writeFifoProcess: process(clk, rst, wrptr, wrinc)
    begin
    if rst = '1' then 
        for i in 0 to 7 loop
            fifoMemory(i) <= "00000000";
        end loop;
        wrptr <= (others => '0');
    else
    if rising_edge(clk) then 
        if wrinc = '1' then
            wrptr <= wrptr + 1;
        end if;
       if wr = '1' then
            fifoMemory(conv_integer(wrptr)) <= data_in;
        end if;
    end if;
   end if;
    end process;
    
readFifoProcess: process(rd, rst, rdptr, rdinc)
        begin
     if rst = '1' then
        rdptr <= "000";
    else 
        if rising_edge(clk) then
            if rdinc = '1' then
                rdptr <= rdptr+1;
             end if;
            if rd = '1' then
                data_out <= fifoMemory(conv_integer(rdptr));
        else
            data_out <= (others=>'0');
            end if;
          end if;
         end if;
        end process;
end Behavioral;
