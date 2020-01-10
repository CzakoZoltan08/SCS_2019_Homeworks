----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/09/2020 04:29:56 PM
-- Design Name: 
-- Module Name: fifo - Behavioral
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
use IEEE.std_logic_arith.all;
use ieee.std_logic_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fifo is
Port (  data : in std_logic_vector(7 downto 0);
        clk,rst,wr,rd : in std_logic;
        data_out : out std_logic_vector(7 downto 0);
        full,empty: out std_logic);
end fifo;

architecture Behavioral of fifo is
type FIFO is array (0 to 7) of STD_LOGIC_VECTOR (7 downto 0);
signal mem_unit : FIFO:=(
x"0001",
x"0002",
x"0003",
x"0004",
x"0005",
x"0006",
x"0007",
x"0008",
x"0009",
others => x"0000");

signal wpt : std_logic_vector (4 downto 0);
signal rpt : std_logic_vector (4 downto 0);
begin

    process(clk)
        begin
        full<='0';
        empty<='1';
        if clk='1' and clk'event then
            if rst='1' then
                wpt<="00000";
                rpt<="00000";           
                full  <= '0';
				empty <= '1';
				data_out<=mem_unit(conv_integer(rpt));
		else
		      if(rd='1')then
		      data_out<=mem_unit(conv_integer(rpt));
		      end if;
		     if wr='1' then
		     mem_unit(conv_integer(wpt))<=data;
		      end if;
		     if wpt="0111" then full<='1' ;
		          empty<='0';
		     end if;
		     if rpt="0000" then empty<='1';
		     full<='0';
		     end if;
		end if;
        end if;
 end process;  
end Behavioral;
