module msrv32_branch_unit(
    rs1_in, rs2_in, opcode_in, funct3_in,
    branch_taken_out);

    parameter WIDTH = 32;
    parameter MSB_VALUE = 6;
    parameter LSB_VALUE = 2;

    input [WIDTH-1:0] rs1_in, rs2_in;
    input [MSB_VALUE:LSB_VALUE]opcode_in;  //============ opcode_in OR opcode_in??????
    input [2:0]funct3_in;

    output reg branch_taken_out;

    wire signed [WIDTH-1:0] rs1_signed ,rs2_signed;

    assign rs1_signed = rs1_in;
    assign rs2_signed = rs2_in;


    always@(*)begin
        if(opcode_in==5'b11_000)begin
            case(funct3_in)

                3'b000: begin
                            if(rs1_in == rs2_in)
                                branch_taken_out = 1'b1;
                            else
                                branch_taken_out =1'b0;
                end

                3'b001: begin
                            if(rs1_in != rs2_in)
                                branch_taken_out = 1'b1;
                            else
                                branch_taken_out =1'b0;
                end

                3'b100: begin
                            if(rs1_signed < rs2_signed)  //doubt in signed representation
                                branch_taken_out = 1'b1;
                            else
                                branch_taken_out =1'b0;
                end

                3'b101: begin
                            if(rs1_signed >= rs2_signed)  //doubt unsigned
                                branch_taken_out = 1'b1;
                            else
                                branch_taken_out =1'b0;
                end

                3'b110: begin
                            if(rs1_in < rs2_in) //doubt unsigned
                                branch_taken_out = 1'b1;
                            else
                                branch_taken_out =1'b0;
                end

                3'b111: begin
                            if(rs1_in >= rs2_in)  //doubt unsigned
                                branch_taken_out = 1'b1;
                            else
                                branch_taken_out =1'b0;
                end

                default: branch_taken_out = 1'b0;
            endcase
                
        end

        else begin 
            if(opcode_in == 5'b11_011)
                branch_taken_out = 1'b1;
            else if (opcode_in == 5'b11_001) begin
                if(funct3_in == 3'b000)
                    branch_taken_out = 1'b1;
            end
            else 
                branch_taken_out = 1'b0;
        end
    end

endmodule