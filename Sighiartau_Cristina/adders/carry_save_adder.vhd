library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_arith.all;
use IEEE.STD_LOGIC_unsigned.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity carry_save_adder is
 generic (N: integer);
 port(X: in std_logic_vector(N-1 downto 0);
 Y: in std_logic_vector(N-1 downto 0);
 Z: in std_logic_vector(N-1 downto 0);
 cout: out std_logic;
 res: out std_logic_vector(N-1 downto 0)
 );
end carry_save_adder;

architecture Behavioral of carry_save_adder is

signal carry: std_logic_vector(N-1 downto 0) := (others => '0');
signal addresult: std_logic_vector(N-1 downto 0) := (others => '0');
signal result: std_logic_vector(N downto 0) := (others => '0');
--signal carryout: std_logic_vector(N-1 downto 0) := (others => '0');

component full_adder3 is
port(x: in std_logic;
y: in std_logic;
z: in std_logic;
res: out std_logic;
cout: out std_logic);
end component;

begin

GN:
for i in 0 to N-1 generate
    add_map: full_adder3 port map
    (X(i), Y(i), Z(i), addresult(i), carry(i));  
    end generate GN;
    
result <= carry + addresult;

cout<=result(N);

res<=result(N-1 downto 0);

end Behavioral;

