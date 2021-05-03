module msrv32_store_unit(func3_in,iaddr_in,rs2_in,mem_wr_req_in,ms_riscv32_mp_dmaddr_out,ms_riscv32_mp_dmdata_out,ms_riscv32_mp_dmwr_req_out,ms_riscv32_mp_dmwr_mask_out);

input [1:0] func3_in;
input [31:0] iaddr_in;
input [31:0] rs2_in;
input mem_wr_req_in;

output reg [31:0] ms_riscv32_mp_dmdata_out;
output [31:0] ms_riscv32_mp_dmaddr_out;
output reg [3:0] ms_riscv32_mp_dmwr_mask_out;
output ms_riscv32_mp_dmwr_req_out;

always@(*)
begin
	case(func3_in)
	2'b00	:	begin
					case(iaddr_in[1:0])
					2'b00	:	begin
								ms_riscv32_mp_dmdata_out = {8'd0,8'd0,8'd0,rs2_in[7:0]};
								ms_riscv32_mp_dmwr_mask_out = {1'b0,1'b0,1'b0,mem_wr_req_in};
								end								
					2'b01	:	begin
								ms_riscv32_mp_dmdata_out = {8'd0,8'd0,rs2_in[7:0],8'd0};
								ms_riscv32_mp_dmwr_mask_out = {1'b0,1'b0,mem_wr_req_in,1'b0};
								end
					2'b10	:	begin
								ms_riscv32_mp_dmdata_out = {8'd0,rs2_in[7:0],8'd0,8'd0};
								ms_riscv32_mp_dmwr_mask_out = {1'b0,mem_wr_req_in,1'b0,1'b0};
								end
					2'b11	:	begin
								ms_riscv32_mp_dmdata_out = {rs2_in[7:0],8'd0,8'd0,8'd0};
								ms_riscv32_mp_dmwr_mask_out = {mem_wr_req_in,1'b0,1'b0,1'b0};
								end
					endcase
				end	
	2'b01	:	begin
					case(iaddr_in[1])
					1'b0	:	begin
								ms_riscv32_mp_dmdata_out = {16'd0,rs2_in[15:0]};
								ms_riscv32_mp_dmwr_mask_out = {2'd0,{2{mem_wr_req_in}}};
								end
					1'b1 	:	begin
								ms_riscv32_mp_dmdata_out = {rs2_in[15:0],16'd0};
								ms_riscv32_mp_dmwr_mask_out = {{2{mem_wr_req_in}},2'd0};
								end
					endcase
				end
	2'b10	:	begin
					ms_riscv32_mp_dmdata_out = rs2_in;
					ms_riscv32_mp_dmwr_mask_out = {4{mem_wr_req_in}};
				end
	endcase
end


assign ms_riscv32_mp_dmwr_req_out = mem_wr_req_in;

assign ms_riscv32_mp_dmaddr_out = {iaddr_in[31:2],2'b0};


endmodule
