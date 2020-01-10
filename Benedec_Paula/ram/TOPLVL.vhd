----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/07/2020 11:09:03 PM
-- Design Name: 
-- Module Name: TOPLVL - Behavioral
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

entity TOPLVL is
      Port (A:in std_logic_vector(23 downto 0);
            WR,RD,BHE:in std_logic;
            D:inout std_logic_vector(15 downto 0));
end TOPLVL;

architecture Behavioral of TOPLVL is
component Decoder is
     Port ( input: in STD_LOGIC_VECTOR (2 downto 0);
            output : out  STD_LOGIC_VECTOR (7 downto 0);
            E1:in std_logic;
            E2:in std_logic;
            E3:in std_logic);
end component;

component mem_MARE is
      Port (A:in std_logic_vector(16 downto 0);
            WR: in std_logic;
            SEL:in std_logic;
            BHE:in std_logic;
            Data_bus:inout std_logic_vector(15 downto 0) );
end component;

signal SEL: std_logic_vector(7 downto 0);
signal E1: std_logic;
signal E2: std_logic;
signal E3: std_logic;
begin
        E1<= not ((not A(20)) and (not A(21)) and A(22) and A(23)) ;
        E2<=RD and WR;
        E3<='1';
        dec: Decoder port map( input=>A(19 downto 17),
                                output=>SEL,
                                E1=>E1,
                                E2=>E2,
                                E3=>E3)  ;      
                                
    m0: mem_MARE port map(A=>A(16 downto 0),
                            WR=>WR,
                            SEL=>SEL(0),
                            BHE=>BHE,
                            Data_bus=>D(15 downto 0) );
    m1: mem_MARE port map(A=>A(16 downto 0),
                            WR=>WR,
                            SEL=>SEL(1),
                            BHE=>BHE,
                            Data_bus=>D(15 downto 0) );
    m2: mem_MARE port map(A=>A(16 downto 0),
                            WR=>WR,
                            SEL=>SEL(2),
                            BHE=>BHE,
                            Data_bus=>D(15 downto 0) );
    m3: mem_MARE port map(A=>A(16 downto 0),
                            WR=>WR,
                            SEL=>SEL(3),
                            BHE=>BHE,
                            Data_bus=>D(15 downto 0) );
    m4: mem_MARE port map(A=>A(16 downto 0),
                            WR=>WR,
                            SEL=>SEL(4),
                            BHE=>BHE,
                            Data_bus=>D(15 downto 0) );
    m5: mem_MARE port map(A=>A(16 downto 0),
                            WR=>WR,
                            SEL=>SEL(5),
                            BHE=>BHE,
                            Data_bus=>D(15 downto 0) );
    m6: mem_MARE port map(A=>A(16 downto 0),
                            WR=>WR,
                            SEL=>SEL(6),
                            BHE=>BHE,
                            Data_bus=>D(15 downto 0) );
    m7: mem_MARE port map(A=>A(16 downto 0),
                            WR=>WR,
                            SEL=>SEL(7),
                            BHE=>BHE,
                            Data_bus=>D(15 downto 0) );
end Behavioral;
