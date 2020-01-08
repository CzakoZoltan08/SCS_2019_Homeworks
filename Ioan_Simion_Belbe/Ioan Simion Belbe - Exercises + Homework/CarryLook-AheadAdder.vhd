library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



ENTITY CarryLookaheadAdder IS
	PORT (
			cin  :  in STD_LOGIC;
			a    :  in STD_LOGIC_VECTOR (3 downto 0); 
			b    :  in STD_LOGIC_VECTOR (3 downto 0);
			cout : out STD_LOGIC;
			s    : out STD_LOGIC_VECTOR (3 downto 0)  
		 );
END CarryLookaheadAdder;



ARCHITECTURE BehavioralCLA OF CarryLookaheadAdder IS


	COMPONENT CarryLookaheadAdderModule is
		  PORT (
					CIN  :  in STD_LOGIC;
					A    :  in STD_LOGIC;
					B    :  in STD_LOGIC;
					COUT : out STD_LOGIC
				 );
	END COMPONENT;
	
	
	COMPONENT FullAdder IS
		PORT ( 
			   A    :  in STD_LOGIC; 
			   B    :  in STD_LOGIC; 
			   CIN  :  in STD_LOGIC;
			   S    : out STD_LOGIC;
			   COUT : out STD_LOGIC
			  );
	END COMPONENT  FullAdder;
	

	SIGNAL carries   : STD_LOGIC_VECTOR (2 downto 0);
	SIGNAL doNotCare : STD_LOGIC_VECTOR (3 downto 0);
	
	
	BEGIN
	
		Carry_1: CarryLookaheadAdderModule 
			PORT MAP (
						 CIN  =>        '0', 
						 A    =>       a(0), 
						 B    =>       b(0),
						 COUT => carries(0)
						);
										 
		Carry_2: CarryLookaheadAdderModule 
			PORT MAP (
						 CIN  => carries(0), 
						 A    =>       a(1), 
						 B    =>       b(1),
						 COUT => carries(1)
						);
										 
		Carry_3: CarryLookaheadAdderModule 
			PORT MAP (
					    CIN  => carries(1), 
						 A    =>       a(2), 
						 B    =>       b(2),
						 COUT => carries(2)
						);
					 										 
		Carry_4: CarryLookaheadAdderModule 
			PORT MAP (
					    CIN  => carries(2), 
						 A    =>       a(3), 
						 B    =>       b(3),
						 COUT =>       cout
						);
	
	
		FullAdder_1: FullAdder 
			PORT MAP (
						 A    => 		  a(0), 
					    B    => 		  b(0), 
					    CIN  => 		  '0', 
					    S    => 		  s(0), 
					    COUT => doNotCare(0)
					   );
						
		FullAdder_2: FullAdder 
			PORT MAP (
						 A    => 		  a(1), 
					    B    => 		  b(1), 
					    CIN  =>   carries(0), 
					    S    => 		  s(1), 
					    COUT => doNotCare(1)
					   );
		
		FullAdder_3: FullAdder 
			PORT MAP (
						 A    => 		  a(2), 
					    B    => 		  b(2), 
					    CIN  =>   carries(1), 
					    S    => 		  s(2), 
					    COUT => doNotCare(2)
					   );
						
		FullAdder_4: FullAdder 
			PORT MAP (
						 A    => 		  a(3), 
					    B    => 		  b(3), 
					    CIN  =>   carries(2),
					    S    => 		  s(3), 
					    COUT => doNotCare(3)
					   );
	 
	 
END BehavioralCLA;