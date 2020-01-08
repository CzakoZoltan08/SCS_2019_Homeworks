library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity IDecode is
	Port ( clk: in std_logic;
	        PCOutput: in std_logic_vector(31 downto 0);
			Instruction: in std_logic_vector(31 downto 0);
			WriteAddress:in std_logic_vector(4 downto 0);
			WriteData: in std_logic_vector(31 downto 0);
			RegWrite: in std_logic;
			enable: in std_logic;
			ExtOp: in std_logic;
			ReadData1: out std_logic_vector(31 downto 0);
			ReadData2: out std_logic_vector(31 downto 0);
			ExtImm : out std_logic_vector(31 downto 0);
			Func : out std_logic_vector(5 downto 0);
			SA : out std_logic_vector(4 downto 0);		
			JumpAddress: out std_logic_vector(31 downto 0));
end IDecode;

architecture Behavioral of IDecode is

component reg_file is
    Port (	clk : in std_logic;
			ReadAddress1 : in std_logic_vector (4 downto 0);
			ReadAddress2 : in std_logic_vector (4 downto 0);
			WriteAddress : in std_logic_vector (4 downto 0);
			WriteData : in std_logic_vector (31 downto 0);
			RegWrite : in std_logic;
			enable: in std_logic;
			ReadData1 : out std_logic_vector (31 downto 0);
			ReadData2 : out std_logic_vector (31 downto 0));
end component;

signal ReadAddress1: std_logic_vector(4 downto 0);
signal ReadAddress2: std_logic_vector(4 downto 0);

begin

RF1: reg_file port map (clk => clk, ReadAddress1 => ReadAddress1, ReadAddress2 => ReadAddress2,WriteAddress => WriteAddress,WriteData => WriteData,RegWrite => RegWrite,enable => enable,ReadData1 => ReadData1,ReadData2 => ReadData2);

process(ExtOp,Instruction)   
begin
	case (ExtOp) is
		when '1' => 	
				case (Instruction(15)) is
					when '0' => ExtImm <= B"0000000000000000" & Instruction(15 downto 0);
					when '1' =>  ExtImm <=	B"1111111111111111" & Instruction(15 downto 0);
				end case;
		when others => ExtImm <= B"0000000000000000" & Instruction(15 downto 0);
	end case;
end process;


	
Func<=Instruction(5 downto 0);	                
SA<=Instruction(10 downto 6);					           				            

ReadAddress1<=Instruction(25 downto 21);		
ReadAddress2<=Instruction(20 downto 16);		

JumpAddress<= "0000000000000000" & Instruction(15 downto 0);	

end Behavioral;
