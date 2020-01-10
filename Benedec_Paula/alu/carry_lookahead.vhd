----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 23.10.2019 17:38:53
-- Design Name: 
-- Module Name: carry_lookahead - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity carry_lookahead is
  generic (
   g_WIDTH : natural := 2
   );
 port (
   i_add_term1  : in std_logic_vector(g_WIDTH-1 downto 0);
   i_add_term2  : in std_logic_vector(g_WIDTH-1 downto 0);
   i_carry_in: in std_logic;
   o_carry_out: out std_logic;
   o_result   : out std_logic_vector(g_WIDTH-1 downto 0)
   );
end carry_lookahead;

architecture Behavioral of carry_lookahead is

component full_adder is
    port (
      i_bit1  : in  std_logic;
      i_bit2  : in  std_logic;
      i_carry : in  std_logic;
      o_sum   : out std_logic;
      o_carry : out std_logic);
  end component full_adder;
  
  signal p:std_logic_vector(g_WIDTH downto 0);
  signal q:std_logic_vector(g_WIDTH downto 0);
  signal cout:  std_logic_vector(g_WIDTH downto 0);
   signal w_CARRY : std_logic_vector(g_WIDTH downto 0);
   signal w_SUM   : std_logic_vector(g_WIDTH-1 downto 0);

begin

 SET_WIDTH : for ii in 0 to g_WIDTH-1 generate
    i_FULL_ADDER_INST : full_adder
      port map (
        i_bit1  => i_add_term1(ii),
        i_bit2  => i_add_term2(ii),
        i_carry => w_CARRY(ii),
        o_sum   => w_SUM(ii),
        o_carry => cout(ii)
        );
         end generate SET_WIDTH;
         
         


end Behavioral;
