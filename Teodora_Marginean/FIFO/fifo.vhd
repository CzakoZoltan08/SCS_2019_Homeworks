library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
 use IEEE.std_logic_signed.all;
 
entity fifo is
    Port ( data_in : in STD_LOGIC_VECTOR (7 downto 0);
           rd : in STD_LOGIC;
           wr : in STD_LOGIC;
           rst : in STD_LOGIC;
           clk : in STD_LOGIC;
           sseg : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0);
           empty : out STD_LOGIC;
           full : out STD_LOGIC);
end fifo;

architecture Behavioral of fifo is

component displ_7seg is
	port ( clk, rst : in std_logic;
		    data : in std_logic_vector (15 downto 0);
		    sseg : out std_logic_vector (6 downto 0);
		    an : out std_logic_vector (3 downto 0));
end component;

type memory_type is array (0 to 7) of std_logic_vector(7 downto 0);  
signal memory : memory_type :=(others => (others => '0')); 
signal rp: std_logic_vector(3 downto 0) := "0000";
signal wp: std_logic_vector(3 downto 0) := "0000";
signal fifo_status: std_logic := '0';
signal data_out: std_logic_vector(7 downto 0) := "00000000";
signal mux_out: std_logic_vector(7 downto 0) := "00000000";
signal data_to_display: std_logic_vector(15 downto 0) := "0000000000000000";

begin

    process (rst, rd)
    begin
        if (rising_edge(clk)) then
            if (rst = '0') then
                if (rd = '1') then
                    rp <= rp + "0001";
                end if;
            else
                rp <= "0000";
            end if;
        end if;
    end process;
    
    process (rst, wp)
    begin
        if (rising_edge(clk)) then
            if (rst = '0') then
                if (wr = '1') then
                    wp <= wp + "0001";
                end if;
            else
                wp <= "0000";
            end if;
         end if;
    end process;
    
    fifo_status <= rp(3) xor wp(3);
    
    process (fifo_status, wp)
    begin
       if (fifo_status = '0') then
            empty <= '1';
            full <= '0';
       else
            if (wp(3) = '1') then
                full <= '1';
                empty <= '0';
            else
                full <= '0';
                empty <= '0';
            end if;
       end if;
    end process;
    
    dcd: process(clk, wr)
    begin
        if (rising_edge(clk)) then
            if (wr = '1') then
                memory(conv_integer(wp(2 downto 0))) <= data_in;
            end if;
        end if;
    end process;
    
    mux: process(clk)
    begin
        if (rising_edge(clk)) then
           mux_out <= memory(conv_integer(rp(2 downto 0)));
        end if;
    end process;
    
    tri_state_buffer: process(rd)
    begin
        if (rd = '1') then
            data_out <= mux_out;
        else
            data_out <= "ZZZZZZZZ";
        end if;
    end process;
    
    data_to_display <= data_in & data_out;
    
    seven_segment_display: displ_7seg port map (clk, rst, data_to_display, sseg, an);

end Behavioral;
