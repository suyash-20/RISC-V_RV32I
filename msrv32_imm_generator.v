module msrv32_imm_generator(
    instr_in, imm_type_in, 
    imm_out);

    parameter MSB_VALUE = 31;
    parameter LSB_VALUE = 7;  
    parameter WIDTH = 32;

    input [2:0] imm_type_in;
    input [MSB_VALUE:LSB_VALUE]instr_in;
    output reg [WIDTH-1:0] imm_out;



    always@(*)begin
        
        case(imm_type_in)

            3'b000: imm_out = {{20{instr_in[31]}},instr_in[31:20]}; // I TYPE

            3'b001: imm_out = {{20{instr_in[31]}},instr_in[31:20]}; // I TYPE
            
            3'b010: imm_out = {{20{instr_in[31]}},instr_in[31:25], 
                                instr_in[11:7]}; // S TYPE
            
            3'b011: imm_out = {{20{instr_in[31]}},instr_in[7], 
                                instr_in[30:25], instr_in[11:8], 1'b0}; //B TYPE
            
            3'b100: imm_out = {instr_in[31:12],12'h000}; //U TYPE
            
            3'b101: imm_out = {{12{instr_in[31]}},instr_in[19:12],
                                instr_in[20], instr_in[30:21],1'b0}; //J TYPE
            
            3'b110: imm_out = {27'b0, instr_in[19:15]};// CSR TYPE
            
            3'b111: imm_out = {{20{instr_in[31]}},instr_in[31:20]}; //I TYPE
        
        endcase

    end
                            
endmodule