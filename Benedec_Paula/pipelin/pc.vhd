LIBRARY IEEE;
USE IEEE.std_logic_1164.ALL;
USE IEEE.numeric_std.ALL;
-- use package

ENTITY pc IS
     generic ( width : integer :=32);
     PORT (
        clk : IN STD_LOGIC;
        rst_n : IN STD_LOGIC;
        pc_in : IN STD_LOGIC_VECTOR(width-1 DOWNTO 0);
        PC_en : IN STD_LOGIC;
        pc_out : OUT STD_LOGIC_VECTOR(width-1 DOWNTO 0) );
END pc;
ARCHITECTURE behave OF pc IS

BEGIN
    proc_pc : PROCESS(clk, rst_n)
    VARIABLE pc_temp : STD_LOGIC_VECTOR(width-1 DOWNTO 0);
    BEGIN
        IF rst_n = '1' THEN
            pc_temp := (OTHERS => '0');
        ELSIF RISING_EDGE(clk) THEN
            IF PC_en = '1' THEN
                    pc_temp := pc_in;
             END IF;
        END IF;
        pc_out <= pc_temp;
END PROCESS;
end behave;