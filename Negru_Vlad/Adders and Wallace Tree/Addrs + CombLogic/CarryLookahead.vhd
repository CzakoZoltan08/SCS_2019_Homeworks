----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/23/2019 04:55:49 PM
-- Design Name: 
-- Module Name: CarryLookahead - Behavioral
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

entity CarryLookahead is
    Generic(N:integer:=3);
    Port (
        a:in std_logic_vector(N-1 downto 0);
        b:in std_logic_vector(N-1 downto 0);
        s:out std_logic_vector(N-1 downto 0);
        cin:in std_logic;
        cout:out std_logic
     );
end CarryLookahead;

architecture Behavioral of CarryLookahead is
component FullAdder is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           cin : in STD_LOGIC;
           s : out STD_LOGIC;
           cout : out STD_LOGIC);
end component FullAdder;
signal carry:std_logic_vector(N downto 0);
signal misc:std_logic_vector(N downto 0);
begin
addere: for i in 0 to N-1 generate
    i_FULL_ADDER_INST : FullAdder port map(a=>a(i), b=>b(i), s=>s(i), cin=>carry(i), cout=>misc(i));
   end generate;
   
   carry(0) <= cin;
   cout<=carry(N);
   
   
process(a, b, cin)
begin
for i in 1 to N-1 loop
carry(i+1) <= (a(i) and b(i)) or ((a(i) or b(i)) and carry(i));
end loop;
end process;
end Behavioral;
