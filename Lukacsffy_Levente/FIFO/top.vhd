----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/09/2020 05:41:37 PM
-- Design Name: 
-- Module Name: top - Behavioral
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

entity top is
 Port  (data : in std_logic_vector(7 downto 0);
        clk:in std_logic;
        btn : in STD_LOGIC_VECTOR (4 downto 0);
        data_out : out std_logic_vector(7 downto 0);
        full,empty: out std_logic);
end top;

architecture Behavioral of top is
component display is
 Port(
        clk : in std_logic;
        digit0 : in std_logic_vector (3 downto 0);
        digit1 : in std_logic_vector (3 downto 0);
        digit2 : in std_logic_vector (3 downto 0);
        digit3 : in std_logic_vector (3 downto 0);
        an : out std_logic_vector (3 downto 0);
        cat : out std_logic_vector (6 downto 0)
        );
        end component;
component mpg is
 Port (  btn : in std_logic_vector (4 downto 0);
            clk : in std_logic;
            enable : out std_logic_vector (4 downto 0));
end component;        
component fifo is
Port (  data : in std_logic_vector(7 downto 0);
        clk,rst,wr,rd : in std_logic;
        data_out : out std_logic_vector(7 downto 0);
        full,empty: out std_logic);
        end component;

signal countE : std_logic_vector (4 downto 0);
begin
rd: mpg port map (btn,clk,countE);
mem: fifo port map(data,clk,btn(0),btn(1),btn(2),data_out,full,empty);
dis: display port map(clk,digits,an,cat);

end Behavioral;
