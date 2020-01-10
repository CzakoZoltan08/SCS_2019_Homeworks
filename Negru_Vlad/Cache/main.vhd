----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 01/07/2020 07:40:58 PM
-- Design Name: 
-- Module Name: main - Behavioral
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

entity main is
 -- Port ();
end main;

architecture Behavioral of main is
component Comparator is
  Port (A: in std_logic_vector(19 downto 0);
        B: in std_logic_vector(19 downto 0);
        res: out std_logic
  
   );
end component Comparator;
component BigRam is
  Port (A: in std_logic_vector(31 downto 0);
        D: inout std_logic_vector(63 downto 0);
        CS: in std_logic;
        Write:in std_logic
   );
end component BigRam;
component ControlUnit is
  Port (Match1: in std_logic;
        Match2: in std_logic;
        CS1: out std_logic;
        CS2: out std_logic;
        WR1: out std_logic;
        WR2: out std_logic;
        CSBig: out std_logic;
        WRBig: out std_logic
   );
end component ControlUnit;
component DataRam is
  Port (A: in std_logic_vector(8 downto 0);
        D: inout std_logic_vector(63 downto 0);
        CS: in std_logic;
        Write:in std_logic
        --WriteData: in std_logic_vector(63 downto 0)
  
   );
end component DataRam;

component TagRam is
Port ( A: in std_logic_vector(8 downto 0);
       D: out std_logic_vector(19 downto 0);
       Write: in std_logic;
       WriteData: in std_logic_vector(19 downto 0)

 );
end component TagRam;

signal dataBus : std_logic_vector(63 downto 0):=(others=>'Z');
signal addressBus: std_logic_vector(31 downto 0):=(others => 'Z');
signal MATCH1, MATCH2:std_logic;
signal Tag1, Tag2: std_logic_vector(19 downto 0);
signal WR1, WR2, WRBig: std_logic;   
signal CS1, CS2, CSBig: std_logic;
signal TagAddr: std_logic_vector(19 downto 0);
signal IndexAddr: std_logic_vector(8 downto 0);


begin
   Comp1: Comparator port map(Tag1, addressBus(31 downto 12), MATCH1);
   Comp2: Comparator port map(Tag2, addressBus(31 downto 12), MATCH2);
   TagMem1: TagRam port map(addressBus(11 downto 3), Tag1, WR1, addressBus(31 downto 12));
   TagMem2: TagRam port map(addressBus(11 downto 3), Tag2, WR2, addressBus(31 downto 12));
   DataMem1: DataRam port map(addressBus(11 downto 3), dataBus, CS1, WR1);
   DataMem2: DataRam port map(addressBus(11 downto 3), dataBus, CS2, WR2);
   BigMem0: BigRam port map(addressBus, dataBus, CSBig, WRBig);
   CU: ControlUnit port map(MATCH1, MATCH2, CS1, CS2, WR1, WR2, CSBig, WRBig);
   
   TagAddr <= addressBus(31 downto 12);
   IndexAddr <= addressBus(11 downto 3);
   

   
   
   process
   begin
  wait for 20ns;
   addressBus <= x"00000000";

   wait for 20ns;
   addressBus <= x"00000008";
 
   wait for 20ns;
   addressBus <= x"00000010";

   wait for 20ns;
   addressBus<=  x"00000018";
   
   wait for 20ns;
   addressBus<=  x"00000020";
   
   wait for 20ns;
   addressBus<=  x"00001000";
   
   wait for 20ns;
   addressBus<=  x"00000000";
   
   wait ;
   end process;
end Behavioral;
