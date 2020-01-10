----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/23/2019 04:41:20 PM
-- Design Name: 
-- Module Name: RippleCarryTest - Behavioral
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

entity RippleCarryTest is
--  Port ( );
end RippleCarryTest;

architecture Behavioral of RippleCarryTest is
component RippleCarryAdder is
Generic(N : integer:=3);
 Port (a: in std_logic_vector(N-1 downto 0);
 b: in std_logic_vector(N-1 downto 0);
 s: out std_logic_vector(N-1 downto 0);
 cin: in std_logic;
 cout:out std_logic
 );
end component RippleCarryAdder;

signal a:std_logic_vector(3 downto 0);
signal b:std_logic_vector(3 downto 0);
signal s:std_logic_vector(3 downto 0);
signal cin, cout:std_logic;
begin
compo: RippleCarryAdder generic map (N=>4)
                        port map(a=>a, b=>b, s=>s, cin=>cin, cout=>cout);
                        
    process
    begin
    
    a<="0101";
    b<="1010";
    cin<='0';
    wait for 10ps;
    cin<='1';
    wait for 10ps;
    a<="1111";
    b<="1111";
    wait;
    
    end process;

end Behavioral;
