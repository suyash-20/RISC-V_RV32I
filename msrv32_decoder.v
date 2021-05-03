module msrv32_decoder(trap_taken_in, func7_5_in, opcode_in,func3_in, iadder_out_1_to_0_in,wb_mux_sel_out,imm_type_out,csr_op_out,mem_wr_req_out,alu_opcode_out,load_size_out,load_unsigned_out,alu_src_out,iaddr_src_out,csr_wr_en_out,rf_wr_en_out,illegal_instr_out,misaligned_load_out,misaligned_store_out);

input trap_taken_in;
input func7_5_in;
input [6:0] opcode_in;
input [2:0] func3_in;
input [1:0] iadder_out_1_to_0_in;

output [2:0] wb_mux_sel_out; // pending
output reg [2:0] imm_type_out;
output [2:0] csr_op_out;
output mem_wr_req_out;
output [3:0] alu_opcode_out;
output [1:0] load_size_out;
output load_unsigned_out;
output alu_src_out; 
output iaddr_src_out; 
output csr_wr_en_out; 
output rf_wr_en_out;
output illegal_instr_out;
output misaligned_load_out;
output  misaligned_store_out;

reg is_branch ,is_jal,is_jalr,is_auipc,is_lui,is_op,is_op_imm,is_load,is_store,is_system,is_misc_mem;

wire is_csr;

wire is_addi, is_slti, is_sltiu, is_andi, is_ori, is_xori;

wire is_implemented_instr; 

wire misalignment, mal_word,mal_half_word;
	/*is_branch 	= 5'b11000,
	is_jal		= 5'b11011,
	is_jalr		= 5'b11001,
	is_auipc	= 5'b00101,
	is_lui		= 5'b01101,
	is_op		= 5'b01100,
	is_op_imm	= 5'b00100,
	is_load		= 5'b00000,
	is_store	= 5'b01000,
	is_system	= 5'b11100,
	is_misc_mem	= 5'b00011;*/

always@(*)
begin
	case(opcode_in[6:2])
		5'b11000	:	begin
							is_branch=1;
							{is_jal,is_jalr,is_auipc,is_lui,is_op,is_op_imm,is_load,is_store,is_system,is_misc_mem}=0;
						end
		5'b11011	: 	begin
							is_jal=1;
							{is_branch,is_jalr,is_auipc,is_lui,is_op,is_op_imm,is_load,is_store,is_system,is_misc_mem}=0;
						end
		5'b11001	: 	begin
							is_jalr=1;
							{is_branch ,is_jal,is_auipc,is_lui,is_op,is_op_imm,is_load,is_store,is_system,is_misc_mem}=0;
						end
		5'b00101	: 	begin
							is_auipc=1;
							{is_branch ,is_jal,is_jalr,is_lui,is_op,is_op_imm,is_load,is_store,is_system,is_misc_mem}=0;	
						end
		5'b01101	: 	begin	
							is_lui=1;
							{is_branch ,is_jal,is_jalr,is_auipc,is_op,is_op_imm,is_load,is_store,is_system,is_misc_mem}=0;	
						end
		5'b01100	: 	begin
							is_op=1;
							{is_branch ,is_jal,is_jalr,is_auipc,is_lui,is_op_imm,is_load,is_store,is_system,is_misc_mem}=0;	
						end
		5'b00100	: 	begin
							is_op_imm=1;
							{is_branch ,is_jal,is_jalr,is_auipc,is_lui,is_op,is_load,is_store,is_system,is_misc_mem}=0;
						end
		5'b00000	: 	begin
							is_load=1;
							{is_branch ,is_jal,is_jalr,is_auipc,is_lui,is_op,is_op_imm,is_store,is_system,is_misc_mem}=0;
						end
		5'b01000	: 	begin
							is_store=1;
							{is_branch ,is_jal,is_jalr,is_auipc,is_lui,is_op,is_op_imm,is_load,is_system,is_misc_mem}=0;
						end
		5'b11100	: 	begin
							is_system=1;
							{is_branch ,is_jal,is_jalr,is_auipc,is_lui,is_op,is_op_imm,is_load,is_store,is_misc_mem}=0;		
						end
		5'b00011	: 	begin
							is_misc_mem=1;
							{is_branch ,is_jal,is_jalr,is_auipc,is_lui,is_op,is_op_imm,is_load,is_store,is_system}=0;
						end
		endcase	
