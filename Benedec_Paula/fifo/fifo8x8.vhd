----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/10/2020 10:08:38 PM
-- Design Name: 
-- Module Name: fifo8x8 - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fifo8x8 is
   Port (   
            data_in:in std_logic_vector(7 downto 0);
            rd: in std_logic;
            wr: in std_logic;
            clk: in std_logic;
            rst: in std_logic;
            rdinc: in std_logic;
            wrinc: in std_logic;
            data_out:out std_logic_vector(7 downto 0));
end fifo8x8;

architecture Behavioral of fifo8x8 is

type mem is array(0 to 7) of std_logic_vector(7 downto 0);
signal fifo:MEM;
signal rdvar,wrvar:std_logic_vector(2 downto 0):="000";
begin
        process(clk,rst,rd,wr)
        begin
                if(rst='1') then
                    rdvar<="000";
                    wrvar<="000";
                    
                    for i in 0 to 7 loop
                        fifo(i)<=x"00";
                        end loop;
                        
                   data_out<=x"00";
                elsif (rising_edge(clk)) then
                    if(rd='1' and rdinc='1') then 
                        data_out<=fifo(conv_integer(rdvar));
                        rdvar<=rdvar+'1';
                   elsif (wr='1' and wrinc='1') then 
                        fifo(conv_integer(wrvar))<=data_in;
                        
                        end if;
                end if;
        end process;

end Behavioral;
