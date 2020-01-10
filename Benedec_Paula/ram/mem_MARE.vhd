----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/07/2020 10:21:33 PM
-- Design Name: 
-- Module Name: mem_MARE - Behavioral
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

entity mem_MARE is
      Port (A:in std_logic_vector(16 downto 0);
            WR: in std_logic;
            SEL:in std_logic;
            BHE:in std_logic;
            Data_bus:inout std_logic_vector(15 downto 0) );
end mem_MARE;

architecture Behavioral of mem_MARE is

component mem_MICA is
          Port (A:in std_logic_vector(15 downto 0);
                CS: in std_logic;
                WR:in std_logic;
                D:inout std_logic_vector(7 downto 0) );
end component;


signal SEL_LOW:std_logic;
signal SEL_HIGH:std_logic;
begin
        
        SEL_LOW<= A(0) or SEL;
        SEL_HIGH<= BHE or SEL;
        m1: mem_MICA port map(A=>A(16 downto 1),
                CS=>SEL_LOW,
                WR=>WR,
                D=>Data_bus(7 downto 0));
        m2: mem_MICA port map(A=>A(16 downto 1),
                                CS=>SEL_HIGH,
                                WR=>WR,
                                D=>Data_bus(15 downto 8));

end Behavioral;
