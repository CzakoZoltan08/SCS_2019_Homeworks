----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/09/2020 11:46:42 PM
-- Design Name: 
-- Module Name: CarrySaveAdder - Behavioral
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

entity CarrySaveAdder is
  Port (A: in std_logic_vector(7 downto 0);
        B: in std_logic_vector(7 downto 0);
        C: in std_logic_vector(7 downto 0);
        S: out std_logic_vector(7 downto 0);
        Cout: out std_logic_vector(7 downto 0)
  
   );
end CarrySaveAdder;

architecture Behavioral of CarrySaveAdder is
component FullAdder is
 Port (A: in std_logic;
        B: in std_logic;
        Cin: in std_logic;
        Cout:out std_logic;
        S: out std_logic
 
  );
end component FullAdder;
signal temp_carry_1: std_logic_vector(7 downto 0);
signal temp_carry_2: std_logic_vector(7 downto 0);
signal temp_result: std_logic_vector(7 downto 0);

begin



FA1: FullAdder port map(A(0), B(0), '0', temp_carry_1(0), temp_result(0));
FA7: FullAdder port map(C(0), temp_result(0), '0', temp_carry_2(0), S(0));
cout(0) <= temp_carry_1(0) or temp_carry_2(0);

FA2: FullAdder port map(A(1), B(1), '0', temp_carry_1(1), temp_result(1));
FA8: FullAdder port map(C(1), temp_result(1), '0', temp_carry_2(1), S(1));
cout(1) <= temp_carry_1(1) or temp_carry_2(1);

FA3: FullAdder port map(A(2), B(2), '0', temp_carry_1(2), temp_result(2));
FA9: FullAdder port map(C(2), temp_result(2), '0', temp_carry_2(2), S(2));
cout(2) <= temp_carry_1(2) or temp_carry_2(2);

FA4: FullAdder port map(A(3), B(3), '0', temp_carry_1(3), temp_result(3));
FA10: FullAdder port map(C(3), temp_result(3), '0', temp_carry_2(3), S(3));
cout(3) <= temp_carry_1(3) or temp_carry_2(3);

FA5: FullAdder port map(A(4), B(4), '0', temp_carry_1(4), temp_result(4));
FA11: FullAdder port map(C(4), temp_result(4), '0', temp_carry_2(4), S(4));
cout(4) <= temp_carry_1(4) or temp_carry_2(4);

FA6: FullAdder port map(A(5), B(5), '0', temp_carry_1(5), temp_result(5));
FA12: FullAdder port map(C(5), temp_result(5), '0', temp_carry_2(5), S(5));
cout(5) <= temp_carry_1(5) or temp_carry_2(5);

FA436: FullAdder port map(A(6), B(6), '0', temp_carry_1(6), temp_result(6));
FA1432: FullAdder port map(C(6), temp_result(6), '0', temp_carry_2(6), S(6));
cout(6) <= temp_carry_1(6) or temp_carry_2(6);

FA656: FullAdder port map(A(7), B(7), '0', temp_carry_1(7), temp_result(7));
FA1652: FullAdder port map(C(7), temp_result(7), '0', temp_carry_2(7), S(7));
cout(7) <= temp_carry_1(7) or temp_carry_2(7);



end Behavioral;
