library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity decoder is
    port ( 
           addr :  in  std_logic_vector(6 downto 0);
		   rd   :  in  std_logic;
           wr   :  in  std_logic;
           sel  : out  std_logic_vector(7 downto 0)			 
		 );
end decoder;



architecture Behavioral of decoder is


    signal output : std_logic_vector(7 downto 0):= "00000001";
    
    signal inter1 : std_logic;
    signal inter2 : std_logic;
    
    signal e1 : std_logic; 
    signal e2 : std_logic;
    
    begin
    
        process(addr, rd, wr, e1, e2)
        begin
            if(e1 = '0' and e2 = '0') then
                case(addr(2 downto 0)) is
                    when "000" => output <= "11111110";
                    when "001" => output <= "11111101";
                    when "010" => output <= "11111011";
                    when "011" => output <= "11110111";
                    when "100" => output <= "11101111";
                    when "101" => output <= "11011111";
                    when "110" => output <= "10111111";
                    when "111" => output <= "01111111";
                    
                    when others => output <="00000000";
                end case;
                
            end if;
        
        end process;
    
    
        process(addr)
        begin
        
            inter1 <= not(not(addr(3)) AND not(addr(4)) AND addr(5) AND addr(6));
            
        end process;
    
    
        process(rd, wr)
        begin 
        
            inter2 <= rd AND wr;
            
        end process;
    
        sel <= output;
        e1  <= inter1;
        e2  <= inter2;


end Behavioral;

