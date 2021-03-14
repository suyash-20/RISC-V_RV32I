module msrv32_load_unit(
    ms_riscv32_mp_dmdata_in, iadder_out_1_to_0_in, load_unsigned_in, load_size_in,
    lu_output_out
);

parameter WIDTH = 32;

input load_unsigned_in;
input [1:0] load_size_in, iadder_out_1_to_0_in;
input [WIDTH-1 : 0] ms_riscv32_mp_dmdata_in;

output reg [WIDTH-1 : 0]lu_output_out;


always@(*)begin
    case (load_size_in)

    //=============LOAD_UNSIGNED_IN LOGIC STILL PENDING
        
        2'b00: begin
            if(iadder_out_1_to_0_in == 2'b00)
                lu_output_out = {8'd0, 8'd0, 8'd0, ms_riscv32_mp_dmdata_in[7:0]};
            
            else if(iadder_out_1_to_0_in == 2'b01)
                lu_output_out = {8'd0, 8'd0, ms_riscv32_mp_dmdata_in[7:0], 8'd0};
            
            else if(iadder_out_1_to_0_in == 2'b10)
                lu_output_out = {8'd0, ms_riscv32_mp_dmdata_in[7:0], 8'd0, 8'd0};
            
            else if(iadder_out_1_to_0_in == 2'b11)
                lu_output_out = {ms_riscv32_mp_dmdata_in[7:0], 8'd0, 8'd0, 8'd0};
            
            else
                lu_output_out = 32'd0;

        end 

        2'b01: begin
            if(iadder_out_1_to_0_in[0] == 1'b0)
                lu_output_out = {16'd0, ms_riscv32_mp_dmdata_in[15:0]};
            
            else if(iadder_out_1_to_0_in[0] == 1'b1)
                lu_output_out = {ms_riscv32_mp_dmdata_in[15:0], 16'd0};
            
            else
                lu_output_out = 32'd0;
        end

        2'b10: begin
            
            lu_output_out = ms_riscv32_mp_dmdata_in;
            
        end

        /* 2'b11: begin
            
        end */

        default: lu_output_out = ms_riscv32_mp_dmdata_in;

    endcase
    
end

endmodule