----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/09/2020 04:00:22 PM
-- Design Name: 
-- Module Name: wallace - Behavioral
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

entity wallace is
  Port ( a,b: in std_logic_vector(3 downto 0);
    res: out std_logic_vector(7 downto 0));
end wallace;

architecture Behavioral of wallace is

component fadd is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           cin : in  STD_LOGIC;
           s : out  STD_LOGIC;
           cout : out  STD_LOGIC);
end component;

signal smid: std_logic_vector(15 downto 0);
signal cmid: std_logic_vector(15 downto 0);
signal aux1,aux2,aux3,aux4 : std_logic_vector(6 downto 0);
begin
    process(a,b)
begin
    for i in 0 to 3 loop
        aux1(i) <= a(i) and b(0);
        aux2(i) <= a(i) and b(1);
        aux3(i) <= a(i) and b(2);
        aux4(i) <= a(i) and b(3);
    end loop;       
end process;

map1: fadd port map(aux1(1),aux2(0),'0',smid(0),cmid(0));
map2: fadd port map(aux1(2),aux2(1),aux2(0),smid(1),cmid(1));
map3: fadd port map(aux1(3),aux2(2),aux2(1),smid(2),cmid(2));
map4: fadd port map(aux2(3),aux3(2),aux4(1),smid(3),cmid(3));
map5: fadd port map(aux3(3),aux4(2),'0',smid(4),cmid(4)); 
map6: fadd port map(cmid(0),smid(1),'0',smid(5),cmid(5));
map7: fadd port map(aux3(0),cmid(1),smid(2),smid(6),cmid(6));
map8: fadd port map(cmid(2),cmid(10),smid(3),smid(6),cmid(6));
map9: fadd port map(cmid(3),cmid(7),smid(4),smid(8),cmid(8));
map10: fadd port map(cmid(4),cmid(8),aux3(3),smid(9),cmid(9));
map11: fadd port map(cmid(5),cmid(5),'0',smid(9),cmid(9));
map12: fadd port map(cmid(6),cmid(7),'0',smid(9),cmid(9));
map13: fadd port map(cmid(12),cmid(8),'0',smid(9),cmid(9));
map14: fadd port map(cmid(13),cmid(9),'0',smid(9),cmid(9));
map15: fadd port map(cmid(14),cmid(9),'0',smid(9),cmid(9));
res(0)<=aux1(0);
res(1)<=smid(0);
res(2)<=smid(5);
res(3)<=smid(10);
res(4)<=smid(12);
res(5)<=smid(13);
res(6)<=smid(14);
res(7)<=smid(15);
end Behavioral;
