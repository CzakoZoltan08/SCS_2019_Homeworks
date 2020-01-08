library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.NUMERIC_std.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity IFetch is
	Port (  enable : in std_logic;
			reset : in std_logic;
			clk: in std_logic;
			BranchAddress : in std_logic_vector(31 downto 0);
			JumpAddress : in std_logic_vector(31 downto 0);
			Jump : in std_logic;
			PCSrc : in std_logic;
			Instruction : out std_logic_vector(31 downto 0);
			PCOutput : out std_logic_vector(31 downto 0));
end IFetch;

architecture Behavioral of IFetch is

type rom_type is array(0 to 100) of std_logic_vector(31 downto 0);
--signal ROM: rom_type := (
--    B"001_000_010_0000001",-- addi $r2, $0, 1
--    B"001_000_100_0000001",-- addi $r4, $0, 1
--    B"011_000_000_0000000",-- noop added
--    B"011_000_001_0000001",-- sw $r1, $0, 1
--    B"011_000_010_0000010",-- sw $r2, $0, 2
--    B"001_000_101_0000101",-- addi $r5, $0, 5
--    B"011_000_000_0000000",-- noop added
--    B"011_000_000_0000000",-- noop added
--    B"010_000_010_0000010",-- lw $r2, $0, 2--bucla
--    B"010_000_001_0000001",-- lw $r1, $0, 1
--    B"011_000_000_0000000",-- noop added
--    B"011_000_000_0000000",-- noop added
--    B"000_011_010_011_0_000",-- add $r3, $r3, $r2
--    B"001_100_100_0000001",-- addi $r4, $r4, 1
--    B"011_000_001_0000010",-- sw $r1, $0, 2
--    B"011_000_000_0000000",-- noop added
--    B"011_000_011_0000001",-- sw $r3, $0, 1
--    B"010_101_100_0000100",-- beq $r4, $r5, gata --gata e adresa in memorie imediat de dupa ultima instructiune din aceasta
--    B"011_000_000_0000000",-- noop added
--    B"011_000_000_0000000",-- noop added
--    B"011_000_000_0000000",-- noop added
--    B"111_0000000001001",-- j bucla --pentru bucla, vezi mai sus
--    B"0000000000000000",--noop
--    B"0000000000000000",--noop
--    B"0000000000000000",--noop
--    B"0000000000000000",--noop
--    B"010_000_001_0000001",-- lw $r1, $0, 1 --pentru a vedea rezultatul :)
--others => X"0000");
--signal ROM: rom_type := (
--B"000_010_011_001_0_000",   --0910  R1 <- R2+R3  output:R1 = 5
--B"000_001_001_001_1_010",   --049A  R1 <- R1<<1  output:R1 = 10
--B"000_111_111_111_1_011",   --1FFB  R7 <- R7>>1  output:R7 = 3
--B"000_110_010_101_0_001",   --1951  R5 <- R6-R2  output:R5 = 4
--B"011_110_110_0000100",     --7604 Store at address 7 in memory content of R6
--B"010_100_100_0000111",     --5207 Load form adderess 7 in memory in R4 output:R4=7
--B"000_011_010_011_0_100",   --0D34  R3 <- R3andR2 output:R3 = 2 
--B"000_001_000_001_0_101",   --0415	R1 <- R1orR0  output:R1 = 10
--B"000_011_101_001_0_111",   --0E97 if(R3<R5) R1 = 1 output:R1=1
--B"100_001_100_0000001",     --8601 Jump to address 1 if R1=R4 //false
--B"000_100_000_000_0_000",   --0910  R0 <- R4+R0  output:R0 = 6;
--B"001_000_000_0000110",     --2006 Add 6 to R0 output:R0=6
--B"111_0000000000011",       --E003	Jump to address 3
--others => X"0000");

signal ROM: rom_type := (
B"000000_00010_00011_00001_00000_000000",   --0910  R1 <- R2+R3  output:R1 = 5
B"000011_00110_00110_0000000000000100",     --7604 Store at address 4 in memory content of R4
B"00000000000000000000000000000000",--noop
B"00000000000000000000000000000000",--noop
B"00000000000000000000000000000000",--noop
B"000010_00101_00101_0000000000000100",     --5207 Load form adderess 4 in memory in R5 output:R5=4
B"00000000000000000000000000000000",--noop
B"00000000000000000000000000000000",--noop
B"00000000000000000000000000000000",--noop
B"00000000000000000000000000000000",--noop
B"000000_00110_00101_00011_00000_000100",   --0D34  R3 <- R6 and R5 output: 4
others => X"00000000");

signal PCInternal: std_logic_vector(31 downto 0) :=X"00000000";
signal PCIncremented: std_logic_vector(31 downto 0) :=X"00000000";
signal NextAddress: std_logic_vector(31 downto 0) :=X"00000000";
signal PCAfterBranchMUX: std_logic_vector(31 downto 0) :=X"00000000";

begin

process(clk,reset,enable)
begin
	if Reset='1' then PCInternal<=X"00000000";
	else if rising_edge(clk) and enable='1' then
		PCInternal<=NextAddress;
		end if;
	end if;
end process;

process(PCSrc,PCIncremented,BranchAddress)
begin
	case (PCSrc) is 
		when '0' => PCAfterBranchMUX <= PCIncremented;
		when '1' => PCAfterBranchMUX<=BranchAddress;
		when others => PCAfterBranchMUX<=X"00000000";
	end case;
end process;	


process(Jump,PCAfterBranchMUX,JumpAddress)
begin
	case(Jump) is
		when '0' => NextAddress <= PCAfterBranchMUX;
		when '1' => NextAddress <= JumpAddress;
		when others => NextAddress <= X"00000000";
	end case;
end process;	

Instruction<=ROM(conv_integer(PCInternal(15 downto 0)));

PCIncremented<=PCInternal + '1';

PCOutput <= PCIncremented;


end Behavioral;
