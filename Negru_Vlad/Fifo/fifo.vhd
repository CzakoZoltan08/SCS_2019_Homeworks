----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/30/2019 06:59:08 PM
-- Design Name: 
-- Module Name: fifo - Behavioral
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

entity fifo is
  Port (
    data_in: in std_logic_vector(7 downto 0);
    btn_rd: in std_logic;
    btn_wr:in std_logic;
    clk:in std_logic;
    reset:in std_logic;
    sseg:out std_logic_vector(6 downto 0);
    anod:out std_Logic_vector(3 downto 0);
    empty: out std_logic;
    full: out std_logic
  
  
   );
end fifo;

architecture Behavioral of fifo is
component filter is
  Port (
    clk:in std_logic;
    reset:in std_logic;
    d_in:in std_logic;
    q_out:out std_logic
  
  
   );
end component;

component fifoCtrl is
  Port (
    rd:in std_logic;
    wr: in std_logic;
    clk:in std_logic;
    reset:in std_logic;
    rdInc:out std_logic;
    wrInc:out std_logic;
    empty:out std_logic;
    full:out std_logic
  
  
   );
end component;

component fifoMem is
 Port ( dataIn:in std_logic_vector(7 downto 0);
        rd:in std_logic;
        wr:in std_logic;
        rdinc:in std_logic;
        wrinc:in std_logic;
        clk:in std_logic;
        reset:in std_logic;
        dataOut:out std_logic_vector(7 downto 0)
 
 
 );
 

end component;

component displ_7seg is
Port ( 
    clk:in std_logic;
   
    CAT: out std_logic_vector(6 downto 0);
    AN:out std_logic_vector(3 downto 0);
    Digit0:in std_logic_vector(3 downto 0);
    Digit1:in std_logic_vector(3 downto 0);
    Digit2:in std_logic_vector(3 downto 0);
    Digit3:in std_logic_vector(3 downto 0)
);
end component;
 
 
signal rd_filter, wr_filter:std_logic;
signal rdIncBuffer, wrIncBuffer:std_logic;
signal dataOutBuffer:std_logic_vector(15 downto 0):="0000000000000000";

begin

filtRd: filter port map(clk, reset, btn_rd, rd_filter);
filtWr: filter port map(clk, reset, btn_wr, wr_filter);

control: fifoCtrl port map(rd_filter, wr_filter, clk, reset, rdIncBuffer, wrIncBuffer, empty, full);
memo: fifoMem port map(data_in, rd_filter, wr_filter, rdIncBuffer, wrIncBuffer, clk, reset, dataOutBuffer(7 downto 0));
seg: displ_7seg port map(clk, sseg, anod, dataOutBuffer(3 downto 0),dataOutBuffer(7 downto 4), dataOutBuffer(11 downto 8), dataOutBuffer(15 downto 12));


end Behavioral;
