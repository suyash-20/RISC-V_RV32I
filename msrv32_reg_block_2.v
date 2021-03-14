module msrv32_reg_block_2(clk_in, reset_in, branch_taken_in,
    rd_addr_in, csr_addr_in, rs1_in, rs2_in, pc_in, pc_plus_4_in,
    alu_opcode_in, load_size_in, load_unsigned_in, alu_src_in, csr_wr_en_in,
    rf_wr_en_in, wb_mux_sel_in, csr_op_in, imm_in, iadder_out_in,
    
    rd_addr_reg_out, csr_addr_reg_out, rs1_reg_out, rs2_reg_out, pc_reg_out, pc_plus_4_reg_out,
    alu_opcode_reg_out, load_size_reg_out, load_unsigned_reg_out, alu_src_reg_out, csr_wr_en_reg_out,
    rf_wr_en_reg_out, wb_mux_sel_reg_out, csr_op_reg_out, imm_reg_out, iadder_out_reg_out);

    parameter WIDTH = 32;

    //input
    input clk_in, reset_in, branch_taken_in, load_unsigned_in, alu_src_in, csr_wr_en_in, rf_wr_en_in;
    input [1:0] load_size_in;
    input [2:0] wb_mux_sel_in, csr_op_in;
    input [3:0] alu_opcode_in;
    input [4:0]rd_addr_in;
    input [11:0] csr_addr_in;
    input [WIDTH-1:0] rs1_in, rs2_in, pc_in, pc_plus_4_in, iadder_out_in, imm_in;


    //output
    output reg load_unsigned_reg_out, alu_src_reg_out, csr_wr_en_reg_out, rf_wr_en_reg_out;  //branch_taken_in output equivalent signal ???
    output reg [1:0] load_size_reg_out;
    output reg [2:0] wb_mux_sel_reg_out, csr_op_reg_out;
    output reg [3:0] alu_opcode_reg_out;
    output reg [4:0] rd_addr_reg_out;
    output reg [11:0] csr_addr_reg_out;
    output reg [WIDTH-1:0] rs1_reg_out, rs2_reg_out, pc_reg_out, pc_plus_4_reg_out, iadder_out_reg_out, imm_reg_out;

    always @(posedge clk_in) begin
        
        if(reset_in) begin

            load_unsigned_reg_out = 1'b0;
            alu_src_reg_out = 1'b0;
            csr_wr_en_reg_out = 1'b0;
            rf_wr_en_reg_out = 1'b0;

            load_size_reg_out = 2'b00;

            wb_mux_sel_reg_out = 3'b000;
            csr_op_reg_out = 3'b000;

            alu_opcode_reg_out = 4'b0000;

            rd_addr_reg_out = 5'b0_0000;

            csr_addr_reg_out = 12'b0000_0000_0000;

            rs1_reg_out = 32'd0;
            rs2_reg_out = 32'd0;
            pc_reg_out = 32'd0;
            pc_plus_4_reg_out = 32'd0;
            iadder_out_reg_out = 32'd0;
            imm_reg_out = 32'd0;
            
        end

        else begin

            load_unsigned_reg_out = load_unsigned_in;
            alu_src_reg_out = alu_src_in;
            csr_wr_en_reg_out = csr_wr_en_in;
            rf_wr_en_reg_out = rf_wr_en_in;

            load_size_reg_out = load_size_in;

            wb_mux_sel_reg_out = wb_mux_sel_in;
            csr_op_reg_out = csr_op_in;

            alu_opcode_reg_out = alu_opcode_in;

            rd_addr_reg_out = rd_addr_in;

            csr_addr_reg_out = csr_addr_in;

            rs1_reg_out = rs1_in;
            rs2_reg_out = rs2_in;
            pc_reg_out = pc_in;
            pc_plus_4_reg_out = pc_plus_4_in;
            
            imm_reg_out = imm_in;
            
            iadder_out_reg_out[WIDTH-1:1] = iadder_out_in[WIDTH-1:1];
            iadder_out_reg_out[0] = (branch_taken_in) ? 1'b0 : iadder_out_in[0];
            
            
        end

    end

endmodule