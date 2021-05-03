module msrv32_reg_block_1(input ms_riscv32_mp_clk_in,ms_riscv32_mp_rst_in, input [31:0] pc_mux_in, output reg [31:0] pc_out);


always@(posedge ms_riscv32_mp_clk_in or posedge ms_riscv32_mp_rst_in)
begin
	if(ms_riscv32_mp_rst_in)
		pc_out <= 0;
	else
		pc_out <= pc_mux_in;
end

endmodule
