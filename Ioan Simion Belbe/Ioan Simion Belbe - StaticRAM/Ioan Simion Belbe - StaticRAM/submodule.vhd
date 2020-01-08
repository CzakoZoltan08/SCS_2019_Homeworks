library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity submodule is
    port(
        addr   :   in std_logic_vector(16 downto 0);
        wr      :  in std_logic;
        bhe     :  in std_logic;
        selI    :  in std_logic;
        datain  :  in std_logic_vector(15 downto 0);
        dataout : out std_logic_vector(15 downto 0)
        );
end submodule;



architecture Behavioral of submodule is


	component memory is
	 port (
		   cs  	   :  in std_logic;
		   we      :  in std_logic;
		   address :  in std_logic_vector(15 downto 0);
		   datain  :  in std_logic_vector( 7 downto 0);
           dataout : out std_logic_vector( 7 downto 0)
	      );
	end component;
	
	
    signal  selIL, selIH  : std_logic;
    
    
    begin
    
        selIL <= addr(0) or selI;
        selIH <=     not(bhe) or selI;
     
        low  : memory port map(selIL, wr, addr(16 downto 1), datain( 7 downto 0), dataout( 7 downto 0));
        high : memory port map(selIH, wr, addr(16 downto 1), datain(15 downto 8), dataout(15 downto 8));

end Behavioral;

