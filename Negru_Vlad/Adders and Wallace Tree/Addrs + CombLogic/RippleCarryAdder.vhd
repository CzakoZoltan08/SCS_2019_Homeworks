----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/23/2019 04:14:48 PM
-- Design Name: 
-- Module Name: RippleCarryAdder - Behavioral
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

entity RippleCarryAdder is
Generic(N : integer:=3);
 Port (a: in std_logic_vector(N-1 downto 0);
 b: in std_logic_vector(N-1 downto 0);
 s: out std_logic_vector(N-1 downto 0);
 cin: in std_logic;
 cout:out std_logic
 );
end RippleCarryAdder;

architecture Behavioral of RippleCarryAdder is
signal carry:std_logic_vector(N downto 0);
component FullAdder is
    Port ( a : in STD_LOGIC;
           b : in STD_LOGIC;
           cin : in STD_LOGIC;
           s : out STD_LOGIC;
           cout : out STD_LOGIC);
end component FullAdder;
begin
addere: for i in 0 to N-1 generate
    i_FULL_ADDER_INST : FullAdder port map(a=>a(i), b=>b(i), s=>s(i), cin=>carry(i), cout=>carry(i+1));
   end generate;
carry(0)<=cin;
cout<=carry(N);
end Behavioral;
