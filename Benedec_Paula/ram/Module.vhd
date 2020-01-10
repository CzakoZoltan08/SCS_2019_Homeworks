----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/07/2020 11:42:55 PM
-- Design Name: 
-- Module Name: Module - Behavioral
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

entity Module is
--  Port ( );
end Module;

architecture Behavioral of Module is
component TOPLVL is
      Port (A:in std_logic_vector(23 downto 0);
            WR,RD,BHE:in std_logic;
            D:inout std_logic_vector(15 downto 0));
end component;

signal Am:std_logic_vector(23 downto 0);
signal WR,RD,BHE:std_logic;
signal Dm:std_logic_vector(15 downto 0):=(others=>'Z');
begin
        tl: TOPLVL port map(A=>Am,
            WR=>WR,
            RD=>RD,
            BHE=>BHE,
            D=>Dm);
            
            process
                    begin
                                Am(23 downto 20)<="1100";
                                Am(19 downto 0) <= (others => '0');
                                wr<='1';
                                rd<='0';
                                bhe<='1';  --citesc prima jum
                                wait for 20ns;
                                bhe<='0';
                                rd<='0';  --citesc jum 2
                                wait for 20ns;
                                bhe<='1';   --preg sa sciu in prima jum in mem
                                rd<='1';
                                wr<='1';
                                Dm<=x"DDDD";
                                wait for 20ns;
                                wr<='0';  --scriu
                                rd<='1';
                                wait for 20ns;
                                wr<='1';    --citesc toata data 16 biti
                                Dm<=(others=>'Z');
                                rd<='0';
                                bhe<='0';
                                wait for 20ns;                        
                                Am(19 downto 1)<=(others=>'1'); --schimb adresa
                                wait for 20ns;
                                Dm<=x"ABCD";
                                Am(0) <='1'; --vreau sa scriu in a doua jum
                                rd<='1';
                                wait for 20ns;
                                wr<='0';--scriu
                                wait for 20ns;
                                wr<='1';
                                Am(0)<='0';--citesc toti 16 biti
                                Dm<=(others=>'Z');
                                wait for 20ns;
                                rd<='0';--citesc
                                wait;
                            
                    
                    
        end process;
    
    end Behavioral;
