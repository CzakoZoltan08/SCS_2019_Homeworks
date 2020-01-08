library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity TB_save_carry is
--  Port ( );
end TB_save_carry;

architecture Behavioral of TB_save_carry is

constant nBits : integer :=4;

component carry_save_adder is
 generic (N: integer);
 port(X: in std_logic_vector(N-1 downto 0);
 Y: in std_logic_vector(N-1 downto 0);
 Z: in std_logic_vector(N-1 downto 0);
 cout: out std_logic;
 res: out std_logic_vector(N-1 downto 0)
 );
end component;

signal A, B, C, R: std_logic_vector(nBits-1 downto 0);
signal co : std_logic;

begin
m1: carry_save_adder
    generic map (N => nBits)
    port map (A, B, C, co, R);

process
begin
A<="0000";
B<="0001";
C<="1000";
wait for (10 ps);

A<="0100";
B<="0001";
C<="1100";
wait for (10 ps);

A<="1011";
B<="0001";
C<="0000";
wait for (10 ps);

A<="1111";
B<="1111";
C<="1000";

wait;
end process;
end Behavioral;
