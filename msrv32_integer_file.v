module msrv32_integer_file(input ms_riscv32_mp_clk_in,ms_riscv32_mp_rst_in,wr_en_in,  input [4:0] rs_1_addr_in,rs_2_addr_in, rd_addr_in, input [31:0] rd_in, output [31:0] rs_1_out,rs_2_out);

reg [31:0] reg_file [31:0];
integer i;

assign rs_1_out = ((rs_1_addr_in == rd_addr_in) && wr_en_in) ? rd_in : reg_file[rs_1_addr_in];

assign rs_2_out = ((rs_2_addr_in == rd_addr_in) && wr_en_in) ? rd_in : reg_file[rs_2_addr_in];

always@(posedge ms_riscv32_mp_clk_in)
	begin
		if(ms_riscv32_mp_rst_in)
		begin
			for(i=0; i<32; i=i+1)
			begin
					reg_file[i] <= 0;
			end
		end
		else if(wr_en_in && (rd_addr_in != 0))
			reg_file[rd_addr_in] <= rd_in;
		
	end

endmodule
