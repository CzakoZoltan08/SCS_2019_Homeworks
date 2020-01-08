library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Implement the Wallace Tree for multiplying two 4-bit numbers
entity wallace_tree_multiplier is
generic (
	nr: integer := 5    -- nr of bits
);
port (first_number_bits: in std_logic_vector(3 downto 0);
		second_number_bits: in std_logic_vector(3 downto 0);
		product: out std_logic_vector(7 downto 0));		-- the result of multiplication
end wallace_tree_multiplier;

architecture Behavioral of wallace_tree_multiplier is

	component carry_saver_adder_5bits is
	generic (
		 nr: integer := 5    -- nr of bits
	);
	port(
		 a: in std_logic_vector(nr-1 downto 0);
		 b: in std_logic_vector(nr-1 downto 0);
		 c: in std_logic_vector(nr-1 downto 0);
		 --carry_in: in std_logic_vector(nr downto 0);
		 sum: out std_logic_vector(nr-1 downto 0);
		 carry_out: out std_logic_vector(nr-1 downto 0)
	);
	end component;

	signal sum_CSA_1: std_logic_vector(nr-1 downto 0);
	signal carry_out_CSA_1: std_logic_vector(nr-1 downto 0);
	signal sum_CSA_2: std_logic_vector(nr-1 downto 0);
	signal carry_out_CSA_2: std_logic_vector(nr-1 downto 0);
	
	component ripple_carry_adder_5bits is
	generic (
		 nr: integer := 5        -- error: formal generic 'nr' has no actual or default value
	);      -- componenta generica
	-- without CarryIn and CarryOut (ca in schema logica de pe site)
	Port ( 
		 x: in STD_LOGIC_VECTOR(nr-1 downto 0);
		 y: in STD_LOGIC_VECTOR(nr-1 downto 0);
		 S: out STD_LOGIC_VECTOR(nr-1 downto 0)
	);
	end component;
	
	-- CPA = Carry Propagation Adder = Ripple Carry Adder
	signal sum_CPA: STD_LOGIC_VECTOR(nr-1 downto 0);
	
begin

-- am concatenat pentru ca mi se pare ca asa arata in schema data din PDF:  un input este XY(0) , unde X si Y sunt pe 4 biti 
-- (m-am gandit ca un input pentru CSA este pe 5 biti = X si Y(i))
LEVEL_1: carry_saver_adder_5bits port map (a => first_number_bits & second_number_bits(0),
												 b => first_number_bits & second_number_bits(1),
												 c => first_number_bits & second_number_bits(2), 
												 sum => sum_CSA_1, 
												 carry_out => carry_out_CSA_1);
												 
LEVEL_2: carry_saver_adder_5bits port map (a => sum_CSA_1,
												 b => carry_out_CSA_1,
												 c => first_number_bits & second_number_bits(3), 
												 sum => sum_CSA_2, 
												 carry_out => carry_out_CSA_2);
												 
LEVEL_3: ripple_carry_adder_5bits port map (x => carry_out_CSA_2,
												  y => sum_CSA_2,
												  S => sum_CPA);

product <= "000" & sum_CPA;	-- final rezult

end Behavioral;