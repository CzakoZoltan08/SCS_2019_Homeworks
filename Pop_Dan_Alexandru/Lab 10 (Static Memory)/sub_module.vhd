library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

-- contine 2 memorii RAM de baza

entity sub_module is
port(
	address: in std_logic_vector(16 downto 0);	-- A0 ... A16
	wr: in std_logic;				-- ENABLE (activ pe '0')
	selection: in std_logic;	-- Selection-i	(activ pe '0')
	--addr0: in std_logic;			-- A0 (folosit pt calcularea Selectiei (superioare sau inferioare))
	bhe: in std_logic;
	--clk: in std_logic;
	data_out: inout std_logic_vector(15 downto 0));
end sub_module;

architecture Behavioral of sub_module is

component base_mem_8bits is
port(
	address: in std_logic_vector(15 downto 0);
	chip_select: in std_logic;		-- activ pe '0' == ENABLE
	wr: in std_logic;					-- activ pe '0'
	--clk: in std_logic;
	data: inout std_logic_vector(7 downto 0));
end component;

signal data_mem_1: std_logic_vector(7 downto 0);
signal data_mem_2: std_logic_vector(7 downto 0);

-- used for Chip Select:
signal selection_LOW: std_logic;	-- selection LOW		(activ pe '0')
signal selection_HIGH: std_logic;	-- selection HIGH		(activ pe '0')

begin

selection_LOW <= selection AND address(0);	-- Selection-i AND A0
selection_HIGH <= selection AND bhe;

module_1: base_mem_8bits port map (address => address(16 downto 1),	-- A1 ... A16
											  chip_select => selection_LOW,
											  wr => wr,
											  --clk => clk,
											  data => data_mem_1);
											  
module_2: base_mem_8bits port map (address => address(16 downto 1),	-- A1 ... A16
											  chip_select => selection_HIGH,
											  wr => wr,
											  --clk => clk,
											  data => data_mem_2);

data_out <= data_mem_2 & data_mem_1;	-- concatenate the 2 outputs

end Behavioral;