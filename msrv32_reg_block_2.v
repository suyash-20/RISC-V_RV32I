module msrv32_reg_block_2(clk_in, reset_in, branch_taken_in,
    rd_addr_in, csr_addr_in, rs1_in, rs2_in, pc_in, pc_plus_4_in,
    alu_opcode_in, load_size_in, load_unsigned_in, alu_src, csr_wr_en_in,
    rf_wr_en_in, wb_mux_sel_in, csr_op_in, imm_in, iadder_out_in,

    branch_taken_in, rd_addr_reg_out, csr_addr__reg_out, rs1_reg_out, rs2_reg_out, pc_reg_out, pc_plus_4_reg_out,
    alu_opcode_reg_out, load_size_reg_out, load_unsigned_reg_out, alu_src_reg_out, csr_wr_en_reg_out,
    rf_wr_en_reg_out, wb_mux_sel_reg_out, csr_op_reg_out, imm_reg_out, iadder_out_reg_out);


    //input 

    //output


    always @(posedge clk_in) begin
        
        if(reset_in) begin
            
        end

        else begin
            
        end

    end

endmodule