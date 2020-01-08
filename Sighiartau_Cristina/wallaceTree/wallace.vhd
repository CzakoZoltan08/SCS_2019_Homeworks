library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity wallace is
Port(x: in std_logic_vector(3 downto 0);
y: in std_logic_vector(3 downto 0);
res: out std_logic_vector(8 downto 0));
end wallace;

architecture Behavioral of wallace is

component full_adder3 is
Port(x: in std_logic;
y: in std_logic;
z: in std_logic;
res: out std_logic;
cout: out std_logic);
end component;

component half_adder is
    Port ( x : in  STD_LOGIC;
           y : in  STD_LOGIC;
           res : out  STD_LOGIC;
           carry : out  STD_LOGIC);
end component;

signal p0, p1, p2, p3: std_logic_vector(3 downto 0);
signal w2s1, w4s1, w8s1, w16s1, w32s1, w4s2, w8s2, w16s2, w32s2, w64s2, w8s3, w16s3, w32s3, w64s3, w128s3: std_logic;
signal c2s1, c4s1, c8s1, c16s1, c32s1, c4s2, c8s2, c16s2, c32s2, c64s2, c8s3, c16s3, c32s3, c64s3, c128s3: std_logic;

begin

process(x,y)
begin
    for i in 0 to 3 loop
        p0(i) <= x(i) and y(0);
        p1(i) <= x(i) and y(1);
        p2(i) <= x(i) and y(2);
        p3(i) <= x(i) and y(3);
    end loop;       
end process;

--stage 1:
--p0(0) -> weight 1
weight2halfadder: half_adder port map(p0(1),p1(0),w2s1,c2s1); --add x0y1 and x1y0   => w2, w4
weight4fulladder: full_adder3 port map(p2(0),p1(1),p0(2),w4s1,c4s1); --add x0y2, x1y1, x2y0 => w4, w8
weight8fulladder: full_adder3 port map(p3(0),p2(1),p1(2),w8s1,c8s1); --add x0y3, x1y2, x2y1,  //x3y0=p(0)3 (pass through) => w8, w16
weight16fulladder: full_adder3 port map(p3(1),p2(2),p1(3),w16s1,c16s1); --add x1y3, x2y2, x3y1 => w16, w32
weight32halfadder: half_adder port map(p3(2),p2(3),w32s1,c32s1); --add x2y3 and x3y2  => w32, w64

--stage 2
--w2s1 -> weight 2
weight4halfadders2: half_adder port map(c2s1,w4s1,w4s2,c4s2); -- => w4, w8
weight8fulladders2: full_adder3 port map (p0(3), w8s1, c4s1, w8s2, c8s2); -- =>w8, w16
weight16halfadders2: half_adder port map (c8s1, w16s1, w16s2, c16s2); --=> w16, w32
weight32halfadders2: half_adder port map (c16s1, w32s1, w32s2, c32s2); --=>w32, w64
weight64halfadders2: half_adder port map (c32s1, p3(3), w64s2, c64s2); --=> w64, w128


--stage3
--w4s2 -> weight 4
weight8halfadders3: half_adder port map (c4s2, w8s2, w8s3, c8s3); --=> w8, w16
weight16halfadders3: full_adder3 port map (c8s2, c8s3, w16s2, w16s3, c16s3); --=> w16, w32
weight32halfadders3: full_adder3 port map (c16s3, c16s2, w32s2, w32s3, c32s3); --=>w32, w64
weight64halfadders3: full_adder3 port map (c32s3, c32s2, w64s2, w64s3, c64s3); --=> w64, w128
weight128halfadders3: half_adder port map (c64s3, c64s2, w128s3, c128s3); --=> w64, w128

res(0) <= p0(0);
res(1) <= w2s1;
res(2) <= w4s2;
res(3) <= w8s3;
res(4) <= w16s3;
res(5) <= w32s3;
res(6) <= w64s3;
res(7) <= w128s3;
res(8) <= c128s3;

end Behavioral;

