module msrv32_alu(
    op_1_in, op_2_in, opcode_in,
    result_out);

    parameter WIDTH = 32;

    parameter ALU_ADD = 4'b0000,
              ALU_SUB = 4'b1000,
              ALU_SLT = 4'b0010,
              ALU_SLTU = 4'b0011,
              ALU_AND = 4'b0111,
              ALU_OR = 4'b0110,
              ALU_XOR = 4'b0100,
              ALU_SLL = 4'b0001,
              ALU_SRL = 4'b0101,
              ALU_SRA = 4'b1101;


    input [WIDTH-1 : 0]op_1_in, op_2_in;
    input [3:0] opcode_in;
    output reg [WIDTH-1 : 0] result_out;
    

    always @(*) begin
        case (opcode_in)
            
            ALU_ADD: result_out = op_1_in + op_2_in;

            ALU_SUB: result_out = op_1_in - op_2_in;

            ALU_SLT: result_out = (op_1_in[31] ^ op_2_in[31]) ? ({31'd0, 1'b1}) : 32'd0; //DOUBT FOR 31st bit comparison

            ALU_SLTU: result_out = (op_1_in < op_2_in) ? ({31'd0, 1'b1}) : 32'd0;

            ALU_AND: result_out = op_1_in & op_2_in;

            ALU_OR: result_out = op_1_in | op_2_in;

            ALU_XOR: result_out = op_1_in ^ op_2_in;

            ALU_SLL: result_out = op_1_in << op_2_in[4:0];

            ALU_SRL: result_out = op_1_in >> op_2_in[4:0];

            ALU_SRA: result_out = op_1_in >>> op_2_in[4:0];
            
        endcase
    end

endmodule