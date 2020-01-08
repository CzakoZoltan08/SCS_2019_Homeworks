library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.numeric_std.all;
USE work.procmem_definitions.ALL;

entity top_module is
  Port ( clk: in std_logic;
         btn : in STD_LOGIC_VECTOR (4 downto 0);
         sw : in STD_LOGIC_VECTOR (15 downto 0);
         led : out STD_LOGIC_VECTOR (15 downto 0);
         an : out STD_LOGIC_VECTOR (3 downto 0);
         cat : out STD_LOGIC_VECTOR (6 downto 0)
         );
end top_module;

architecture Behavioral of top_module is

--------------------COMPONENT DECLARATION---------------------
component Control_unit is
Port(
    clk:in STD_LOGIC;
    rst:in STD_LOGIC;
    en:in STD_LOGIC;
    opcode, func :in std_ulogic_vector(5 downto 0);
    IorD, MemWrite, RegDst, RegWrite, AluSrcA, MemtoReg, IRWrite, PCWrite :out STD_LOGIC;
    AluSrcB, AluOp :out std_ulogic_vector(1 downto 0)
);
end component;

component MPG is
generic (n:natural :=5);
port (  clk : in STD_LOGIC;
        inp : in STD_LOGIC_VECTOR (0 to n-1);
        oup : out STD_LOGIC_VECTOR(0 to n-1));
end component;

component Display is
generic (counterSize : natural := 15);
Port (  clk : in std_logic;
        d3,d2,d1,d0 : in std_logic_vector(3 downto 0);
        an : out std_logic_vector(3 downto 0);
        cat : out std_logic_vector(6 downto 0)
      );  
end component;

component pc IS
	PORT 
(
    clk    : IN STD_ULOGIC;
    rst_n  : IN STD_ULOGIC;
    pc_in  : IN STD_ULOGIC_VECTOR(width - 1 DOWNTO 0);
    PC_en  : IN STD_ULOGIC;
    pc_out : OUT STD_ULOGIC_VECTOR(width - 1 DOWNTO 0);
    en : in std_logic
);
END component;

component RAM is
port ( clk : in std_logic;
    we : in std_logic;
    addr : in std_ulogic_vector(31 downto 0);
    data_in_ram : in std_ulogic_vector(31 downto 0);
    data_out_ram : out std_ulogic_vector(31 downto 0);
    addr_ram_2: in std_ulogic_vector(31 downto 0);
    data_out_2 : out std_ulogic_vector(31 downto 0)
    );
end component;

component instreg IS
	PORT (
		clk         : IN STD_ULOGIC;
		rst_n       : IN STD_ULOGIC;
		memdata     : IN STD_ULOGIC_VECTOR(width - 1 DOWNTO 0);
		IRWrite     : IN STD_ULOGIC;
		instr_31_26 : OUT STD_ULOGIC_VECTOR(5 DOWNTO 0);
		instr_25_21 : OUT STD_ULOGIC_VECTOR(4 DOWNTO 0);
		instr_20_16 : OUT STD_ULOGIC_VECTOR(4 DOWNTO 0);
		instr_15_0  : OUT STD_ULOGIC_VECTOR(15 DOWNTO 0) 
	);
END component;

component regfile IS
	PORT (
		clk, rst_n : IN std_ulogic;
		wen        : IN std_ulogic; -- write control
		writeport  : IN std_ulogic_vector(width - 1 DOWNTO 0); -- register input
		adrwport   : IN std_ulogic_vector(regfile_adrsize - 1 DOWNTO 0);-- address write
		adrport0   : IN std_ulogic_vector(regfile_adrsize - 1 DOWNTO 0);-- address port 0
		adrport1   : IN std_ulogic_vector(regfile_adrsize - 1 DOWNTO 0);-- address port 1
		readport0  : OUT std_ulogic_vector(width - 1 DOWNTO 0); -- output port 0
		readport1  : OUT std_ulogic_vector(width - 1 DOWNTO 0) -- output port 1
	);
END component;

component alu IS
	PORT (
		a, b   : IN STD_ULOGIC_VECTOR(width - 1 DOWNTO 0);
		opcode : IN STD_ULOGIC_VECTOR(1 DOWNTO 0);
		result : OUT STD_ULOGIC_VECTOR(width - 1 DOWNTO 0);
		zero   : OUT STD_ULOGIC
	);
END component;
---------------------------------------------------------------------------------------

-------------------------------------CONTROL--------------------------------------------
signal IorD, MemWrite, RegDst, RegWrite, AluSrcA, MemtoReg, IRWrite, PCWrite : std_logic;
signal AluSrcB, AluOp : std_ulogic_vector(1 downto 0);
----------------------------------------------------------------------------------------

-------------------------------------SIGNALS---------------------------------------------
signal en, rst : std_logic;
signal Zero : std_ulogic;
signal A, B, MDR, PcOut, AluRes, AluOut, MemOut, MemAddress : std_ulogic_vector(width-1 downto 0);
signal readRF1, readRF2, dataRF : std_ulogic_vector(width-1 downto 0);
signal ALU_A, ALU_B, s_ext : std_ulogic_vector(width-1 downto 0);
signal opcode, func : std_ulogic_vector(5 downto 0);
signal instr_25_21, instr_20_16, addRF: std_ulogic_vector(4 downto 0);
signal instr_15_0: std_ulogic_vector(15 downto 0);