end
	
assign is_addi  = (is_op_imm & (func3_in == 3'b000));// ? 1:0;	
assign is_slti  = (is_op_imm & (func3_in == 3'b010));// ? 1:0;	
assign is_sltiu = (is_op_imm & (func3_in == 3'b011));// ? 1:0;	
assign is_andi  = (is_op_imm & (func3_in == 3'b111));// ? 1:0;	
assign is_ori   = (is_op_imm & (func3_in == 3'b110));// ? 1:0;	
assign is_xori  = (is_op_imm & (func3_in == 3'b100));// ? 1:0;	


assign  alu_opcode_out[3] = (func7_5_in & !(is_addi | is_slti | is_sltiu | is_andi | is_ori | is_xori));

assign alu_opcode_out[2:0] = func3_in[2:0];
 
assign csr_op_out = func3_in;

assign is_implemented_instr = (is_branch | is_jal | is_jalr | is_auipc | is_lui | is_op | is_op_imm | is_load | is_store | is_system | is_misc_mem);

assign illegal_instr_out = (!is_implemented_instr) | (!opcode_in[1]) | (!opcode_in[0]);

assign csr_wr_en_out = is_csr;

assign rf_wr_en_out = (is_op | is_op_imm | is_load | is_jal | is_jalr | is_lui | is_auipc);

//misalignment of load and store 
assign mal_word = func3_in[1] & ~func3_in[0] & (iadder_out_1_to_0_in[1]|iadder_out_1_to_0_in[0]);
assign mal_half_word = func3_in[0] & ~func3_in[1] & (iadder_out_1_to_0_in[0]);
assign misaligned = mal_word | mal_half_word;
assign misaligned_store_out= misaligned & is_store;
assign misaligned_load_out= misaligned & is_load;

assign load_size_out =func3_in [1:0];  // load_size_out is the same as last 2bits of func3_in

assign load_unsigned_out = func3_in[2]; // load_unsigned_out is the same as the last bit of func3_in

assign alu_src_out = (opcode_in[5]);

/*IMM type out logic
3'b000 R_TYPE
3'b001 I_TYPE
3'b010 S_TYPE
3'b011 B_TYPE
3'b100 U_TYPE
3'b101 J_TYPE
3'b110 CSR_TYPE
3'b111 I_TYPE*/
always@(*)
begin
	case(opcode_in[6:2])
	5'b01100	:	imm_type_out = 3'b000; // reg
	5'b00100	:	imm_type_out = 3'b001; // immediate 
	5'b00000	:	imm_type_out = 3'b111; // immediate
	5'b01000	:	imm_type_out = 3'b010; // store type
	5'b11000	:	imm_type_out = 3'b011; // branch type
	5'b01101, 5'b00101 	:	imm_type_out = 3'b100; // u type
	5'b11011	:	imm_type_out = 3'b101; // jump
	5'b11001	:	imm_type_out = 3'b111; // I type
	5'b11100	:	imm_type_out = 3'b111; // i type
	endcase
end	

assign mem_wr_req_out = is_store;

assign is_csr = !(func3_in[0] | func3_in[1] | func3_in[2]) & is_system;


assign iaddr_src_out= is_load| is_store| is_jalr ;

/*wb_mux_sel_reg_in Values 				description
	000						WB_MUX
	001						WB_LU
	010						WB_IMM
	011						WB_IADDER_OUT
	100						WB_CSR
	101						WB_PC_PLUS*/

assign wb_mux_sel_out [0] = is_jalr|is_jal | is_auipc | is_load ; //CHANGED BY VIJJU

assign wb_mux_sel_out [1] = is_lui | is_auipc; //CHANGED BY VIJJU

assign wb_mux_sel_out [2] = is_csr | is_jal|is_jalr ; //CHANGED BY VIJJU


endmodule

