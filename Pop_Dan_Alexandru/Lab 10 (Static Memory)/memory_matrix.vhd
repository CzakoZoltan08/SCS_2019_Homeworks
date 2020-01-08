library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

-- contine 8 submodule (Port Map-uri intr-un FOR)

entity memory_matrix is
port(
	address_line: in std_logic_vector(17 downto 0);
	-- A17 = BHE ; A0..A16 = normal addresses
	selection: in std_logic_vector(7 downto 0);
	--clk: in std_logic;
	wr: in std_logic;
	data_out: inout std_logic_vector(15 downto 0)
);
end memory_matrix;

architecture Behavioral of memory_matrix is

component sub_module is
port(
	--bitii de addresa => folositi pt a selecta partea superioara sau inferioara a MEM 
	--(primii 8 sau ultimii 8 biti) => sunt semnale de control
	address: in std_logic_vector(16 downto 0);	-- A0 ... A16
	wr: in std_logic;				-- ENABLE (activ pe '0')
	selection: in std_logic;	-- Selection-i	(activ pe '0') => pt selectarea unui sub-modul specific
	--addr0: in std_logic;			-- A0 (folosit pt calcularea Selectiei (superioare sau inferioare))
	bhe: in std_logic;
	--clk: in std_logic;
	data_out: inout std_logic_vector(15 downto 0));
end component;

signal data: std_logic_vector(15 downto 0);

begin

GEN_MEM: for i in 7 downto 0 generate
	COMPON : sub_module port map
		(address => address_line(16 downto 0), 
		 wr => wr, 
		 selection => selection(i), 
		 bhe => address_line(17),
		 --clk => clk,
		 data_out => data);
end generate GEN_MEM;

data_out <= data;

end Behavioral; 