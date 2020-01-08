library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity pipeline_register is
    Port (	clk : in std_logic;
            enable: in std_logic;
			WriteAddress : in std_logic_vector (3 downto 0);
			WriteData : in std_logic_vector (31 downto 0);
			ReadAddress : in std_logic_vector (3 downto 0);
			ReadData : out std_logic_vector (31 downto 0));
end pipeline_register;

architecture Behavioral of pipeline_register is


type reg_array is array(0 to 8) of std_logic_vector(31 downto 0);

signal reg_file : reg_array:=(
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		X"00000000",
		others => X"00000000");
begin

			
		
process(clk,enable)			
begin
	if enable='1' then
		if rising_edge(clk) then
		    ReadData <= reg_file(conv_integer(ReadAddress));
			reg_file(conv_integer(WriteAddress))<=WriteData;		
		end if;
	end if;
end process;		

end Behavioral;

