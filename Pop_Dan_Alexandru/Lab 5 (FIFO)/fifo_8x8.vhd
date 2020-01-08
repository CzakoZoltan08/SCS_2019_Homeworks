library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity fifo_8x8 is
    Port ( data_in : in  STD_LOGIC_VECTOR (7 downto 0);
           rd : in  STD_LOGIC;
           wr : in  STD_LOGIC;
           rd_inc : in  STD_LOGIC;
           wr_inc : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           rst : in  STD_LOGIC;
           data_out : out  STD_LOGIC_VECTOR (7 downto 0));
end fifo_8x8;

architecture Behavioral of fifo_8x8 is

signal wrptr: std_logic_vector(2 downto 0);
signal rdptr: std_logic_vector(2 downto 0);
signal RES_decoder: std_logic_vector(7 downto 0);
signal EN_register: std_logic_vector(7 downto 0);
signal Q_register7: std_logic_vector(7 downto 0);
signal Q_register6: std_logic_vector(7 downto 0);
signal Q_register5: std_logic_vector(7 downto 0);
signal Q_register4: std_logic_vector(7 downto 0);
signal Q_register3: std_logic_vector(7 downto 0);
signal Q_register2: std_logic_vector(7 downto 0);
signal Q_register1: std_logic_vector(7 downto 0);
signal Q_register0: std_logic_vector(7 downto 0);
signal MUX_out: std_logic_vector(7 downto 0);

begin

write_pointer: process (clk) begin
	if (rising_edge(clk) and rst = '0') then
		if (wr_inc = '1') then 
			wrptr <= wr & "00";
		end if;
	end if;
end process;


read_pointer: process begin
	if (rising_edge(clk) and rst = '0') then
		if (rd_inc = '1') then 
			rdptr <= rd & "00";
		end if;
	end if;
end process;


decoder: process(wrptr) begin
	case wrptr is
		when "000"  => RES_decoder <= "00000001";
		when "001"  => RES_decoder <= "00000010";
		when "010"  => RES_decoder <= "00000100";
		when "011"  => RES_decoder <= "00001000";
		when "100"  => RES_decoder <= "00010000";
		when "101"  => RES_decoder <= "00100000";
		when "110"  => RES_decoder <= "01000000";
		when others => RES_decoder <= "10000000";
	end case;
end process;


register_set: process(clk) begin
		
	for i in 7 downto 0 loop	
		EN_register(i) <= wr AND RES_decoder(i);
		if rising_edge(clk) then
			if EN_register(i) = '1' then
				if (i = 7) then
					Q_register7 <= data_in;
				elsif (i = 6) then
					Q_register6 <= data_in;
				elsif (i = 5) then
					Q_register5 <= data_in;
				elsif (i = 4) then
					Q_register4 <= data_in;
				elsif (i = 3) then
					Q_register3 <= data_in;
				elsif (i = 2) then
					Q_register2 <= data_in;
				elsif (i = 1) then
					Q_register1 <= data_in;
				elsif (i = 0) then
					Q_register0 <= data_in;
				end if;
			end if;
		end if;
	end loop;
	
end process;


multiplexer: process(rdptr, Q_register0, Q_register1, Q_register2, Q_register3, Q_register4, Q_register5, Q_register6, Q_register7) begin
	-- 'rdptr' is the SELECT signal for the MUX
	case rdptr is
		when "000"  => MUX_out <= Q_register7;
		when "001"  => MUX_out <= Q_register6;
		when "010"  => MUX_out <= Q_register5;
		when "011"  => MUX_out <= Q_register4;
		when "100"  => MUX_out <= Q_register3;
		when "101"  => MUX_out <= Q_register2;
		when "110"  => MUX_out <= Q_register1;
		when "111"  => MUX_out <= Q_register0;
		when others => MUX_out <= Q_register7;
	end case;
end process;


tri_state_buffer: process begin
	if (rd = '1') then 
		data_out <= MUX_out;
	else
		data_out <= "ZZZZZZZZ";		-- the High Impedance state
	end if;
end process;

end Behavioral;