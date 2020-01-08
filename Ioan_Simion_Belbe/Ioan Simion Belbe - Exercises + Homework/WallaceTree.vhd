--Implemented a TUTORIAL

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;



ENTITY Multiply IS
	PORT ( 
			a       :  in  STD_LOGIC_VECTOR (3 downto 0);
         b       :  in  STD_LOGIC_VECTOR (3 downto 0);
         Product : out  STD_LOGIC_VECTOR (7 downto 0));
END Multiply;



ARCHITECTURE BehavioralMultiply OF Multiply IS


	COMPONENT FullAdder
		PORT ( 
				A    :  in STD_LOGIC;
				B    :  in STD_LOGIC;
				CIN  :  in STD_LOGIC;
				S    : out STD_LOGIC;
				COUT : out STD_LOGIC
			  );
	END COMPONENT;
	

	COMPONENT HalfAdder
		PORT ( 
				A    :  in STD_LOGIC;
				B    :  in STD_LOGIC;
				S    : out STD_LOGIC;
				COUT : out STD_LOGIC
			  );
	END COMPONENT;


	SIGNAL s11, s12, s13, s14, s15, s22, s23, s24, s25, s26, s32, s33, s34, s35, s36, s37, c11, c12, c13, c14, c15, c22, c23, c24, c25, c26, c32, c33, c34, c35, c36, c37 : STD_LOGIC;

	SIGNAL p0, p1, p2, p3 : STD_LOGIC_VECTOR (6 downto 0);


	BEGIN

		PROCESS(A, B)
		BEGIN
		
			 FOR i IN 0 TO 3 LOOP
			 
				  p0(i) <= a(i) AND b(0);
				  p1(i) <= a(i) AND b(1);
				  p2(i) <= a(i) AND b(2);
				  p3(i) <= a(i) AND b(3);
				  
			 END LOOP;   
			 
		END PROCESS;
		
			 
		Product(0) <= p0(0);
		Product(1) <=  s11;
		Product(2) <=  s22;
		Product(3) <=  s32;
		Product(4) <=  s34;
		Product(5) <=  s35;
		Product(6) <=  s36;
		Product(7) <=  s37;


		--Firsts in Row
		ha11: HalfAdder 
					PORT MAP (
								  A    => p0(1),
								  B    => p1(0),
								  S    =>   s11,
								  COUT =>   c11
								);
						
		fa12: FullAdder 
					PORT MAP (
								  A    => p0(2),
								  B    => p1(1),
								  CIN  => p2(0),
								  S    =>   s12,
								  COUT =>   c12
								);
						
		fa13: FullAdder 
					PORT MAP (
								  A    => p0(3),
								  B    => p1(2),
								  CIN  => p2(1),
								  S    =>   s13,
								  COUT =>   c13
								);
		
		fa14: FullAdder 
					PORT MAP (
								  A    => p1(3),
								  B    => p2(2),
								  CIN  => p3(1),
								  S    =>   s14,
								  COUT =>   c14
								);
		
		ha15: HalfAdder 
					PORT MAP (
								  A    => p2(3),
								  B    => p3(2),
								  S    =>   s15,
								  COUT =>   c15
								);
						

		--Seconds in Row
		ha22: HalfAdder 
					PORT MAP (
								  A    => c11,
								  B    => s12,
								  S    => s22,
								  COUT => c22
								);
								
		fa23: FullAdder 
					PORT MAP (
								  A    => p3(0),
								  B    =>   c12,
								  CIN  =>   s13,
								  S    =>   s23,
								  COUT =>   c23
								);
		
		fa24: FullAdder 
					PORT MAP (
								  A    => c13,
								  B    => c32,
								  CIN  => s14,
								  S    => s24,
								  COUT => c24
								);
		
		fa25: FullAdder 
					PORT MAP (
								  A    => c14,
								  B    => c24,
								  CIN  => s15,
								  S    => s25,
								  COUT => c25
								);
		
		fa26: FullAdder 
					PORT MAP (
								  A    =>   c15,
								  B    =>   c25,
								  CIN  => p3(3),
								  S    =>   s26,
								  COUT =>   c26
								);
		

		--Thirds in Row
		ha32: HalfAdder 
					PORT MAP (
								  A    => c22,
								  B    => s23,
								  S    => s32,
								  COUT => c32
								);
		
		ha34: HalfAdder 
					PORT MAP (
								  A    => c23,
								  B    => s24,
								  S    => s34,
								  COUT => c34
								);
		
		ha35: HalfAdder 
					PORT MAP (
								  A    => c34,
								  B    => s25,
								  S    => s35,
								  COUT => c35
								);
		
		ha36: HalfAdder 
					PORT MAP (
								  A    => c35,
								  B    => s26,
								  S    => s36,
								  COUT => c36
								);
		
		ha37: HalfAdder 
					PORT MAP (
								  A    => c36,
								  B    => s26,
								  S    => s37,
								  COUT => c37
								);


END BehavioralMultiply;