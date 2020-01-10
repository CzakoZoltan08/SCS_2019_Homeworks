----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/16/2019 06:37:34 PM
-- Design Name: 
-- Module Name: Demux4 - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Demux4 is
    Port ( a : in STD_LOGIC_vector(7 downto 0);
           y0 : out STD_LOGIC_vector(7 downto 0);
           y1 : out STD_LOGIC_vector(7 downto 0);
           y2 : out STD_LOGIC_vector(7 downto 0);
           y3 : out STD_LOGIC_vector(7 downto 0);
           sel:in std_logic_vector(1 downto 0)
           );
end Demux4;

architecture Behavioral of Demux4 is

begin
dmux: process(sel, a)
begin
case sel is
when "00" => y0<=a;
            y1<="ZZZZZZZZ";
            y2<="ZZZZZZZZ";
            y3<="ZZZZZZZZ";
            
when "01" => y0<="ZZZZZZZZ";
             y1<=a;
             y2<="ZZZZZZZZ";
             y3<="ZZZZZZZZ";
when "10" => y0<="ZZZZZZZZ";
             y1<="ZZZZZZZZ";
             y2<=a;
             y3<="ZZZZZZZZ";
when "10" => y0<="ZZZZZZZZ";
             y1<="ZZZZZZZZ";
             y2<="ZZZZZZZZ";
             y3<=a;
when others=>y0<="ZZZZZZZZ";
             y1<="ZZZZZZZZ";
             y2<="ZZZZZZZZ";
             y3<="ZZZZZZZZ";
end case;
end process;


end Behavioral;
