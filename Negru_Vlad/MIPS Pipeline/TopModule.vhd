----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2019 11:37:24 PM
-- Design Name: 
-- Module Name: TopModule - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TopModule is
      Port ( clk : in STD_LOGIC;
 btn : in STD_LOGIC_VECTOR (4 downto 0);
 sw : in STD_LOGIC_VECTOR (15 downto 0);
 led : out STD_LOGIC_VECTOR (15 downto 0);
 an : out STD_LOGIC_VECTOR (3 downto 0);
 cat : out STD_LOGIC_VECTOR (6 downto 0)
 );
end TopModule;

architecture Behavioral of TopModule is
component alu IS
PORT (
a, b : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
opcode : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
result : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
zero : OUT STD_LOGIC);
END component alu;

component regfile IS
PORT (clk,rst_n : IN std_logic;
wen : IN std_logic; -- write control
writeport : IN std_logic_vector(31 DOWNTO 0); -- register input
adrwport : IN std_logic_vector(4 DOWNTO 0);-- address write
adrport0 : IN std_logic_vector(4 DOWNTO 0);-- address port 0
adrport1 : IN std_logic_vector(4 DOWNTO 0);-- address port 1
readport0 : OUT std_logic_vector(31 DOWNTO 0); -- output port 0
readport1 : OUT std_logic_vector(31 DOWNTO 0) -- output port 1
);
END component regfile;

component pc IS
PORT (
clk : IN STD_LOGIC;
rst_n : IN STD_LOGIC;
pc_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
PC_en : IN STD_LOGIC;
pc_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) );
END component pc; 

component DataMemory is
Port (
    clk:in std_logic;
     MemWrite: in std_logic;
     AluResIn:in std_logic_vector(31 downto 0);
     WriteData: in std_logic_vector(31 downto 0);
     MemData: out std_logic_vector(31 downto 0);
     AluResOut: out std_logic_vector(31 downto 0)
);
end component DataMemory;

component ControlUnit is
  Port ( opcode:in std_logic_vector(5 downto 0);
        func:in std_logic_vector(5 downto 0);
        RegWrite:out std_logic;
        RegDst:out std_logic;
        AluSrc:out std_logic;
        AluOp: out std_logic_vector(1 downto 0);
        MemWrite:out std_logic;
        MemToReg:out std_logic
  
  
  );
end component ControlUnit;
component SegDisp is
Port ( 
    clk:in std_logic;
   
    CAT: out std_logic_vector(6 downto 0);
    AN:out std_logic_vector(3 downto 0);
    Digit0:in std_logic_vector(3 downto 0);
    Digit1:in std_logic_vector(3 downto 0);
    Digit2:in std_logic_vector(3 downto 0);
    Digit3:in std_logic_vector(3 downto 0)
);
end component SegDisp;
component debouncer is
Port(
    clk:in STD_LOGIC;
    btn:in STD_LOGIC;
    Enable:out STD_LOGIC
    
);
end component debouncer;

component Rom is
  Port (
     Addr:in std_logic_vector(31 downto 0);
    Digits:out std_logic_vector(31 downto 0)
   
   );
end component Rom;


signal reset, enable:std_logic;
signal PCOut, AdderRes:std_logic_vector(31 downto 0):=(others => '0');
signal Instr:std_logic_vector(31 downto 0):=(others => '0');
signal IF_ID:std_logic_vector(31 downto 0):=(others => '0');

signal RegWrite,RegDst,AluSrc,MemWrite,MemToReg:std_logic;
signal AluOp:std_logic_vector(1 downto 0);
signal RD1, RD2:std_logic_vector(31 downto 0):=(others => '0');
signal imm:std_logic_vector(31 downto 0):=(others => '0');
signal Data:std_logic_vector(31 downto 0):=(others => '0');
signal MemData:std_logic_vector(31 downto 0):=(others => '0');
signal AluResOut:std_logic_vector(31 downto 0):=(others => '0');
signal AluIn2:std_logic_vector(31 downto 0):=(others => '0');
signal AluRes:std_logic_vector(31 downto 0):=(others => '0');
signal ZeroDet:std_logic;
signal ID_EX:std_logic_vector(112 downto 0):=(others => '0');
signal EX_MEM:std_logic_vector(71 downto 0):=(others => '0');
signal MEM_WB:std_logic_vector(70 downto 0):=(others => '0');
signal WriteRegAddr:std_logic_vector(4 downto 0):=(others => '0');
signal digit:std_logic_vector(15 downto 0);
signal digit32:std_logic_vector(31 downto 0);
signal regWriteEn:std_logic;
signal MemWriteEn:std_logic;
begin


