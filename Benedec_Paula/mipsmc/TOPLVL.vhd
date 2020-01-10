----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 26.11.2019 10:30:11
-- Design Name: 
-- Module Name: TOPLVL - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TOPLVL is
  Port (  clk : in STD_LOGIC;
         btn : in STD_LOGIC_VECTOR (4 downto 0);
         sw : in STD_LOGIC_VECTOR (15 downto 0);
         led : out STD_LOGIC_VECTOR (15 downto 0);
         an : out STD_LOGIC_VECTOR (3 downto 0);
         cat : out STD_LOGIC_VECTOR (6 downto 0) );
end TOPLVL;

architecture Behavioral of TOPLVL is

component alu is 
generic (width: integer :=32);
PORT (
        a, b : IN STD_LOGIC_VECTOR(width-1 DOWNTO 0);
        opcode : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
        result : OUT STD_LOGIC_VECTOR(width-1 DOWNTO 0);
        zero : OUT STD_LOGIC);

end component;

component instreg IS
generic (width : integer :=32);
PORT (
        clk : IN STD_LOGIC;
        rst_n : IN STD_LOGIC;
        memdata : IN STD_LOGIC_VECTOR(width-1 DOWNTO 0);
        IRWrite : IN STD_LOGIC;
        instr_31_26 : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
        instr_25_21 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
        instr_20_16 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
        instr_15_0 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0) );
end component;

component pc IS
     generic ( width : integer :=32);
     PORT (
        clk : IN STD_LOGIC;
        rst_n : IN STD_LOGIC;
        pc_in : IN STD_LOGIC_VECTOR(width-1 DOWNTO 0);
        PC_en : IN STD_LOGIC;
        pc_out : OUT STD_LOGIC_VECTOR(width-1 DOWNTO 0) );
        
end component;

component regfile IS
    generic(width : integer :=32;
            regfile_depth : positive := 32;
            regfile_adrsize : positive := 5

);
PORT (clk,rst_n : IN std_LOGIC;
      wen : IN std_LOGIC; -- write control
      writeport : IN std_LOGIC_vector(width-1 DOWNTO 0); -- register input
      adrwport : IN std_LOGIC_vector(regfile_adrsize-1 DOWNTO 0);-- address write
      adrport0 : IN std_LOGIC_vector(regfile_adrsize-1 DOWNTO 0);-- address port 0
      adrport1 : IN std_LOGIC_vector(regfile_adrsize-1 DOWNTO 0);-- address port 1
      readport0 : OUT std_LOGIC_vector(width-1 DOWNTO 0); -- output port 0
      readport1 : OUT std_LOGIC_vector(width-1 DOWNTO 0) -- output port 1
);

end component;

component regUniv is
  Port ( clk: in std_logic;
         wrEn: in std_logic;
         input: in std_logic_vector(31 downto 0);
         output: out std_logic_vector(31 downto 0) );

end component;

component MEM is
  Port (    clk:in std_logic;
            en: in std_logic;
            wrEn: in std_logic;
            readAddr :in std_logic_vector(31 downto 0);
            readData:in std_logic_vector(31 downto 0);
            writeData:out std_logic_vector(31 downto 0));


end component;

component ssd 
    Port ( digit : in STD_LOGIC_VECTOR (15 downto 0);
           clk : in STD_LOGIC;
           cat : out STD_LOGIC_VECTOR (6 downto 0);
           an : out STD_LOGIC_VECTOR (3 downto 0));
end component;

component debounce IS
  PORT(
        clk:in STD_LOGIC;
        btn:in STD_LOGIC;
        Enable:out STD_LOGIC
        
    );
END component;

component  Control is
  Port (clk: in std_logic;
        rst: in std_logic;
        en:in std_logic;
        opcode: in std_logic_vector(5 downto 0);
        funct:in std_logic_vector(5 downto 0);
        IORD:out std_logic;
        RegDst:out std_logic;
        MemToReg:out std_logic;
        MEM_WRITE:out std_logic; 
        RegWrite:out std_logic; 
        IRWrite:out std_logic; 
        ALUSrcA:out std_logic; 
        ALU_EN:out std_logic; 
        PC_EN:out std_logic;
        A_EN:out std_logic; 
        B_EN:out std_logic; 
        wrEn_MR:out std_logic;
        ALUSrcB:out std_logic_vector(1 downto 0); 
        ALUOp:out std_logic_vector(1 downto 0)
        
         );
