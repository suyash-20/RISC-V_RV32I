module msrv32_store_unit(
    funct3_in, iadder_in, rs2_in, mem_wr_req_in,
    ms_riscv32_mp_dmdata_out, ms_riscv32_mp_dmaddr_out, ms_riscv32_mp_dmwr_mask_out, ms_riscv32_mp_dmwr_req_out);

    parameter WIDTH = 32;

    input [1:0]funct3_in;
    input [WIDTH-1:0]iadder_in, rs2_in;
    input mem_wr_req_in;

    output reg [WIDTH-1:0] ms_riscv32_mp_dmdata_out;
    output [WIDTH-1:0] ms_riscv32_mp_dmaddr_out;
    output reg [3:0]ms_riscv32_mp_dmwr_mask_out;
    output ms_riscv32_mp_dmwr_req_out;

    assign ms_riscv32_mp_dmaddr_out = {iadder_in[31:2],2'b0};
    assign ms_riscv32_mp_dmwr_req_out = mem_wr_req_in;

    always @(*) begin

        case (funct3_in)

            2'b00: begin
                if(iadder_in[1:0] == 2'b00) begin
                    ms_riscv32_mp_dmdata_out = {8'd0, 8'd0, 8'd0, rs2_in[7:0]};
                    ms_riscv32_mp_dmwr_mask_out = {3'b000, 1'b1};
                end
                    

                else if(iadder_in[1:0] == 2'b01) begin
                    ms_riscv32_mp_dmdata_out = {8'd0, 8'd0, rs2_in[7:0], 8'd0};
                    ms_riscv32_mp_dmwr_mask_out = {2'b00, 1'b1, 1'b0};
                end

                else if(iadder_in[1:0] == 2'b10) begin
                    ms_riscv32_mp_dmdata_out = {8'd0, rs2_in[7:0], 8'd0, 8'd0};
                    ms_riscv32_mp_dmwr_mask_out = {1'b0, 1'b1, 2'b00};
                end
                    
                
                else if(iadder_in[1:0] == 2'b11) begin
                    ms_riscv32_mp_dmdata_out = {rs2_in[7:0], 8'd0, 8'd0, 8'd0};
                    ms_riscv32_mp_dmwr_mask_out = {1'b1, 3'b000};
                end
                    
                else begin
                    ms_riscv32_mp_dmdata_out = 32'd0;
                    ms_riscv32_mp_dmwr_mask_out = 4'b0000;
                end
            end

            2'b01: begin
                if(iadder_in[1]==1'b0) begin
                    ms_riscv32_mp_dmdata_out = {16'd0,rs2_in[15:0]};
                    ms_riscv32_mp_dmwr_mask_out = {2'b00, 2'b11};
                end
                    
                else if(iadder_in[1]==1'b1) begin
                    ms_riscv32_mp_dmdata_out = {rs2_in[15:0],16'd0};
                    ms_riscv32_mp_dmwr_mask_out = {2'b11, 2'b00};
                end
                    
                else begin
                    ms_riscv32_mp_dmdata_out = 32'd0;
                    ms_riscv32_mp_dmwr_mask_out = 4'b0000;
                end
                    
            end
            
            
            default:  ms_riscv32_mp_dmdata_out = rs2_in;
            
        endcase
        
    end

endmodule