library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control_Amplifier is
  Port (
  SA0: in std_logic;
  SRD: in std_logic;
  SWR: in std_logic;
  A0: out std_logic;
  RD: out std_logic;
  WR: out std_logic
  );
end Control_Amplifier;

architecture Behavioral of Control_Amplifier is

begin
A0 <= SA0;
WR <= SWR;
RD <= SRD;
end Behavioral;