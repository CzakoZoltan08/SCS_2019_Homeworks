library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;



entity static_memory is
    port(
         addr    :  in std_logic_vector(23 downto 0);
         wr      :  in std_logic;
         rd      :  in std_logic;
         bhe     :  in std_logic;
         datain  :  in std_logic_vector(15 downto 0);
         dataout : out std_logic_vector(15 downto 0)
        );
end static_memory;



architecture Behavioral of static_memory is


	component decoder is
		 port ( 
		        addr :  in  std_logic_vector(6 downto 0);
				rd   :  in  std_logic;
				wr   :  in  std_logic;
				sel  : out  std_logic_vector(7 downto 0)			 
			  );
	end component;

	component mem_matrix is
		port(
			addr    :  in std_logic_vector(16 downto 0);
			sel     :  in std_logic_vector( 7 downto 0);
			wr      :  in std_logic;
			bhe     :  in std_logic;
			datain  :  in std_logic_vector(15 downto 0);
            dataout : out std_logic_vector(15 downto 0)
			);
	end component;


	signal  decoderOut : std_logic_vector(7 downto 0);
	

    begin
    
        dec    : decoder    port map(addr(23 downto 17),         rd, wr, decoderOut);
        memory : mem_matrix port map(addr(16 downto  0), decoderOut, wr, bhe, datain, dataout);
        

end Behavioral;

