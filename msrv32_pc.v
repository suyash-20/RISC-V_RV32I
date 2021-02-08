//Program Counter MUX module
//combinational block

module msrv32_pc(
    rst_in, pc_src_in, pc_in, epc_in, trap_address_in, branch_taken_in, iaddr_in,
    misaligned_instr_out, pc_mux_out, pc_plus_4_out, i_addr_out);

    parameter WIDTH =32;

    input rst_in, branch_taken_in;
    input [1:0]pc_src_in;
    input [WIDTH-1:0]pc_in, epc_in, trap_address_in;
    input [30:0] iaddr_in;



    output reg misaligned_instr_out;
    output reg [WIDTH-1:0]pc_mux_out, pc_plus_4_out, i_addr_out;

    //wire definitions
    wire [WIDTH-1:0]pc_adder; //output of PC + 4
    wire [WIDTH-1:0]IADDR_OUT; //output of concatenation
    wire [WIDTH-1:0]next_pc; //wire for mux output? DOUBT

    reg BOOT_ADDRESS = 32'd13;

    always@(*) begin

        pc_plus_4_out = pc_in + 32'h0000_0004;

//        case(branch_taken_in)
//            1'b0: next_pc = pc_plus_4_out;

//            1'b1: next_pc = iaddr_out;
//        endcase

    end

    always@(*) begin

        case(pc_src_in)
            2'b00: pc_mux_out = BOOT_ADDRESS;

            2'b01: pc_mux_out = epc_in;

            2'b10: pc_mux_out = trap_address_in;

            2'b11: pc_mux_out = next_pc;
        endcase
        
        misaligned_instr_out = next_pc[1] && branch_taken_in;
        
    end

    always@(*) begin
        case(rst_in)
            1'b0: i_addr_out = pc_mux_out;
            1'b1: i_addr_out = BOOT_ADDRESS;
        endcase
    end

    assign next_pc = branch_taken_in ? IADDR_OUT : pc_plus_4_out; 
    assign IADDR_OUT = {iaddr_in,1'b0};

endmodule