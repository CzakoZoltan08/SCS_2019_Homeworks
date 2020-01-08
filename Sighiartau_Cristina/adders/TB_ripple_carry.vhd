----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/23/2019 04:40:33 PM
-- Design Name: 
-- Module Name: TB_ripple_carry - Behavioral
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

entity TB_ripple_carry is
--  Port ( );
end TB_ripple_carry;

architecture Behavioral of TB_ripple_carry is

constant nBits : integer :=4;

component ripple_carry_adder is
generic (N: integer);
 port(X: in std_logic_vector(N-1 downto 0);
 Y: in std_logic_vector(N-1 downto 0);
 cout: out std_logic;
 res: out std_logic_vector(N-1 downto 0)
 );
end component;

signal A, B, R: std_logic_vector(nBits-1 downto 0);
signal co : std_logic;

begin
m1: ripple_carry_adder
    generic map (N => nBits)
    port map (A, B, co, R);

process
begin
A<="0000";
B<="0001";
wait for (10 ps);

A<="0100";
B<="0001";
wait for (10 ps);

A<="1011";
B<="0001";
wait for (10 ps);

A<="1111";
B<="1111";

wait;
end process;
end Behavioral;
