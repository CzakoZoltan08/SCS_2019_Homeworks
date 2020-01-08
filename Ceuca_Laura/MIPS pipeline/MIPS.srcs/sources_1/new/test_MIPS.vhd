library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity test_env is
    Port ( clk : in  STD_LOGIC;
           btn : in  STD_LOGIC_VECTOR (3 downto 0);
           sw : in  STD_LOGIC_VECTOR (7 downto 0);
           led : out  STD_LOGIC_VECTOR (15 downto 0);
           an : out  STD_LOGIC_VECTOR (3 downto 0);
           cat : out  STD_LOGIC_VECTOR (6 downto 0));
end test_env;

architecture Behavioral of test_env is

component MPG is
	Port(btn: in STD_LOGIC;
    clk:in STD_LOGIC;
    en:out STD_LOGIC);
end component;

component SSD is
Port (  digits: in STD_LOGIC_VECTOR(15 DOWNTO 0);
		clk: in STD_LOGIC;
		an: out STD_LOGIC_VECTOR(3 DOWNTO 0);
		cat: out STD_LOGIC_VECTOR(6 DOWNTO 0));
end component;

component IFetch is
	Port (  enable : in std_logic;
			reset : in std_logic;
			clk: in std_logic;
			BranchAddress : in std_logic_vector(31 downto 0);
			JumpAddress : in std_logic_vector(31 downto 0);
			Jump : in std_logic;
			PCSrc : in std_logic;
			Instruction : out std_logic_vector(31 downto 0);
			PCOutput : out std_logic_vector(31 downto 0));
end component;

