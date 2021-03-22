module msrv32_immediate_adder(
    pc_in, rs1_in, iadder_src_in, imm_in,
    iadder_out);

    parameter WIDTH = 32;

    input [WIDTH-1:0]pc_in, rs1_in, imm_in;
    input iadder_src_in;
    
    output[WIDTH-1:0]iadder_out;
    wire [WIDTH-1:0] iadder_reg;
    
    assign iadder_reg = iadder_src_in ? rs1_in : pc_in;

    assign iadder_out = iadder_reg + imm_in;

endmodule

