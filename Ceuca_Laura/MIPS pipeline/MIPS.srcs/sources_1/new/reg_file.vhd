library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity reg_file is
    Port (	clk : in std_logic;
			ReadAddress1 : in std_logic_vector (4 downto 0);
			ReadAddress2 : in std_logic_vector (4 downto 0);
			WriteAddress : in std_logic_vector (4 downto 0);
			WriteData : in std_logic_vector (31 downto 0);
			RegWrite : in std_logic;
			enable: in std_logic;
			ReadData1 : out std_logic_vector (31 downto 0);
			ReadData2 : out std_logic_vector (31 downto 0));
end reg_file;

architecture Behavioral of reg_file is


type reg_array is array(0 to 7) of std_logic_vector(31 downto 0);

signal reg_file : reg_array:=(
		X"00000000",
		X"00000001",
		X"00000002",
		X"00000003",
		X"00000004",
		X"00000005",
		X"00000006",
		X"00000007",
		others => X"00000000");
begin

ReadData1 <= reg_file(conv_integer(ReadAddress1));			
ReadData2 <= reg_file(conv_integer(ReadAddress2));			

process(clk,enable,RegWrite)			
begin
	if enable='1' then
		if rising_edge(clk) and RegWrite='1' then
			reg_file(conv_integer(WriteAddress))<=WriteData;		
		end if;
	end if;
end process;		

end Behavioral;