component IDecode is
	Port (  clk: in std_logic;
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
end component;

component ControlUnit is
Port	(    Instruction:in std_logic_vector(5 downto 0);
			 RegDst: out std_logic;
			 ExtOp: out std_logic;
			 ALUSrc: out std_logic;
			 Branch: out std_logic;
			 Jump: out std_logic;
			 ALUOp: out std_logic_vector(2 downto 0);
			 MemWrite: out std_logic;
			 MemtoReg: out std_logic;
			 RegWrite: out std_logic);
end component;

component ExecutionUnit is
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
end component;

component RAM is
	port(   clk: in std_logic;
			ALURes : in std_logic_vector(31 downto 0);
			WriteData: in std_logic_vector(31 downto 0);
			MemWrite: in std_logic;			
			enable: in std_logic;	
			Zero: in std_logic;
			Branch: in std_logic;
			MemoryData:out std_logic_vector(31 downto 0);
			PCSrc: out std_logic);
end component;

component pipeline_register is
    Port (	clk : in std_logic;
            enable: in std_logic;
			WriteAddress : in std_logic_vector (3 downto 0);
			WriteData : in std_logic_vector (31 downto 0);
			ReadAddress : in std_logic_vector (3 downto 0);
			ReadData : out std_logic_vector (31 downto 0));
end component;


signal RegDst: std_logic;
signal ExtOp: std_logic;
signal ALUSrc: std_logic;
signal Branch: std_logic;
signal Jump: std_logic;
signal ALUOp: std_logic_vector(2 downto 0);
signal MemWrite: std_logic;
signal MemtoReg: std_logic;
signal RegWrite: std_logic;


signal PCSrc: std_logic;
signal enable: STD_LOGIC;                                   
signal reset: STD_LOGIC;	                               
signal BranchAddress:std_logic_vector(31 downto 0);  	   
signal JumpAddress:std_logic_vector(31 downto 0); 		    
signal Instruction: std_logic_vector(31 downto 0);			    
signal PCOutput: std_logic_vector(31 downto 0);	


signal RD1: std_logic_vector(31 downto 0);					
signal RD2: std_logic_vector(31 downto 0);					
signal Ext_Imm : std_logic_vector(31 downto 0);				
signal Func :std_logic_vector(5 downto 0);					
signal SA : std_logic_vector(4 downto 0);		

												
signal ALURes: std_logic_vector(31 downto 0);	
signal ZeroSignal: std_logic;		 


signal MemoryData: std_logic_vector(31 downto 0);				
signal WriteData: std_logic_vector(31 downto 0);	


signal SSDOUT : std_logic_vector(15 downto 0):=X"0000";   

signal PC_ID:std_logic_vector(31 downto 0);
signal Instruction_ID:std_logic_vector(31 downto 0);

signal WB_signals_ID:std_logic_vector(31 downto 0);
signal M_signals_ID:std_logic_vector(31 downto 0);
signal EX_signals_ID:std_logic_vector(31 downto 0);

signal Instruction_EX:std_logic_vector(31 downto 0);
signal PC_EX:std_logic_vector(31 downto 0);
signal WB_signals_EX:std_logic_vector(31 downto 0);
signal M_signals_EX:std_logic_vector(31 downto 0);
signal EX_signals_EX:std_logic_vector(31 downto 0);

signal RD1_EX:std_logic_vector(31 downto 0);
signal RD2_EX:std_logic_vector(31 downto 0);
signal Ext_Imm_EX:std_logic_vector(31 downto 0);

signal funct_sa_ID:std_logic_vector(31 downto 0);
signal funct_sa_EX:std_logic_vector(31 downto 0);

signal WB_signals_MEM:std_logic_vector(31 downto 0);
signal M_signals_MEM:std_logic_vector(31 downto 0);
signal zero_signal_EX:std_logic_vector(31 downto 0);
signal zero_signal_MEM:std_logic_vector(31 downto 0);
signal ALURes_MEM:std_logic_vector(31 downto 0);
signal RD2_MEM:std_logic_vector(31 downto 0);
signal BranchAddress_MEM:std_logic_vector(31 downto 0);

signal WB_signals_WB:std_logic_vector(31 downto 0);
signal MemData_WB:std_logic_vector(31 downto 0);
signal ALURes_WB:std_logic_vector(31 downto 0);

signal WriteAddress : std_logic_vector(4 downto 0);
signal WriteAddress_MEM : std_logic_vector(4 downto 0);
signal WriteAddress_WB : std_logic_vector(4 downto 0);

signal WriteAddress_32 : std_logic_vector(31 downto 0);
signal WriteAddress_MEM_32 : std_logic_vector(31 downto 0);
signal WriteAddress_WB_32 : std_logic_vector(31 downto 0);

signal WriteData_WB: std_logic_vector(31 downto 0);


begin
--------------------------------------------------------------------------------------------------------------------------------------
IFetch_map: IFetch port map(enable=>enable,reset=>reset,clk=>clk,BranchAddress=>BranchAddress_MEM,JumpAddress=>JumpAddress,Jump=>Jump,PCSrc=>PCSrc,Instruction=>Instruction,PCOutput=>PCOutput);

IF_ID_0_map: pipeline_register port map(clk=>clk, enable => enable,WriteAddress => "0000",WriteData => PCOutput,ReadAddress => "0000",ReadData => PC_ID);
IF_ID_1_map: pipeline_register port map(clk=>clk, enable => enable,WriteAddress => "0001",WriteData => Instruction,ReadAddress => "0001",ReadData => Instruction_ID);

-------------------------------------------------------------------------------------------------------------------------------------

CUnit_map : ControlUnit port map (Instruction => Instruction_ID(31 downto 26),RegDst => RegDst,ExtOp => ExtOp,ALUSrc => ALUSrc,Branch => Branch,Jump => Jump,ALUOp => ALUOp,MemWrite => MemWrite,MemtoReg => MemtoReg,RegWrite => RegWrite);

WB_signals_ID(0) <= MemToReg;
WB_signals_ID(1) <= RegWrite;

M_signals_ID(0) <= MemWrite;
M_signals_ID(1) <= Branch;

EX_signals_ID(2 downto 0) <= ALUOp;
EX_signals_ID(3) <= ALUSrc;
EX_signals_ID(4) <= RegDst;

ID_EX_0_map: pipeline_register port map(clk=>clk, enable => enable,WriteAddress => "0000",WriteData => WB_signals_ID,ReadAddress => "0000",ReadData => WB_signals_EX);
ID_EX_1_map: pipeline_register port map(clk=>clk, enable => enable,WriteAddress => "0001",WriteData => M_signals_ID,ReadAddress => "0001",ReadData => M_signals_EX);
ID_EX_2_map: pipeline_register port map(clk=>clk, enable => enable,WriteAddress => "0010",WriteData => EX_signals_ID,ReadAddress => "0010",ReadData => EX_signals_EX);

-----------------------------------------------------------------------------------------------------------------------------------------
IDecode_map : IDecode port map (clk => clk,PCOutput => PC_ID,Instruction => Instruction_ID,WriteAddress => WriteAddress_WB_32(4 downto 0),WriteData => WriteData_WB,RegWrite => WB_signals_WB(1),enable => enable,ExtOp => ExtOp,ReadData1 => RD1,ReadData2 => RD2,ExtImm => Ext_Imm,Func => Func,SA => SA,JumpAddress => JumpAddress);

ID_EX_3_map: pipeline_register port map(clk=>clk, enable => enable,WriteAddress => "0011",WriteData => RD1,ReadAddress => "0011",ReadData => RD1_EX);
ID_EX_4_map: pipeline_register port map(clk=>clk, enable => enable,WriteAddress => "0100",WriteData => RD2,ReadAddress => "0100",ReadData => RD2_EX);
ID_EX_5_map: pipeline_register port map(clk=>clk, enable => enable,WriteAddress => "0101",WriteData => Ext_Imm,ReadAddress => "0101",ReadData => Ext_Imm_EX);

funct_sa_ID(5 downto 0) <= Func;
funct_sa_ID(10 downto 6) <= SA;

ID_EX_6_map: pipeline_register port map(clk=>clk, enable => enable,WriteAddress => "0110",WriteData => funct_sa_ID,ReadAddress => "0110",ReadData => funct_sa_EX);
ID_EX_7_map: pipeline_register port map(clk=>clk, enable => enable,WriteAddress => "0111",WriteData => PC_ID,ReadAddress => "0111",ReadData => PC_EX);
ID_EX_8_map: pipeline_register port map(clk=>clk, enable => enable,WriteAddress => "1000",WriteData => Instruction_ID,ReadAddress => "1000",ReadData => Instruction_EX);




-----------------------------------------------------------------------------------------------------------------------------------------

ExUnit_map : ExecutionUnit port map(Instruction =>Instruction_EX,PCIncremented => PC_EX,RD1 => RD1_EX,RD2 => RD2_EX,Ext_Imm => Ext_Imm_EX,Func => Funct_sa_EX(5 downto 0),SA => funct_sa_EX(10 downto 6),ALUSrc => EX_signals_EX(3),ALUOp => EX_signals_EX(2 downto 0),RegDst => EX_signals_EX(4),BranchAddress => BranchAddress,ALURes => ALURes,Zero => ZeroSignal);

EX_MEM_0_map: pipeline_register port map(clk=>clk, enable => enable,WriteAddress => "0000",WriteData => WB_signals_EX,ReadAddress => "0000",ReadData => WB_signals_MEM);
EX_MEM_1_map: pipeline_register port map(clk=>clk, enable => enable,WriteAddress => "0001",WriteData => M_signals_EX,ReadAddress => "0001",ReadData => M_signals_MEM);

Zero_signal_EX(0) <= zeroSignal;

EX_MEM_2_map: pipeline_register port map(clk=>clk, enable => enable,WriteAddress => "0010",WriteData => zero_signal_EX,ReadAddress => "0010",ReadData => zero_signal_MEM);
EX_MEM_3_map: pipeline_register port map(clk=>clk, enable => enable,WriteAddress => "0011",WriteData => ALURes,ReadAddress => "0011",ReadData => ALURes_MEM);
EX_MEM_4_map: pipeline_register port map(clk=>clk, enable => enable,WriteAddress => "0100",WriteData => RD2_EX,ReadAddress => "0100",ReadData => RD2_MEM);
EX_MEM_5_map: pipeline_register port map(clk=>clk, enable => enable,WriteAddress => "0101",WriteData => BranchAddress,ReadAddress => "0101",ReadData => BranchAddress_MEM);


WriteAddress_32<= "000000000000000000000000000"&WriteAddress;
EX_MEM_6_map: pipeline_register port map(clk=>clk, enable => enable,WriteAddress => "0110",WriteData => WriteAddress_32,ReadAddress => "0110",ReadData => WriteAddress_MEM_32);
-------------------------------------------------------------------------------------------------------------------------------------------------------
Memory_map : RAM port map(clk => clk,ALURes => ALURes_MEM,WriteData => RD2_MEM,MemWrite =>M_signals_MEM(0),enable => enable,Zero =>zero_signal_MEM(0),Branch => M_signals_MEM(1),MemoryData => MemoryData,PCSrc => PCSrc);

MEM_WB_0_map: pipeline_register port map(clk=>clk, enable => enable,WriteAddress => "0000",WriteData => WB_signals_MEM,ReadAddress => "0000",ReadData => WB_signals_WB);
MEM_WB_1_map: pipeline_register port map(clk=>clk, enable => enable,WriteAddress => "0001",WriteData => MemoryData,ReadAddress => "0001",ReadData => MemData_WB);
MEM_WB_2_map: pipeline_register port map(clk=>clk, enable => enable,WriteAddress => "0010",WriteData => ALURes_MEM,ReadAddress => "0010",ReadData => ALURes_WB);


MEM_WB_3_map: pipeline_register port map(clk=>clk, enable => enable,WriteAddress => "0011",WriteData => WriteAddress_MEM_32,ReadAddress => "0011",ReadData => WriteAddress_WB_32);

--------------------------------------------------------------------------------------------------------------------------------------------------------

ssd_map :SSD port map(digits => SSDOUT,clk => clk,an => an,cat => cat);
debouncer_map_1 :MPG port map(btn => btn(0),clk => clk,en => enable);
debouncer_map_2 :MPG port map(btn => btn(1),clk => clk,en => reset);


process(WB_signals_WB(0),ALURes_WB,MemData_WB)
begin
	case (MemtoReg) is
		when '1' => WriteData_WB<=MemData_WB;
		when '0' => WriteData_WB<=ALURes_WB;
		when others => WriteData_WB<=WriteData_WB;
	end case;
end process;	

process(Instruction,PCOutput,sw(7 downto 5))
begin
case sw(7 downto 5) is
    when "000" => SSDOUT <= Instruction(15 downto 0);
    when "001" => SSDOUT <= PCOutput(15 downto 0);
    when "010" => SSDOUT <= RD1(15 downto 0);
    when "011" => SSDOUT <= RD2(15 downto 0);
    when "100" => SSDOUT <= ALURes(15 downto 0);
    when "101" => SSDOUT <= ALURes_WB(15 downto 0);
    when "110" => SSDOUT <= MemData_WB(15 downto 0);
    when "111" => SSDOUT <= WriteData_WB(15 downto 0);
end case;

end process;

led(10 downto 0) <= RegDst & ExtOp & ALUSrc & Branch & Jump & ALUOp & MemWrite & MemtoReg & RegWrite;

end Behavioral;

