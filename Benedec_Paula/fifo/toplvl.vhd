----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/10/2020 10:35:16 PM
-- Design Name: 
-- Module Name: toplvl - Behavioral
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

entity toplvl is
 Port ( 
    data_in: in std_logic_vector(7 downto 0);
    btn_rd: in std_logic;
    btn_wr:in std_logic;
    clk:in std_logic;
    rst:in std_logic;
    sseg:out std_logic_vector(6 downto 0);
    an:out std_Logic_vector(3 downto 0);
    empty: out std_logic;
    full: out std_logic);
end toplvl;

architecture Behavioral of toplvl is
component filtr is
  Port ( d :in std_logic;
            clk:in std_logic;
            rst:in std_logic;
            q:out std_logic);
  
  

end component;

component fifo_ctrl is
  Port (rd: in std_logic;
            wr: in std_logic;
            clk: in std_logic;
            rst: in std_logic;
            rdinc: out std_logic;
            wrinc: out std_logic;
            empty: out std_logic;
            full: out std_logic
             );
  
   
end component;

component fifo8x8 is
 Port (  data_in:in std_logic_vector(7 downto 0);
            rd: in std_logic;
            wr: in std_logic;
            clk: in std_logic;
            rst: in std_logic;
            rdinc: in std_logic;
            wrinc: in std_logic;
            data_out:out std_logic_vector(7 downto 0));
 
 

 

end component;

component disp_7seg is
Port (  clk, rst : in std_logic;
		    data : in std_logic_vector (15 downto 0);
		    sseg : out std_logic_vector (6 downto 0);
		    an : out std_logic_vector (3 downto 0));


end component;

signal read,write,rdINCs,wrINCs:std_logic;
signal data_out8x8:std_logic_vector(15 downto 0):=x"0000";
begin
        
        c1: filtr port map(btn_rd,clk,rst,read);
        c2: filtr port map(btn_wr,clk,rst,write);
        c3: fifo_ctrl port map(read,write,clk,rst,rdINCs,wrINCs,empty,full);
        c4:fifo8x8 port map(data_in, read, write, clk, rst, rdIncs, wrIncs, data_out8x8(7 downto 0));
        c5:disp_7seg port map(clk,rst,data_out8x8,sseg,an);
        

end Behavioral;
