library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control_unit is
Port(
    clk:in STD_LOGIC;
    rst:in STD_LOGIC;
    en:in STD_LOGIC;
    opcode, func :in std_ulogic_vector(5 downto 0);
    IorD, MemWrite, RegDst, RegWrite, AluSrcA, MemtoReg, IRWrite, PCWrite :out STD_LOGIC;
    AluSrcB, AluOp :out std_ulogic_vector(1 downto 0)
);
end Control_unit;

architecture Behavioral of Control_unit is

type states is (fetch_s, decode_s, lw_sw_ex_s, lw_mem_s, sw_mem_s, lw_wb_s, r_type_ex_s, r_type_mem_s);
signal curr_state, next_state : states := fetch_s;

begin

----------------------------PHASE GENERATOR + CONTROL UNIT----------------------------------------
process(clk, rst)
    begin
        if rst = '0' then
            curr_state <= fetch_s;
        elsif rising_edge(clk) then
            if en = '1' then
                curr_state <= next_state;
            end if;
        end if;
 end process;
--------------------------------------------------------------------------------------------------  
                    --GENERATE CONTROL SIGNALS AND NEXT STATE FOR EACH STATE--
--------------------------------------------------------------------------------------------------  
process(curr_state,opcode,func)
    begin
        case curr_state is
            when fetch_s =>  next_state <= decode_s;
                             RegDst <= '0'; RegWrite <= '0'; AluSrcA <= '0'; MemWrite <= '0'; MemtoReg <= '0'; 
                             IorD   <= '0'; IRWrite  <= '1'; PCWrite <= '1'; AluOp    <= "00"; AluSrcB <= "01";
            when decode_s => case opcode is
                                when "000000" => next_state <= r_type_ex_s;
                                when "100011" => next_state <= lw_sw_ex_s;
                                when "101011" => next_state <= lw_sw_ex_s;
                                when others => next_state <= fetch_s;
                             end case;
                             RegDst <= '0'; RegWrite <= '0'; AluSrcA <= '0'; MemWrite <= '0'; MemtoReg <= '0'; 
                             IorD   <= '0'; IRWrite  <= '0'; PCWrite <= '0'; AluOp    <= "00"; AluSrcB <= "11";
            when lw_sw_ex_s => if opcode = "100011" then next_state <= lw_mem_s;
                               else next_state <= sw_mem_s;
                               end if;
                               RegDst <= '0'; RegWrite <= '0'; AluSrcA <= '1'; MemWrite <= '0'; MemtoReg <= '0'; 
                               IorD   <= '0'; IRWrite  <= '0'; PCWrite <= '0'; AluOp    <= "00"; AluSrcB <= "10";
            when sw_mem_s => next_state <= fetch_s;
                             RegDst <= '0'; RegWrite <= '0'; AluSrcA <= '0'; MemWrite <= '1'; MemtoReg <= '0'; 
                             IorD   <= '1'; IRWrite  <= '0'; PCWrite <= '0'; AluOp    <= "00"; AluSrcB <= "00";
            when lw_mem_s => next_state <= lw_wb_s;
                             RegDst <= '0'; RegWrite <= '0'; AluSrcA <= '0'; MemWrite <= '0'; MemtoReg <= '0'; 
                             IorD   <= '1'; IRWrite  <= '0'; PCWrite <= '0'; AluOp    <= "00"; AluSrcB <= "00";
            when lw_wb_s => next_state <= fetch_s;
                            RegDst <= '0'; RegWrite <= '1'; AluSrcA <= '0'; MemWrite <= '0'; MemtoReg <= '1'; 
                            IorD   <= '0'; IRWrite  <= '0'; PCWrite <= '0'; AluOp    <= "00"; AluSrcB <= "00";
            when r_type_ex_s => next_state <= r_type_mem_s;
                                RegDst <= '0'; RegWrite <= '0'; AluSrcA <= '1'; MemWrite <= '0'; MemtoReg <= '0'; 
                                IorD   <= '0'; IRWrite  <= '0'; PCWrite <= '0'; AluSrcB <= "00";
                                case func is
                                    when "100000" => AluOp <= "00";
                                    when "100010" => AluOp <= "01";
                                    when "100100" => AluOp <= "10";
                                    when others => AluOp <= "11";
                                end case;
            when r_type_mem_s => next_state <= fetch_s;
                                 RegDst <= '1'; RegWrite <= '1'; AluSrcA <= '0'; MemWrite <= '0'; MemtoReg <= '0'; 
                                 IorD   <= '0'; IRWrite  <= '0'; PCWrite <= '0'; AluOp    <= "00"; AluSrcB <= "00";
     end case;                                           
 end process;
 ---------------------------------------------------------------------------------------------------------
end Behavioral;
