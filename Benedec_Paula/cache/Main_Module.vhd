----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/07/2020 08:20:17 PM
-- Design Name: 
-- Module Name: Main_Module - Behavioral
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

entity Main_Module is
 -- Port ( );
end Main_Module;


architecture Behavioral of Main_Module is
component Control_Unit is
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
end component;

component Main_MEM is
         Port ( a: in std_logic_vector(31 downto 0);
                cs:in std_logic;
                wrEn: in std_logic;
                dout:inout std_logic_vector(63 downto 0)
                 );
end component;

component RAM_DATA is
          Port ( a:in std_logic_vector(8 downto 0);
                 cs: in std_logic;
                 wrEn: in std_logic;
                 dout:inout std_logic_vector(63 downto 0) );
end component;

component RAM_TAG is
         Port ( a:in std_logic_vector(8 downto 0);
                wrEn: in std_logic;
                writeData:in std_logic_vector(19 downto 0);
                dout:out std_logic_vector(19 downto 0)
                
                 );
end component;

component  Comparator is
     Port (
        a:in std_logic_vector(19 downto 0); 
        b:in std_logic_vector(19 downto 0);
        c:out std_logic );
end component;


signal Address_bus:std_logic_vector(31 downto 0);
signal Data_bus: std_logic_vector(63 downto 0):=(others =>'Z');
signal dataout1:std_logic_vector(19 downto 0);
signal dataout2:std_logic_vector(19 downto 0);

signal  match1:std_logic;
 signal   match2: std_logic;
 signal   wrEnMain: std_logic;
  signal   wrEn1: std_logic;
  signal wrEn2: std_logic;
  signal csMain: std_logic;
 signal  cs1: std_logic;
  signal  cs2: std_logic;

begin
        t1: RAM_TAG port map(a=>Address_bus(11 downto 3),
                            wrEn=>wrEn1,
                            writeData=>Address_bus(31 downto 12),
                            dout=>dataout1);
        t2: RAM_TAG port map(a=>Address_bus(11 downto 3),
                            wrEn=>wrEn2,
                            writeData=>Address_bus(31 downto 12),
                            dout=>dataout2);
                            
      c1: Comparator port map(a=>Address_bus(31 downto 12),
                              b=>dataout1,
                              c=>match1);                      
      c2: Comparator port map(a=>Address_bus(31 downto 12),
                              b=>dataout2,
                              c=>match2 );   
                              
      d1: RAM_DATA port map(a=>Address_bus(11 downto 3),
                            cs=>cs1,
                            wrEn=>wrEn1,
                            dout=>Data_bus);                                           
      d2: RAM_DATA port map(a=>Address_bus(11 downto 3),
                            cs=>cs2,
                            wrEn=>wrEn2,
                            dout=>Data_bus);    
      
      mm:Main_MEM port map( a=>Address_bus(31 downto 0),
                            cs=>csMain,
                            wrEn=>wrEnMain,
                            dout=>data_bus
                 );   
                 
   cu: Control_Unit port map(
               match1=>match1,
               match2=>match2,
               wrEnMain=>WrEnMain,
               wrEn1=>wrEn1,
               wrEn2=>wrEn2,
               csMain=>csMain,
               cs1=>cs1,
               cs2=>cs2);  
               
   
   process
   begin
            Address_bus<=(others=>'Z');
            wait for 20 ns;
            Address_bus<=x"00000000";
            wait for 20 ns;
            Address_bus<=x"00000008";
            wait for 20 ns;
            Address_bus<=x"00000010";
            wait for 20 ns;
            Address_bus<=x"00000018";
            wait for 20 ns;
            Address_bus<=x"00000020";
            wait for 20 ns;
            Address_bus<=x"00000028";
            wait for 20 ns;
            
            Address_bus<=x"00000010";
            wait for 20 ns;
   
   end process;                                                            
end Behavioral;
