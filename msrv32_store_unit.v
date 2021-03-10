module msrv32_store_unit(
    funct3_in, iadder_in, rs2_in, mem_wr_req_in,
    ms_riscv32_mp_dmdata_out, ms_riscv32_mp_dmaddr_out, ms_riscv32_mp_dmwr_mask_out, ms_riscv32_mp_dmwr_req_out
);

parameter WIDTH = 32;

input [1:0]funct3_in;
input [WIDTH-1:0]iadder_in, [WIDTH-1:0]rs2_in;
input mem_wr_req_in;

output reg [WIDTH-1:0]ms_riscv32_mp_dmdata_out, ms_riscv32_mp_dmaddr_out;
output reg [3:0]ms_riscv32_mp_dmwr_mask_out;
output reg ms_riscv32_mp_dmwr_req_out;


always @(*) begin

    case (funct3_in)

        2'b00: begin
            if(iadder_in[1:0] == 2'b00)
                ms_riscv32_mp_dmdata_out = {8'd0, 8'd0, 8'd0, rs2_in[7:0]};

            else if(iadder_in[1:0] == 2'b01)
                ms_riscv32_mp_dmdata_out = {8'd0, 8'd0, rs2_in[7:0], 8'd0};

            else if(iadder_in[1:0] == 2'b10)
                ms_riscv32_mp_dmdata_out = {8'd0, rs2_in[7:0], 8'd0, 8'd0};
            
            else if(iadder_in[1:0] == 2'b11)
                ms_riscv32_mp_dmdata_out = {rs2_in[7:0], 8'd0, 8'd0, 8'd0};
            else
                ms_riscv32_mp_dmdata_out = 32'd0;
        end

        2'b01: begin
            if(iadder_in[1]==1'b0)
                ms_riscv32_mp_dmdata_out = {16'd0,rs2_in[15:0]};
            
            else if(iadder_in[1]==1'b1)
                ms_riscv32_mp_dmdata_out = {rs2_in[15:0],16'd0};
            
            else 
                ms_riscv32_mp_dmdata_out = 32'd0;
        end
        
        
        default:  ms_risc32_mp_dmdata_out = rs1_in;
         
    endcase
    
end




0 1 2 3 
4 5 6 7 
8 9 a b 

00000000_00000000_00000000_00000000




