library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity ExecutionUnit is
Port(
    Instruction: in std_logic_vector(31 downto 0);
	PCIncremented:in std_logic_vector(31 downto 0);
	RD1: in std_logic_vector(31 downto 0);
	RD2: in std_logic_vector(31 downto 0);
	Ext_Imm: in std_logic_vector(31 downto 0);
	Func: in std_logic_vector(5 downto 0);
	SA: in std_logic_vector(4 downto 0);
	ALUSrc: in std_logic;
	ALUOp: in std_logic_vector(2 downto 0);
	RegDst: in std_logic; 
	BranchAddress: out std_logic_vector(31 downto 0);
	ALURes: out std_logic_vector(31 downto 0);
	Zero: out std_logic;
	WriteAddress: out std_logic_vector(4 downto 0));

end ExecutionUnit;

architecture Behavioral of ExecutionUnit is

signal SecondOperand:std_logic_vector(31 downto 0);
signal ALUControl: std_logic_vector(3 downto 0);
signal ALUResInternal:std_logic_vector(31 downto 0);

begin
	
process(ALUSrc,RD2,Ext_Imm)
begin
    if ALUSrc = '0' then SecondOperand <= RD2;
    else SecondOperand <= Ext_Imm;
    end if;
end process;			  

process(ALUOp,Func)
begin
	case (ALUOp) is
		when "000"=>
				case (Func) is
					when "000000"=> ALUControl<="0000"; 	   
					when "000001"=> ALUControl<="0001";		
					when "000010"=> ALUControl<="0010";		
					when "000011"=> ALUControl<="0011";		
					when "000100"=> ALUControl<="0100";		
					when "000101"=> ALUControl<="0101";		
					when "000110"=> ALUControl<="0110";		
					when "000111"=> ALUControl<="0111";		
					when others=> ALUControl<="0000";	    
				end case;
		when "001"=> ALUControl<="0000";
		when "010"=> ALUControl<="0001";		
		when "101"=> ALUControl<="0100";		
		when "110"=> ALUControl<="0101";		
		when "111"=> ALUControl<="1000";		
		when others=> ALUControl<="0000";	
	end case;
end process;

process(ALUControl,RD1,SecondOperand,SA)
begin
	case(ALUControl) is
		when "0000" => ALUResInternal<=RD1+SecondOperand;     			
		when "0001" => ALUResInternal<=RD1-SecondOperand;	 					
		when "0010" => 	case (SA) is
						  --when '1' => ALUResInternal<=RD1(14 downto 0) & "0";
						  when others => ALUResInternal<=RD1;	
					end case;		
		when "0011" => 	case (SA) is
						  --when '1' => ALUResInternal<="0" & RD1(15 downto 1);
						  when others => ALUResInternal<=RD1;
					end case;					
		when "0100" => ALUResInternal<=RD1 and SecondOperand;							
		when "0101" => ALUResInternal<=RD1 or SecondOperand;									
		when "0110" => ALUResInternal<=RD1 xor SecondOperand;					
		when "0111" => if RD1<SecondOperand then
						  ALUResInternal<=X"00000001";
					   else ALUResInternal<=X"00000000";
					   end if;		
		when "1000" => ALUResInternal<=X"00000000";				
		when others => ALUResInternal<=X"00000000";		
	end case;

	case (ALUResInternal) is					        
		when X"00000000" => Zero <= '1';
		when others =>      Zero <= '0';
	end case;

end process;

process(RegDst,Instruction)	
begin
	case (RegDst) is
		when '0' => WriteAddress<=Instruction(20 downto 16);
		when '1'=>WriteAddress<=Instruction(15 downto 11);
	end case;
end process;

ALURes <= ALUResInternal;
BranchAddress<=PCIncremented+Ext_Imm ;

end Behavioral;

