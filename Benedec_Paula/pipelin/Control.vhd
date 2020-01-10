----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 27.11.2019 00:02:35
-- Design Name: 
-- Module Name: Control - Behavioral
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

entity Control is
  Port (clk: in std_logic;
        rst: in std_logic;
        en:in std_logic;
        opcode: in std_logic_vector(5 downto 0);
        funct:in std_logic_vector(5 downto 0);
        IORD:out std_logic;
        RegDst:out std_logic;
        MemToReg:out std_logic;
        MEM_WRITE:out std_logic; 
        RegWrite:out std_logic; 
        IRWrite:out std_logic; 
        ALUSrcA:out std_logic; 
        ALU_EN:out std_logic; 
        PC_EN:out std_logic;
        A_EN:out std_logic; 
        B_EN:out std_logic; 
        wrEn_MR:out std_logic;
        ALUSrcB:out std_logic_vector(1 downto 0); 
        ALUOp:out std_logic_vector(1 downto 0)
        
         );
end Control;

architecture Behavioral of Control is
type MOORE_FSM is (IFetch, IDecode, ExecuteR,MemoryR, ExecuteMem, LoadMem, StoreMem, WriteBack);
signal current_state, next_state: MOORE_FSM;

begin
-- Sequential memory of the VHDL MOORE FSM Sequence Detector
process(clk,rst)
begin
 if(rst='1') then
  current_state <= IFetch;
 elsif(rising_edge(clk)) then
    if (en='1') then
  current_state <= next_state;
 end if;
 end if;
end process;
-- Next state logic of the VHDL MOORE FSM Sequence Detector
-- Combinational logic
process(current_state,opcode)
begin
 case(current_state) is
 when IFetch =>
   next_state <= IDecode;
   
 when IDecode =>
  if(opcode="000000") then
   -- "10"
   next_state <= ExecuteR;
  else
   next_state <= ExecuteMem;
  end if;  
 when ExecuteR => 

   next_state <= MemoryR;

 when MemoryR =>

   next_state <= IFetch;

 when ExecuteMem =>
  if(opcode(3) = '1') then 
        next_state <= StoreMem;
     else 
        next_state <= LoadMem;
     end if;
  when LoadMem =>
            next_state <= WriteBack;
   when StoreMem =>
            next_state <= IFetch; 
    when WriteBack=>
         next_state <= IFetch;             
     
 end case;
end process;
-- Output logic of the VHDL MOORE FSM Sequence Detector
process(current_state, funct)
begin 
 case current_state is
 when IFetch =>
  IORD <= '0';
  MEM_WRITE <= '0';
  irWrite <= '1';
  wrEn_MR <= '0';
  RegWrite <='0';
  MemToReg <='0';
  RegDst <= '0';
  A_EN <= '0';
  B_EN <= '0';
  AluSrcA <='0';
  AluSrcB <="01";
  ALU_EN <= '0';
  PC_EN <='1';
  AluOp<="00";
 when IDecode =>
    IORD <= '0';
   MEM_WRITE <= '0';
   irWrite <= '0'; 
   wrEn_MR <= '0';
   RegWrite <='0';
   MemToReg <='0';
   RegDst <= '0';
   A_EN <= '1';
   B_EN <= '1';
   AluSrcA <='0';
   AluSrcB <="00";
   ALU_EN <= '0';
   PC_EN <='0';
   AluOp<="00";

 
 when ExecuteR => 
   IORD <= '0';
  MEM_WRITE <= '0';
  irWrite <= '0';
  wrEn_MR <= '0';
  RegWrite <='0';
  MemToReg <='0';
  RegDst <= '0';
  A_EN <= '0';
  B_EN <= '0';
  AluSrcA <='1';
  AluSrcB <="00";
  ALU_EN <= '1';
  PC_EN <='0';
  case funct is
  when "100000" =>  AluOp <= "00";
  when "100010" =>  AluOp <= "01";
  when "100101" =>AluOp<="11";
  when others =>  AluOp <= "10";
  end case;

  
 when MemoryR =>
IORD <= '0';
MEM_WRITE <= '0';
irWrite <= '0';
wrEn_MR <= '0';
RegWrite <='1';
MemToReg <='0';
RegDst <= '1';
A_EN <= '0';
B_EN <= '0';
AluSrcA <='0';
AluSrcB <="00";
ALU_EN <= '0';
PC_EN <='0';
AluOp<="00";

 when ExecuteMem =>
 IORD <= '0';
 MEM_WRITE <= '0';
 irWrite <= '0';
 wrEn_MR <= '0';
 RegWrite <='0';
 MemToReg <='0';
 RegDst <= '0';
 A_EN <= '0';
 B_EN <= '0';
 AluSrcA <='1';
 AluSrcB <="10";
 ALU_EN <= '1';
 PC_EN <='0';
 AluOp<="00";
 
 
when LoadMem =>
 IORD <= '1';
MEM_WRITE <= '0';
irWrite <= '0';
wrEn_MR <= '1';
RegWrite <='0';
MemToReg <='0';
RegDst <= '0';
A_EN <= '0';
B_EN <= '0';
AluSrcA <='0';
AluSrcB <="00";
ALU_EN <= '0';
PC_EN <='0';
AluOp<="00";

when StoreMem =>
 IORD <= '1';
MEM_WRITE <= '1';
irWrite <= '0';
wrEn_MR <= '0';
RegWrite <='0';
MemToReg <='0';
RegDst <= '0';
A_EN <= '0';
B_EN <= '0';
AluSrcA <='0';
AluSrcB <="00";
ALU_EN <= '0';
PC_EN <='0';
AluOp<="00";
 
 when WriteBack =>
 IORD <= '0';
MEM_WRITE <= '0';
irWrite <= '0';
wrEn_MR <= '0';
RegWrite <='1';
MemToReg <='1';
RegDst <= '0';
A_EN <= '0';
B_EN <= '0';
AluSrcA <='0';
AluSrcB <="00";
ALU_EN <= '0';
PC_EN <='0';
AluOp<="00";
 end case;
end process;
end Behavioral;