----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/10/2019 10:15:47 PM
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ControlUnit is
  Port ( opcode:in std_logic_vector(5 downto 0);
        func:in std_logic_vector(5 downto 0);
        RegWrite:out std_logic;
        RegDst:out std_logic;
        AluSrc:out std_logic;
        AluOp: out std_logic_vector(1 downto 0);
        MemWrite:out std_logic;
        MemToReg:out std_logic
  
  
  );
end ControlUnit;

architecture Behavioral of ControlUnit is

begin

process(opcode, func)
begin
case opcode is
when "000000" =>
    RegWrite<='1';
    RegDst<='1';
    AluSrc<='0';
    MemWrite<='0';
    MemToReg<='1';
    case func is
       when "100000" => AluOp <="00";
       when "100010" => AluOp <="01";
       when "100100" => AluOp <="10";
       when others => AluOp <="11";
    end case;

when "100011" =>
    RegWrite<='1';
    RegDst<='0';
    AluSrc<='1';
    MemWrite<='0';
    MemToReg<='0';
    AluOp<="00";
when others =>
    RegWrite<='0';
    RegDst<='0';
    AluSrc<='1';
    MemWrite<='1';
    MemToReg<='0';
    AluOp<="00";
end case;
end process;

end Behavioral;
