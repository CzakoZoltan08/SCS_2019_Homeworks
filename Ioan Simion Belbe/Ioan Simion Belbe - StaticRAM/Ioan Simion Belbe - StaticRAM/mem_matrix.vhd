library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity mem_matrix is
	port(
		addr    :  in std_logic_vector(16 downto 0);
		sel     :  in std_logic_vector( 7 downto 0);
		wr      :  in std_logic;
		bhe     :  in std_logic;
		datain  :  in std_logic_vector(15 downto 0);
        dataout : out std_logic_vector(15 downto 0)
		);
end mem_matrix;



architecture Behavioral of mem_matrix is


	component submodule is
		port(
			addr    :  in std_logic_vector(16 downto 0);
			wr      :  in std_logic;
			bhe     :  in std_logic;
			selI    :  in std_logic;
			datain  :  in std_logic_vector(15 downto 0);
            dataout : out std_logic_vector(15 downto 0)
			);
	end component;	


    begin
            
            m0: submodule port map (addr, wr, bhe, sel(0), datain, dataout);      
            m1: submodule port map (addr, wr, bhe, sel(1), datain, dataout);
            m2: submodule port map (addr, wr, bhe, sel(2), datain, dataout);
            m3: submodule port map (addr, wr, bhe, sel(3), datain, dataout);
            m4: submodule port map (addr, wr, bhe, sel(4), datain, dataout);
            m5: submodule port map (addr, wr, bhe, sel(5), datain, dataout);
            m6: submodule port map (addr, wr, bhe, sel(6), datain, dataout);
            m7: submodule port map (addr, wr, bhe, sel(7), datain, dataout);

end Behavioral;

