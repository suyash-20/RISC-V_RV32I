module msrv32_instruction_decoder(
    flush_in, msrv_riscv32_mp_instr_in, 
    opcode_out, funct3_out, funct7_out, rs1_addr_out, rs2_addr_out, rd_addr_out, csr_addr_out, instr__31_7_out);

    parameter WIDTH = 32;
    parameter ADDR_WIDTH = 5;

    input flush_in;
    input [WIDTH-1:0]msrv_riscv32_mp_instr_in;

    output reg [6:0]opcode_out, funct7_out;
    output reg [2:0] funct3_out;
    output reg [ADDR_WIDTH-1:0]rs1_addr_out, rs2_addr_out, rd_addr_out;
    output reg [11:0]csr_addr_out;
    output reg [24:0]instr_31_7_out;
    reg [WIDTH-1:0] instr_mux_temp;


    always@(*) begin        

        if(flush_in)begin
            instr_mux_temp = 32'h00000013;
                begin
                    opcode_out = instr_mux_temp[6:0];
                    funct3_out = instr_mux_temp[14:12];
                    funct7_out = instr_mux_temp[31:25];
                    csr_addr_out = instr_mux_temp[31:20];
                    rs1_addr_out = instr_mux_temp[19:15];
                    rs2_addr_out = instr_mux_temp[24:20];
                    rd_addr_out = instr_mux_temp[11:7];
                    instr_31_7_out = instr_mux_temp[31:7];    
                end
        end

        else begin
            instr_mux_temp = msrv_riscv32_mp_instr_in;
                begin
                    opcode_out = instr_mux_temp[6:0];
                    funct3_out = instr_mux_temp[14:12];
                    funct7_out = instr_mux_temp[31:25];
                    csr_addr_out = instr_mux_temp[31:20];
                    rs1_addr_out = instr_mux_temp[19:15];
                    rs2_addr_out = instr_mux_temp[24:20];
                    rd_addr_out = instr_mux_temp[11:7];
                    instr_31_7_out = instr_mux_temp[31:7];    
                end
                
        end

    end

endmodule