library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



ENTITY HalfAdder IS
  PORT (
		A    :  in STD_LOGIC; 
		B    :  in STD_LOGIC; 
		S    : out STD_LOGIC;
		COUT : out STD_LOGIC
	   );
END HalfAdder;



ARCHITECTURE BehavioralHA OF HalfAdder IS


	BEGIN

		S    <= A xor B;
	
		COUT <= A and B;
	
	
END BehavioralHA;