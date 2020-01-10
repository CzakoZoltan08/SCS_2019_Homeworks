----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/20/2019 04:52:10 PM
-- Design Name: 
-- Module Name: ControlUnit - Behavioral
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
--FSM
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ControlUnit is
  Port (clk:in std_logic;
        reset:in std_logic;
        ena:in std_logic;
        opcode:in std_logic_vector(5 downto 0);
        IORD, wrMem, irWrite, writeMemReg, RegWrite, MemToReg, RegDst, RegAWr, RegBWr, AluSrcA, AluResWr, PCWr:out std_logic;
        AluSrcB:out std_logic_vector(1 downto 0);
        AluOp:out std_logic_vector(1 downto 0);
        func:in std_logic_vector(5 downto 0);
        stateNr: out std_logic_vector(3 downto 0)
   );
end ControlUnit;

architecture Behavioral of ControlUnit is
type MOORE_FSM is (IFetch, IDecode, ExecuteR, ExecuteMem, RMem, LoadMem, StoreMem, WriteBack);
signal current_state, next_state: MOORE_FSM;
    
begin
process(clk,reset)
begin
 if(reset='1') then
  current_state <= IFetch;
 elsif(rising_edge(clk)) then
    if(ena = '1') then
  current_state <= next_state;
  end if;
 end if;
end process;

process(current_state,opcode)
begin
 case(current_state) is
 when IFetch =>
  next_state <= IDecode;
  
  
 when IDecode =>
  if(opcode = "000000") then
   
   next_state <= ExecuteR;
  else
   next_state <= ExecuteMem;
  end if;  
  
 when ExecuteR => 
    next_state <=  RMem;
    
 when RMem =>
 
   next_state <= IFetch;
  
 when ExecuteMem =>
    if(opcode(3) = '1') then next_state <= StoreMem;
    else next_state <= LoadMem;
    end if;
 
 when StoreMem => next_state <= IFetch;
 when LoadMem => next_state <= WriteBack;
 when WriteBack => next_state <= IFetch;
 
 end case;
end process;


process(current_state, func)
begin 
 case current_state is
 when IFetch =>
  IORD <= '0';
  wrMem <= '0';
  irWrite <= '1';
  writeMemReg <= '0';
  RegWrite <='0';
  MemToReg <='0';
  RegDst <= '0';
  RegAWr <= '0';
  RegBWr <= '0';
  AluSrcA <='0';
  AluSrcB <="01";
  AluResWr <= '0';
  PCWr <='1';
  AluOp<="00";
  stateNr <= "0000";
 when IDecode =>
    IORD <= '0';
   wrMem <= '0';
   irWrite <= '0'; 
   writeMemReg <= '0';
   RegWrite <='0';
   MemToReg <='0';
   RegDst <= '0';
   RegAWr <= '1';
   RegBWr <= '1';
   AluSrcA <='0';
   AluSrcB <="00";
   AluResWr <= '0';
   PCWr <='0';
   AluOp<="00";
   stateNr <= "0001";
    
 
 when ExecuteR => 
   IORD <= '0';
  wrMem <= '0';
  irWrite <= '0';
  writeMemReg <= '0';
  RegWrite <='0';
  MemToReg <='0';
  RegDst <= '0';
  RegAWr <= '0';
  RegBWr <= '0';
  AluSrcA <='1';
  AluSrcB <="00";
  AluResWr <= '1';
  PCWr <='0';
  case func is
  when "100000" =>  AluOp <= "00";
  when "100010" =>  AluOp <= "01";
  when "100100" =>  AluOp <= "10";
  when others => AluOp<="11";
  end case;
  stateNr<="0010";

  
 when RMem =>
IORD <= '0';
wrMem <= '0';
irWrite <= '0';
writeMemReg <= '0';
RegWrite <='1';
MemToReg <='0';
RegDst <= '1';
RegAWr <= '0';
RegBWr <= '0';
AluSrcA <='0';
AluSrcB <="00";
AluResWr <= '0';
PCWr <='0';
AluOp<="00";
stateNr<="0100";

 when ExecuteMem =>
 IORD <= '0';
 wrMem <= '0';
 irWrite <= '0';
 writeMemReg <= '0';
 RegWrite <='0';
 MemToReg <='0';
 RegDst <= '0';
 RegAWr <= '0';
 RegBWr <= '0';
 AluSrcA <='1';
 AluSrcB <="10";
 AluResWr <= '1';
 PCWr <='0';
 AluOp<="00";
 stateNr<="0011";
 
when LoadMem =>
 IORD <= '1';
wrMem <= '0';
irWrite <= '0';
writeMemReg <= '1';
RegWrite <='0';
MemToReg <='0';
RegDst <= '0';
RegAWr <= '0';
RegBWr <= '0';
AluSrcA <='0';
AluSrcB <="00";
AluResWr <= '0';
PCWr <='0';
AluOp<="00";
stateNr<="0101";

when StoreMem =>
 IORD <= '1';
wrMem <= '1';
irWrite <= '0';
writeMemReg <= '0';
RegWrite <='0';
MemToReg <='0';
RegDst <= '0';
RegAWr <= '0';
RegBWr <= '0';
AluSrcA <='0';
AluSrcB <="00";
AluResWr <= '0';
PCWr <='0';
AluOp<="00";
stateNr<="0110";
 
 when WriteBack =>
 IORD <= '0';
wrMem <= '0';
irWrite <= '0';
writeMemReg <= '0';
RegWrite <='1';
MemToReg <='1';
RegDst <= '0';
RegAWr <= '0';
RegBWr <= '0';
AluSrcA <='0';
AluSrcB <="00";
AluResWr <= '0';
PCWr <='0';
AluOp<="00";
stateNr<="0111";
 end case;
end process;

end Behavioral;
