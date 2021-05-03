module msrv32_load_unit(ms_riscv32_mp_dmdata_in,iadder_out_1_to_0_in,load_unsigned_in,load_size_in,lu_output_out);

input [31:0] ms_riscv32_mp_dmdata_in;
input [1:0] iadder_out_1_to_0_in;
input load_unsigned_in;
input [1:0] load_size_in;
output reg [31:0] lu_output_out;

always@(*)
begin
	case(load_size_in)
	2'b00	:	begin
					case(iadder_out_1_to_0_in)
					2'b00	:	if(load_unsigned_in)
									lu_output_out = {8'd0,8'd0,8'd0,ms_riscv32_mp_dmdata_in[7:0]};
								else
									lu_output_out = {{24{ms_riscv32_mp_dmdata_in[7]}},ms_riscv32_mp_dmdata_in[7:0]};
									
					2'b01	:	if(load_unsigned_in)
									lu_output_out = {8'd0,8'd0,ms_riscv32_mp_dmdata_in[7:0],8'd0};
								else
									lu_output_out = {{16{ms_riscv32_mp_dmdata_in[7]}},ms_riscv32_mp_dmdata_in[7:0],8'd0};
									
					2'b10	:	if(load_unsigned_in)
									lu_output_out = {8'd0,ms_riscv32_mp_dmdata_in[7:0],8'd0,8'd0};
								else
									lu_output_out = {{8{ms_riscv32_mp_dmdata_in[7]}},ms_riscv32_mp_dmdata_in[7:0],16'd0};
					
					2'b11	:	if(load_unsigned_in)
									lu_output_out = {ms_riscv32_mp_dmdata_in[7:0],24'd0};
								else
									lu_output_out = {ms_riscv32_mp_dmdata_in[7:0],24'd0};
					endcase
				end
	
	2'b01	:	begin
					case(iadder_out_1_to_0_in[1])
					1'b0	:	if(load_unsigned_in)
									lu_output_out = {16'd0,ms_riscv32_mp_dmdata_in[15:0]};
								else
									lu_output_out = {{16{ms_riscv32_mp_dmdata_in[15]}},ms_riscv32_mp_dmdata_in[15:0]};
					
					1'b1	:	if(load_unsigned_in)
									lu_output_out = {ms_riscv32_mp_dmdata_in[15:0],16'd0};
								else
									lu_output_out =	{ms_riscv32_mp_dmdata_in[15:0],16'd0};
					endcase
				end
	
	2'b10,2'b11	:	begin
						lu_output_out = ms_riscv32_mp_dmdata_in;
					end
	endcase
end

endmodule

