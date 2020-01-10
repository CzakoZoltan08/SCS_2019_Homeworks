----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/07/2020 07:44:19 PM
-- Design Name: 
-- Module Name: Control_Unit - Behavioral
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

entity Control_Unit is
         Port (
               match1:in std_logic;
               match2:in std_logic;
               wrEnMain:out std_logic;
               wrEn1:out std_logic;
               wrEn2:out std_logic;
               csMain:out std_logic;
               cs1:out std_logic;
               cs2:out std_logic
                );
end Control_Unit;

architecture Behavioral of Control_Unit is
signal var: std_logic:= '0';
begin

        process(match1, match2)
        
        begin
                cs1<='0';    
                cs2<='0';    
                wrEn1<='0';    
                wrEn2<='0';    
                wrEnMain<='0';    
                csMain<='0';    
                if(match1='1') then
                    cs1<='1';
            
                elsif(match2='1') then
                    cs2<='1';
               else
                    csMain<='1';
                    if(var='1') then wrEn1<='1'; cs1<='1'; var<='0';
                    else wrEn2<='1';var<='1'; cs2<='1';
                    end if;
                    
                end if;
        end process;

end Behavioral;
