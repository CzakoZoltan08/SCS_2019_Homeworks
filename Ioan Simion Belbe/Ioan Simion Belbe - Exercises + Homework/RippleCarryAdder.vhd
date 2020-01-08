LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;



ENTITY RippleCarryAdder IS
		PORT ( 
			   cin  :  in STD_LOGIC;
			   a    :  in STD_LOGIC_VECTOR (3 downto 0); 
			   b    :  in STD_LOGIC_VECTOR (3 downto 0); 
			   cout : out STD_LOGIC;
			   s    : out STD_LOGIC_VECTOR (3 downto 0)
			  );

END RippleCarryAdder;



ARCHITECTURE BehavioralRCA OF RippleCarryAdder IS


	COMPONENT FullAdder IS
		PORT ( 
			  A    :  in STD_LOGIC; 
			  B    :  in STD_LOGIC; 
			  CIN  :  in STD_LOGIC;
			  S    : out STD_LOGIC;
			  COUT : out STD_LOGIC
			  );
	END COMPONENT  FullAdder;
	
	
   SIGNAL intermidiateCarry : STD_LOGIC_VECTOR (2 downto 0);
		
	
BEGIN

	FullAdder_1: FullAdder 
			PORT MAP (
					  A    => 					  a(0), 
					  B    => 					  b(0), 
					  CIN  => 					   '0', 
					  S    => 					  s(0), 
					  COUT => intermidiateCarry(0)
					 );
					 
	FullAdder_2: FullAdder 
			PORT MAP (
					  A    => 					  a(1), 
					  B    => 					  b(1), 
					  CIN  => intermidiateCarry(0), 
					  S    => 					  s(1), 
					  COUT => intermidiateCarry(1)
					 );
					 
	FullAdder_3: FullAdder 
			PORT MAP (
					  A    => 					  a(2), 
					  B    => 					  b(2), 
					  CIN  => intermidiateCarry(1), 
					  S    => 					  s(2), 
					  COUT => intermidiateCarry(2)
					 );
					 
	FullAdder_4: FullAdder 
			PORT MAP (
					  A    => 					  a(3), 
					  B    => 					  b(3), 
					  CIN  => intermidiateCarry(2), 
					  S    => 					  s(3), 
					  COUT => 					  cout
					 );
	

END BehavioralRCA;

