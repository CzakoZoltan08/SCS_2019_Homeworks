----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/10/2020 12:45:11 AM
-- Design Name: 
-- Module Name: simul - Behavioral
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

entity simul is
--  Port ( );
end simul;

architecture Behavioral of simul is
component WallaceTree4Bit is
  Port (A: in std_logic_vector(3 downto 0);
        B: in std_logic_vector(3 downto 0);
       totalProd:out std_logic_vector(7 downto 0)
  
  
   );
end component WallaceTree4Bit;
signal A, B:std_logic_vector(3 downto 0);
signal Res:std_logic_vector(7 downto 0);
begin
W:WallaceTree4Bit port map(A, B, Res);

process
begin
A<="1100";
B<="1110";
wait for 20ns;
A<="0011";
B<="1000";
wait for 20ns;
A<="1111";
B<="0000";


wait;
end process;

end Behavioral;
