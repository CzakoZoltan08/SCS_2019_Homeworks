library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
--use IEEE.NUMERIC_STD.ALL;

-- contine DECODER-ul (cu PORT MAP) si semnalele de control si Command Circuit

entity decoder_circuit is
port(
	input_address: in std_logic_vector(6 downto 0);
	rd: in std_logic;
	wr: in std_logic;
	--bitii de selectie (pt a selecta un submodul specific)
	selection_bits: out std_logic_vector(7 downto 0); 	
	sel_module: out std_logic
);
end decoder_circuit;

architecture Behavioral of decoder_circuit is

component decoder is
port(
	input: in std_logic_vector(2 downto 0);	-- A, B, C
	e_1: in std_logic;
	e_2: in std_logic;
	e_3: in std_logic;
	output: out std_logic_vector(7 downto 0)
);
end component;

signal output: std_logic_vector(7 downto 0);
signal nand_output: std_logic;
signal and_output: std_logic;

begin

nand_output <= not(not(input_address(3)) AND not(input_address(4)) AND input_address(5) AND input_address(6));

and_output <= rd and wr;

module_1: decoder port map (input => input_address(2 downto 0),
									 e_1 => nand_output,
 									 e_2 => and_output,
									 e_3 => '1',
									 output => selection_bits);

sel_module <= nand_output OR and_output;

end Behavioral;