----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/09/2020 11:56:22 PM
-- Design Name: 
-- Module Name: WallaceTree4Bit - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity WallaceTree4Bit is
  Port (A: in std_logic_vector(3 downto 0);
        B: in std_logic_vector(3 downto 0);
       totalProd:out std_logic_vector(7 downto 0)
  
  
   );
end WallaceTree4Bit;

architecture Behavioral of WallaceTree4Bit is
component CarrySaveAdder is
  Port (A: in std_logic_vector(7 downto 0);
      B: in std_logic_vector(7 downto 0);
      C: in std_logic_vector(7 downto 0);
      S: out std_logic_vector(7 downto 0);
      Cout: out std_logic_vector(7 downto 0)

 );
end component CarrySaveAdder;
signal tempA0, tempA1, tempA2, tempA3:std_logic_vector(7 downto 0):=x"00";
signal tempA0shifted, tempA1shifted, tempA2shifted, tempA3shifted:std_logic_vector(7 downto 0);
signal carrySign0, carrySign0Shifted:std_logic_vector(7 downto 0);
signal Res0,Res1, carrySign1:std_logic_vector(7 downto 0);

signal carrySign1Shifted:std_logic_vector(7 downto 0);
begin
tempA0(3 downto 0) <=  (A and (B(0)&B(0)&B(0)&B(0)));
tempA0shifted <= tempA0;
tempA1(3 downto 0) <=( A and (B(1)&B(1)&B(1)&B(1)));
tempA1shifted <= tempA1(6 downto 0)&'0';
tempA2(3 downto 0) <=( A and (B(2)&B(2)&B(2)&B(2)));
tempA2shifted <= tempA2(5 downto 0)&"00";
tempA3(3 downto 0) <= (A and (B(3)&B(3)&B(3)&B(3)));
tempA3shifted <= tempA3(4 downto 0)&"000";

W1: CarrySaveAdder port map(tempA0shifted, tempA1shifted, tempA2shifted, Res0, carrySign0);
CarrySign0Shifted <= CarrySign0(6 downto 0) &'0';
W2: CarrySaveAdder port map(tempA3shifted, carrySign0Shifted, Res0, Res1, carrySign1);
CarrySign1Shifted <= CarrySign1(6 downto 0) &'0';


totalProd <= CarrySign1Shifted + Res1; --well...full adder here nothing special
end Behavioral;