dbReseT: debouncer port map(clk, btn(1), reset);
dbEnable: debouncer port map(clk, btn(0), enable);
PcComp: PC port map(clk, reset, AdderRes, enable, PCOut);
AdderRes <= 1 + PCOut;

RomComp: Rom port map(PCOut, Instr);

IFIDPROC: process(clk, reset)
begin 
if(reset = '1') then IF_ID <= (others => '0');
elsif (rising_edge(clk)) then
    if(enable = '1') then
        IF_ID <= Instr;
    end if;
end if;
end process;

ControlUnitComp: ControlUnit port map(IF_ID(31 downto 26), IF_ID(5 downto 0),
        RegWrite,
        RegDst,
        AluSrc,
        AluOp,
        MemWrite,
        MemToReg);

RegWriteEn <= MEM_WB(70) and enable;
 RegFileComp: regfile port map(clk, reset, RegWriteEn, Data, MEM_WB(68 downto 64), IF_ID(25 downto 21),
 IF_ID(20 downto 16), RD1, RD2);
 
 imm <= x"0000" & IF_ID(15 downto 0);

IDEXPROC: process(clk, reset)
begin 
if(reset = '1') then ID_EX <= (others => '0');
elsif (rising_edge(clk)) then
    if(enable = '1') then
        ID_EX(31 downto 0) <= RD1;
        ID_EX(63 downto 32) <= RD2;
        ID_EX(95 downto 64) <= imm;
        ID_EX(100 downto 96) <=IF_ID(20 downto 16);
        ID_EX(105 downto 101) <= IF_ID(15 downto 11);
        ID_EX(106) <= AluSrc;
        ID_EX(107) <= RegDst;
        ID_EX(109 downto 108) <= AluOp;
        ID_EX(110) <=MemWrite;
        ID_EX(111) <= MemToReg;
        ID_EX(112) <= RegWrite;
    end if;
end if;
end process;

AluIn2 <= ID_EX(63 downto 32) when ID_EX(106) = '0'
else ID_EX(95 downto 64);

AluComp: alu port map(ID_EX(31 downto 0), AluIn2, ID_EX(109 downto 108), AluRes, ZeroDet); 

WriteRegAddr <= ID_EX(100 downto 96) when ID_EX(107) = '0'
else ID_EX(105 downto 101);

EXMEMPROC: process(clk, reset)
begin 
if(reset = '1') then EX_MEM <= (others => '0');
elsif (rising_edge(clk)) then
    if(enable = '1') then
        EX_MEM(31 downto 0) <= AluRes;
        EX_MEM(63 downto 32) <= ID_EX(63 downto 32);
        EX_MEM(68 downto 64) <= WriteRegAddr;
        EX_MEM(69) <= ID_EX(110);
        EX_MEM(70) <= ID_EX(111);
        EX_MEM(71) <= ID_EX(112);
    end if;
end if;
end process;

MemWriteEn <= EX_MEM(69) and enable;
DataMemoryComp: DataMemory port map(clk, MemWriteEn, EX_MEM(31 downto 0), EX_MEM(63 downto 32),
  MemData, AluResOut);
  
MEMWBPROC: process(clk, reset)
  begin 
  if(reset = '1') then MEM_WB <= (others => '0');
  elsif (rising_edge(clk)) then
      if(enable = '1') then
         MEM_WB(31 downto 0) <= MemData;
         MEM_WB(63 downto 32) <= AluResOut;
         MEM_WB(68 downto 64) <=   EX_MEM(68 downto 64);
         MEM_WB(69) <=  EX_MEM(70);
         MEM_WB(70) <=  EX_MEM(71);
      end if;
  end if;
  end process;

Data <= MEM_WB(31 downto 0) when MEM_WB(69) = '0'
else MEM_WB(63 downto 32);


SSDComp: SegDisp port map(clk, cat, an, digit(3 downto 0), digit(7 downto 4), digit(11 downto 8),
digit(15 downto 12));

digit <= digit32(15 downto 0) when sw(15) ='0'
else digit32(31 downto 16);

    led(15)<=    RegWrite;
    led(14)<=     RegDst;
    led(13)<=     AluSrc;
    led(12 downto 11)<=     AluOp;
    led(10)<=     MemWrite;
    led(9)<=     MemToReg;
    
    
digit32<= PCOut when sw(3 downto 0) = "0000"
else Instr when sw(3 downto 0) = "0001"
else RD1 when sw(3 downto 0) = "0010"
else RD2 when sw(3 downto 0) = "0011"
else imm when sw(3 downto 0) = "0100"
else AluRes when sw(3 downto 0) = "0101"
else Data when sw(3 downto 0) = "0110"
else x"000000" & "000" & MEM_WB(68 downto 64);

end Behavioral;
