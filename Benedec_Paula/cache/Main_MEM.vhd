----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/07/2020 07:27:55 PM
-- Design Name: 
-- Module Name: Main_MEM - Behavioral
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
use IEEE.STD_LOGIC_unsigned.ALL;
use IEEE.STD_LOGIC_arith.ALL;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Main_MEM is
         Port ( a: in std_logic_vector(31 downto 0);
                cs:in std_logic;
                wrEn: in std_logic;
                dout:inout std_logic_vector(63 downto 0)
                 );
end Main_MEM;

architecture Behavioral of Main_MEM is
type mem is array(0 to 2**20-1) of std_logic_vector(63 downto 0);
signal Main_data : mem:=
(x"0000000000000001",
 x"0000000000000002",   
 x"0000000000000003",   
 x"0000000000000004",   
 x"0000000000000005"   ,
others=>x"0000000000000007"
);
begin
     process(a,cs,wrEn,dout)
        begin
                if(cs='1') then
                    if(wrEn='1') then
                        Main_data(conv_integer(a(20 downto 3)))<=dout;
                        else
                        dout<=Main_data(conv_integer(a(20 downto 3)));
                        end if;
                    else
                        dout<=(others=>'Z');
                end if;

        end process;
end Behavioral;
