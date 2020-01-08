library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.Numeric_Std.all;



entity memory is
     port (
           cs      :  in std_logic;
           we      :  in std_logic;
           address :  in std_logic_vector(15 downto 0);
           datain  :  in std_logic_vector(7 downto 0);
           dataout : out std_logic_vector(7 downto 0)
          );
end memory;



architecture Behavioral of memory is
	
   type ram_type is array (0 to 63) of std_logic_vector(0 to 7);
   
   signal ram : ram_type;
   
   signal read_address : std_logic_vector(15 downto 0);

    begin
        process(cs, we, datain, address) is
          begin
             if cs = '0' then
                if we = '0' then
                  ram(to_integer(unsigned(address))) <= datain;
                  
                end if;
                
                read_address <= address;
                
             end if;
             
        end process;
    
        
        process(we)
            begin
             if we = '1' then
                dataout <= ram(to_integer(unsigned(read_address)));
             end if;
        end process;

end Behavioral;

