library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity RAM is
	port(   clk: in std_logic;
			ALURes : in std_logic_vector(31 downto 0);
			WriteData: in std_logic_vector(31 downto 0);
			MemWrite: in std_logic;			
			enable: in std_logic;	
			Zero: in std_logic;
			Branch: in std_logic;
			MemoryData:out std_logic_vector(31 downto 0);
			PCSrc: out std_logic);
end RAM;

architecture Behavioral of RAM is

type ram_type is array (0 to 31) of std_logic_vector(31 downto 0);
signal RAM:ram_type:=(
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		others =>X"0000");

begin

process(clk) 			
begin
	if(rising_edge(clk)) then
		if enable='1' then
			if MemWrite='1' then
				RAM(conv_integer(ALURes))<=WriteData;			
			end if;
		end if;	
	end if;
end process;

MemoryData<=RAM(conv_integer(ALURes));

PCSrc <= Zero and Branch;

end Behavioral;