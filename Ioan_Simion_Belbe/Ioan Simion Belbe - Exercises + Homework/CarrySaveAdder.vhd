LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
 
 
 
ENTITY CarrySaveAdder IS
		PORT ( 
				a    :  in STD_LOGIC_VECTOR (3 downto 0);
				b    :  in STD_LOGIC_VECTOR (3 downto 0);
				c    :  in STD_LOGIC_VECTOR (3 downto 0);
				cout : out STD_LOGIC;
				s    : out STD_LOGIC_VECTOR (4 downto 0)
			   );			
END CarrySaveAdder;
 
 
 
ARCHITECTURE BehavioralCSA OF CarrySaveAdder IS
 
 
	COMPONENT FullAdder
		PORT ( 
				A    :  in STD_LOGIC;
				B    :  in STD_LOGIC;
				CIN  :  in STD_LOGIC;
				S    : out STD_LOGIC;
				COUT : out STD_LOGIC
			  );
	END COMPONENT;
 

	SIGNAL intermidiateA, intermidiateB, carries : STD_LOGIC_VECTOR(3 downto 0);
 
 
	BEGIN
	
			GenerateCarrySaveAdders: FOR i IN 0 TO 3 GENERATE
						
						VeryFirstCSA: IF i = 0 GENERATE
						
							CarrySaveAdder0: FullAdder 
									PORT MAP (
												 A    =>             a(i),
												 B    =>             b(i),
												 CIN  =>             c(i),
												 S    =>             s(i),
												 COUT => intermidiateA(i)
												 );
						END GENERATE VeryFirstCSA;
						
						RestCSA: IF i > 0 GENERATE
						
							 CarrySaveAdderI: FullAdder 
									PORT MAP (
												 A    =>                 a(i),
												 B    =>                 b(i),
												 CIN  =>                 c(i),
												 S    => intermidiateB(i - 1),
												 COUT =>     intermidiateA(i)
												 );
						END GENERATE RestCSA;
						
			END GENERATE GenerateCarrySaveAdders;
			
			
			carries(0)       <= '0';
			intermidiateB(3) <= '0';
 
 
			GenerateRippleCarryAdders: FOR i IN 0 TO 3 GENERATE
						
						FirstsRCA: IF i < 3 GENERATE
						
							RippleCarryAdderI: FullAdder 
									PORT MAP (
												 A    => intermidiateA(i),
												 B    => intermidiateB(i),
												 CIN  =>       carries(i),
												 S    =>         s(i + 1),
												 COUT =>   carries(i + 1)
												 );
						END GENERATE FirstsRCA;
						
						LastRCA: IF i = 3 GENERATE
						
							 RippleCarryAdder3: FullAdder 
									PORT MAP (
												 A    => intermidiateA(i),
												 B    => intermidiateB(i),
												 CIN  =>       carries(i),
												 S    =>         s(i + 1),
												 COUT =>             cout
												 );
						END GENERATE LastRCA;
						
			END GENERATE GenerateRippleCarryAdders;

 
END BehavioralCSA;