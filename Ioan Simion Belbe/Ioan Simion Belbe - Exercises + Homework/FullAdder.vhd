library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



ENTITY FullAdder IS
  PORT (
		A    :  in STD_LOGIC; 
		B    :  in STD_LOGIC; 
		CIN  :  in STD_LOGIC;
		S    : out STD_LOGIC;
		COUT : out STD_LOGIC
	   );
END FullAdder;



ARCHITECTURE BehavioralFA OF FullAdder IS


	BEGIN

		S    <= A xor B xor CIN;
	
		COUT <= (A and B) or (CIN and A) or (CIN and B);
	
	
END BehavioralFA;