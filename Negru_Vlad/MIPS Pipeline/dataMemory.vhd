----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 04/17/2019 07:37:14 PM
-- Design Name: 
-- Module Name: DataMemory - Behavioral
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

entity DataMemory is
Port (
    clk:in std_logic;
     MemWrite: in std_logic;
     AluResIn:in std_logic_vector(31 downto 0);
     WriteData: in std_logic_vector(31 downto 0);
     MemData: out std_logic_vector(31 downto 0);
     AluResOut: out std_logic_vector(31 downto 0)
);
end DataMemory;

architecture Behavioral of DataMemory is
signal MemDataInter:std_logic_vector(31 downto 0);
component Ram is
 port ( clk : in std_logic;
 we : in std_logic;
 en : in std_logic;
 addr : in std_logic_vector(7 downto 0);
 di : in std_logic_vector(31 downto 0);
 do : out std_logic_vector(31 downto 0)
 );
end component;
begin


AluResOut <= AluResIn;

memorie: Ram port map(clk, MemWrite, '1', AluResIn(7 downto 0), WriteData, MemData);



end Behavioral;
