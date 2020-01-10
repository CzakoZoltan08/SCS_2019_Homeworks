library ieee;
use ieee.std_logic_1164.all;
 
entity ripple_carry_adder_tb is
end ripple_carry_adder_tb;
 
 
architecture rtl of ripple_carry_adder_tb is
 
  constant c_WIDTH : integer := 2;
   
  signal r_ADD_1  : std_logic_vector(c_WIDTH-1 downto 0) := (others => '0');
  signal r_ADD_2  : std_logic_vector(c_WIDTH-1 downto 0) := (others => '0');
  signal w_RESULT : std_logic_vector(c_WIDTH-1 downto 0);
  signal carry_in: std_logic;
  signal carry_out:std_logic;
  component ripple_carry_adder is
    generic (
      g_WIDTH : natural
      );
    port (
      i_add_term1 : in  std_logic_vector(g_WIDTH-1 downto 0);
      i_add_term2 : in  std_logic_vector(g_WIDTH-1 downto 0);
      i_carry_in: in std_logic;
      o_carry_out: out std_logic;
      o_result    : out std_logic_vector(g_WIDTH-1 downto 0)
      );
  end component ripple_carry_adder;
 
begin
 
  
  UUT : ripple_carry_adder
    generic map (
      g_WIDTH     => c_WIDTH
      )
    port map (
      i_add_term1 => r_ADD_1,
      i_add_term2 => r_ADD_2,
      i_carry_in=>carry_in,
      o_carry_out=>carry_out,
      o_result    => w_RESULT
      
      );
   
  
  process is
  begin
    r_ADD_1 <= "00";
    r_ADD_2 <= "01";
    carry_in<='1';
    wait for 10 ns;
    r_ADD_1 <= "10";
    r_ADD_2 <= "01";
    carry_in<='0';
    wait for 10 ns;
    r_ADD_1 <= "01";
    r_ADD_2 <= "11";
    carry_in<='1';
    wait for 10 ns;
    r_ADD_1 <= "11";
    r_ADD_2 <= "11";
    carry_in<='0';
    wait;
  end process;
   
end rtl;