end component;

--pc
signal ALU_RES:std_logic_vector(31 downto 0);
signal PC_OUT:std_logic_vector(31 downto 0);
signal PC_RESET:std_logic;
signal PC_EN:std_logic;

signal mux1:std_logic_vector(31 downto 0);
signal IORD:std_logic;

signal RegDst:std_logic;
signal mux2:std_logic_vector(4 downto 0);

signal MemToReg:std_logic;
signal mux3:std_logic_vector(31 downto 0);
signal AluOUT:std_logic_vector(31 downto 0);

--memory
signal MEM_READ:std_logic;
signal MEM_WRITE:std_logic;

signal MEM_OUT:std_logic_vector(31 downto 0);

--memory reg
signal wrEn_MR: std_logic;
signal MReg_OUT:std_logic_vector(31 downto 0);

signal B_OUT:std_logic_vector(31 downto 0);

--instr reg
signal IR_RESET: std_logic;
signal IRWrite: std_logic;
signal i_31_26 :  STD_logic_VECTOR(5 DOWNTO 0);
signal i_25_21 : STD_logic_VECTOR(4 DOWNTO 0);
signal i_20_16 :  STD_logic_VECTOR(4 DOWNTO 0);
signal i_15_0 : STD_logic_VECTOR(15 DOWNTO 0);

--regFilee

signal RESET_RF:std_logic;
signal RegWrite:std_logic;
signal regA:std_logic_vector(31 downto 0);
signal regB:std_logic_vector(31 downto 0);

--A&B

signal A_EN,B_EN:std_logic;
signal A_ENF,B_ENF:std_logic;
signal ALUSrcA:std_logic;
signal AluSrcB:std_logic_vector(1 downto 0);
signal A:std_logic_vector(31 downto 0);
signal B:std_logic_vector(31 downto 0);

--mux4
signal mux4:std_logic_vector(31 downto 0);
signal mux5:std_logic_vector(31 downto 0);

--mux5
signal Sign_EXT:std_logic_vector(31 downto 0);

--aluu
signal zero0:std_logic;
signal ALU_EN:std_logic;
signal ALUOp:std_logic_vector(1 downto 0);
signal ALU_RES_OUT:std_logic_vector(31 downto 0);

signal Enable:std_logic;
signal Reset:std_logic;
signal ALU_ENF:std_logic;
signal PC_ENF:std_logic;
signal RegWriteF:std_logic;
signal IRWriteF:std_logic;
signal wrEn_MRF:std_logic;

signal afis16:std_logic_vector(15 downto 0);
signal afis32:std_logic_vector(31 downto 0);

