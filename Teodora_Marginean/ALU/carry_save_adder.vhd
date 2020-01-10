library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity carry_save_adder is
    Port ( A : in  STD_LOGIC_VECTOR (3 downto 0);
           B : in  STD_LOGIC_VECTOR (3 downto 0);
	   C : in  STD_LOGIC_VECTOR (3 downto 0);
           cin : in  STD_LOGIC;
           sum : out  STD_LOGIC_VECTOR (4 downto 0);
           cout : out  STD_LOGIC);
end carry_save_adder;


architecture Behavioral of carry_save_adder is

component full_adder is
    Port ( a : in  STD_LOGIC;
           b : in  STD_LOGIC;
           cin : in  STD_LOGIC;
           s : out  STD_LOGIC;
           cout : out  STD_LOGIC);
end component;

component ripple_carry is
    Port ( a : in  STD_LOGIC_VECTOR (3 downto 0);
           b : in  STD_LOGIC_VECTOR (3 downto 0);
           cin : in  STD_LOGIC;
           sum : out  STD_LOGIC_VECTOR (3 downto 0);
           cout : out  STD_LOGIC);
end component;

signal x, y: std_logic_vector(3 downto 0);
signal cout_i, sum_i: std_logic_vector(3 downto 0);

begin

	Adder: FOR k IN 3 downto 0 generate
		FA: full_adder port map (A(k), B(k), C(k), sum_i(k), cout_i(k));
	end generate Adder;
	
	x <= cout_i;
	y <= '0' & sum_i(3 downto 1);	

	sum(0) <= sum_i(0);
	
	Ripple_Adder: ripple_carry port map (x, y, '0', sum(4 downto 1), cout);

end Behavioral;