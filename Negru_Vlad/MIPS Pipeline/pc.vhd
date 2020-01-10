
LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;

-- use package

ENTITY pc IS
PORT (
clk : IN STD_LOGIC;
rst_n : IN STD_LOGIC;
pc_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
PC_en : IN STD_LOGIC;
pc_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) );
END pc; 

ARCHITECTURE behave OF pc IS
signal pc_temp : STD_LOGIC_VECTOR(31 DOWNTO 0):=x"00000000";
BEGIN

proc_pc : PROCESS(clk, rst_n)

BEGIN
IF rst_n = '1' THEN
pc_out <= (OTHERS => '0');
ELSIF rising_edge(clk) THEN
IF PC_en = '1' THEN
pc_out <= pc_in;
END IF;
END IF;

END PROCESS;


END behave; 