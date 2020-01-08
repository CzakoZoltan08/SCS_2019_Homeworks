library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



ENTITY CarryLookaheadAdderModule IS
  PORT (
		  CIN  :    in STD_LOGIC;
		  A    :    in STD_LOGIC;
		  B    :    in STD_LOGIC;
		  COUT :   out STD_LOGIC
	   );
END CarryLookaheadAdderModule;



ARCHITECTURE BehavioralCLAM OF CarryLookaheadAdderModule IS


	SIGNAL P, G : STD_LOGIC;
	
	
	BEGIN
	
	G <= A  or B;
	P <= A and B;
	
	COUT <= G and (P or CIN);
	
	
END BehavioralCLAM;