----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/23/2019 04:18:32 PM
-- Design Name: 
-- Module Name: ripple_carry_adder - Behavioral
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

entity carry_lookahead_adder is
 generic (N: integer);
 port(X: in std_logic_vector(N-1 downto 0);
 Y: in std_logic_vector(N-1 downto 0);
 cout: out std_logic;
 res: out std_logic_vector(N-1 downto 0)
 );
end carry_lookahead_adder;

architecture Behavioral of carry_lookahead_adder is

signal carry: std_logic_vector(N downto 0) := (others => '0');
signal g, p: std_logic_vector(N downto 0) := (others => '0');
signal carryDump:std_logic_vector(N downto 0) := (others => '0');
 
component full_adder is
port(x: in std_logic;
y: in std_logic;
cin: in std_logic;
res: out std_logic;
cout: out std_logic);
end component;

begin

PG:
for i in 0 to N-1 generate
    g(i)<=X(i) and Y(i);
    p(i)<=X(i) or Y(i);
    carry(i+1)<=g(i) or (p(i) and carry(i));
    end generate PG;
    
GN:
for i in 0 to N-1 generate
    add_map: full_adder port map
    (X(i), Y(i), carry(i), res(i), carryDump(i));  
    end generate GN;

cout<=carry(N);
end Behavioral;