signal dis_data: std_logic_vector(15 downto 0);
signal readRAM, adr2: std_ulogic_vector(31 downto 0);
signal buttons: STD_LOGIC_VECTOR (4 downto 0);
---------------------------------------------------------------------------------------

begin
-----------------------------------INPUT BUTTONS---------------------------------------
MPG_map: MPG port map (clk=>clk, inp=>btn, oup=>buttons);
             en <= buttons(0);
             rst <= not buttons(1);
---------------------------------------------------------------------------------------


----------------------------DISPLAY----------------------------------------------------
Display_map: Display port map (clk=>clk, d3=>dis_data(15 downto 12), d2=>dis_data(11 downto 8), d1=>dis_data(7 downto 4), d0=>dis_data(3 downto 0), an=>an, cat=>cat);

                       
WhatToDisplay:process (sw(3 downto 0))
begin
  case sw(3 downto 0) is
      when "0000" => dis_data <= to_stdlogicvector(PcOut(15 downto 0));
      when "0001" => dis_data <= to_stdlogicvector(AluOut(15 downto 0));
      when "0010" => dis_data <= to_stdlogicvector(MemOut(15 downto 0));
      when "0011" => dis_data <= to_stdlogicvector(readRAM(15 downto 0));
      when "0100" => dis_data <= to_stdlogicvector(ALU_B(15 downto 0));
      when others => dis_data <= x"0000";
   end case;
end process;
-----------------------------------------------------------------------------------------

----------------------------REST OF COMPONENTS---------------------------------------------
func <= instr_15_0(5 downto 0); 
control_map: control_unit port map(clk => clk, rst => rst, en => en, opcode => opcode, func => func,
                                  IorD => IorD, MemWrite => MemWrite, RegDst => RegDst, RegWrite => RegWrite,
                                  AluSrcA => AluSrcA, MemtoReg => MemtoReg, IRWrite => IRWrite, PCWrite => PCWrite,
                                  AluSrcB => AluSrcB, AluOp => AluOp);
pc_map: pc port map (clk => clk, rst_n => rst, pc_in => AluRes, PC_en => PCWrite, pc_out => PcOut, en => en);
adr2 <= x"000000" & "00" & to_stdulogicvector(sw(15 downto 12)) & "00";
memory_map: RAM port map (clk => clk, we => MemWrite, addr => MemAddress, data_in_ram => B, data_out_ram => MemOut, addr_ram_2 => adr2, data_out_2 =>readRAM);
ir_map: instreg port map (clk => clk, rst_n => rst, memdata => MemOut, IRWrite => IRWrite, instr_31_26 => opcode,
                          instr_25_21 => instr_25_21, instr_20_16 => instr_20_16, instr_15_0 => instr_15_0);
regFile_map: regfile port map (clk => clk, rst_n => rst, wen => RegWrite, writeport => dataRF,adrwport => addRF,
                               adrport0 => instr_25_21, adrport1 => instr_20_16,readport0 => readRF1, readport1 => readRF2);   
alu_map: alu port map (a =>ALU_A, b => ALU_B, opcode => AluOp, result => AluRes, zero => zero);  
-------------------------------------------------------------------------------------------                                
 
--------------------------------ALU INPUT MULTIPLEXERS------------------------------------- 
ALU_A <= PCOut when AluSrcA = '0' else A;
ALU_B <= B           when AluSrcB = "00" else
             x"00000004" when AluSrcB = "01" else
             s_ext       when AluSrcB = "10" else
             x"00000000";                             
------------------------------------------------------------------------------------------

---------------------------REGISTER IN MUX------------------------------------------------
addRF <= instr_20_16 when regDst = '0' else 
                    instr_15_0(15 downto 11);
                    
dataRF <= AluOut when MemToReg = '0' else MDR;
------------------------------------------------------------------------------------------

------------------SIGN EXTENSION UNIT-----------------------------------------------------
s_ext <= x"0000" & instr_15_0 when instr_15_0(15) = '0' else
         x"FFFF" & instr_15_0;
------------------------------------------------------------------------------------------

----------------------MEM ADDRESS MUX-----------------------------------------------------
MemAddress <= PcOut when IorD = '0' else ALUOut;
------------------------------------------------------------------------------------------

process(clk)
    begin
        if rising_edge(clk) then
            if en = '1' then
                MDR <= MemOut;
                AluOut <= AluRes;
                A <= readRF1;
                B <= readRF2;
            end if;
        end if;
end process;

led(13) <= IorD;
led(12) <= MemWrite;
led(11) <= RegDst;
led(10) <= RegWrite;
led(9) <= AluSrcA;
led(8) <= MemtoReg;
led(7) <= IRWrite;
led(6) <= PCWrite;
led(5 downto 4) <= to_stdlogicvector(AluSrcB);
led(3 downto 2) <= to_stdlogicvector(AluOp);
      
end Behavioral;