begin

    c1: pc port map(clk => clk,
                    rst_n =>reset,
                    pc_in =>ALU_RES,
                    PC_en =>PC_ENF,
                    pc_out =>PC_OUT);
     PC_ENF<=PC_EN and enable;               
                    --mux1
                    
      mux1<= PC_OUT when IORD = '0'
                    else ALU_RES_OUT;             
    c2: MEM port map(clk=> clk,
                     en=>enable,
                     wrEn=> MEM_WRITE,
                      readAddr=> mux1,
                      readData=>B,
                      writeData=>MEM_OUT);
                      
   mem_reg: regUniv port map( clk=>clk,
                              wrEn=> wrEn_MRF,
                              input=>MEM_OUT,
                              output=>MReg_OUT);
   wrEn_MRF<=wrEn_MR and enable;                           
  c3: instreg port map(clk=>clk,
                       rst_n=>reset,
                       memdata =>MEM_OUT,
                       IRWrite=>IRWriteF,
                       instr_31_26 =>i_31_26,
                       instr_25_21=> i_25_21,
                       instr_20_16=>i_20_16,
                       instr_15_0=>i_15_0);
      IRWriteF<=IRWrite and enable;        
    --mux2
    mux2<= i_20_16 when RegDst='0'
        else i_15_0(15 downto 11);
    
    --mux3
    mux3<= ALU_RES_OUT when MemToReg='0'
        else MReg_OUT;
        
  --registeers      
   c4: regfile port map( clk=>clk,
                        rst_n=>reset, 
                        wen =>RegWriteF, -- write control
                        writeport =>mux3, -- register input
        adrwport =>mux2, -- address write
        adrport0 => i_25_21,-- address port 0
        adrport1=> i_20_16,-- address port 1
        readport0=>regA, -- output port 0
        readport1 =>regB ); 
        
        RegWriteF<=RegWrite and enable;
        
  Reg_A: regUniv port map(clk=>clk,
                                  wrEn=>A_ENF,
                                  input=>regA,
                                  output=>A);
                                  
                                  A_ENF<=A_EN and enable;
  Reg_B: regUniv port map(clk=>clk,
                          wrEn=>B_ENF,
                          input=>regB,
                          output=>B);
   B_ENF<=B_EN and enable;
  --mux4
   mux4<= PC_OUT when ALUSrcA ='0'
         else A;
  --mux5 
  
  Sign_EXT<= x"0000" & i_15_0;
  mux5<= B when ALUSrcB ="00"
           else x"00000001" when ALUSrcB ="01"
           else  Sign_EXT;
           
c5: alu port map ( a=>mux4,
                  b =>mux5,
                  opcode=>ALUOp,
                  result =>ALU_RES,
                  zero =>zero0);
                  
 regALU:regUniv port map (clk=>clk,
                          wrEn=>ALU_ENF,
                          input=>ALU_RES,
                          output=>ALU_RES_OUT);
    ALU_ENF<= ALU_EN and enable;                      
 debounce_EN: debounce port map (clk=>clk,
                                  btn=>btn(0),
                                  Enable=>Enable);
 debounce_RESET: debounce port map (clk=>clk,
                                    btn=>btn(1),
                                    Enable=>Reset);
afis16<= afis32(31 downto 16) when sw(15)='1'
            else afis32(15 downto 0);

 c7: ssd port map(digit=>afis16,
                    clk=>clk,
                    cat=>cat,
                    an=>an);
   
   Afis32<= PC_OUT when sw(3 downto 0) = "0000"
                    else ALU_RES  when sw(3 downto 0) = "0001"
                    else ALU_RES_OUT  when sw(3 downto 0) = "0010"
                    else A when sw(3 downto 0) = "0011"
                    else B when sw(3 downto 0) = "0100"
                    else MEM_OUT;
                    
    c8: Control port map(clk=> clk,
                            rst=>reset,
                            en=> enable,
                            opcode=>i_31_26,
                            funct=>i_15_0(5 downto 0),
                            IORD=>IORD,
                            RegDst=>RegDst,
                            MemToReg=>MemToReg,
                            MEM_WRITE=>MEM_WRITE,
                            RegWrite=>RegWrite, 
                            IRWrite=>IRWrite,
                            ALUSrcA=>ALUSrcA,
                            ALU_EN=>ALU_EN,
                            PC_EN=>PC_EN,
                            A_EN=>A_EN,
                            B_EN=>B_EN,                        
                            wrEn_MR=>wrEn_MR,
                            ALUSrcB=>ALUSrcB, 
                            ALUOp=>ALUOp);                
                    
   led(15)<= PC_EN;
   led(14)<=IORD;
   led(13)<=MEM_WRITE;
   led(12)<=IRWrite;
   led(11)<=wrEn_MR;
   led(10)<=A_EN;
   led(9)<=B_EN;
   led(8)<=ALU_EN;
   led(7)<=RegWrite;
   led(6)<=RegDst;
   led(5)<=MemToReg;
   led(4)<=AluSrcA;
   led(3 downto 2)<= ALUSrcB;
   led(1 downto 0)<=ALUOp;
   
   
                   
end Behavioral;
