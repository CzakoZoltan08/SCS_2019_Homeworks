----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/10/2020 09:45:13 PM
-- Design Name: 
-- Module Name: fifo_ctrl - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fifo_ctrl is
     Port (rd: in std_logic;
            wr: in std_logic;
            clk: in std_logic;
            rst: in std_logic;
            rdinc: out std_logic;
            wrinc: out std_logic;
            empty: out std_logic;
            full: out std_logic
             );
end fifo_ctrl;

architecture Behavioral of fifo_ctrl is

signal rdvar,wrvar: std_logic_vector(3 downto 0):="0000";



begin
    full<='1' when rdvar(2 downto 0)=wrvar(2 downto 0) and rdvar(3) /= wrvar(3)
             else '0';
    
    empty<='1' when rdvar(2 downto 0)=wrvar(2 downto 0) and rdvar(3) = wrvar(3)
             else '0';


        process(clk, rd, wr,rst)
        begin            rdinc<='0';
            wrinc<='0';
            
            if (rst='1') then
            rdvar<="0000";
            wrvar<="0000";

            elsif (clk'event and clk = '1') then
            if(rd='1') then
                rdinc<='1';
                rdvar<=rdvar+'1';
            
             elsif (wr='1') then
                wrinc<='1';
                wrvar<=wrvar+'1';
                end if;
            end if;
        end process;

end Behavioral;
