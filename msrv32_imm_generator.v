module msrv32_immediate_adder(input [31:0] pc_in, rs1_in, imm_in, input iadder_src_in, output [31:0] iadder_out);

reg [31:0] pc_or_rs;

	always @(*)
		begin
			if(iadder_src_in)
				pc_or_rs = rs1_in;
			else
				pc_or_rs = pc_in;		
		end

	assign  iadder_out = pc_or_rs + imm_in;

endmodule
	
