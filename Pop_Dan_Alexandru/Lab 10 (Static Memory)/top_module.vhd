library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

-- main block diagram
-- facem TESTBENCH pentru el

entity top_module is
port(
	address_bus: in std_logic_vector(23 downto 0);
	data_bus: inout std_logic_vector(15 downto 0);
	--command_bus: in std_logic_vector();
	--bhe: in std_logic; 	-- A17 = BHE = address_bus(17)
	wr: in std_logic;
	rd: in std_logic
);
end top_module;

architecture Behavioral of top_module is

component decoder_circuit is
port(
	input_address: in std_logic_vector(6 downto 0);
	rd: in std_logic;
	wr: in std_logic;
	selection_bits: out std_logic_vector(7 downto 0);
	sel_module: out std_logic
);
end component;

signal selection_bits: std_logic_vector(7 downto 0);
signal sel_module: std_logic;

component memory_matrix is
port(
	address_line: in std_logic_vector(17 downto 0);
	-- A17 = BHE ; A0..A16 = normal addresses
	selection: in std_logic_vector(7 downto 0);
	--clk: in std_logic;
	wr: in std_logic;
	data_out: inout std_logic_vector(15 downto 0)
);
end component;

signal data_out: std_logic_vector(15 downto 0);

begin

STEP_1: decoder_circuit port map (input_address => address_bus(23 downto 17),
											rd => rd,
											wr => wr,
											selection_bits => selection_bits,
											sel_module => sel_module);
											
STEP_2: memory_matrix port map (address_line => address_bus(17 downto 0),
										  -- A17 = BHE ; A0..A16 = normal addresses
										  selection => selection_bits,
									 	  --clk => clk,
										  wr => wr,
										  data_out => data_out);

end Behavioral;