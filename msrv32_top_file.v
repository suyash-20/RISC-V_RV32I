module msrv32_top( ms_riscv32_mp_clk_in, ms_riscv32_mp_rst_in, ms_riscv32_mp_dmdata_in, ms_riscv32_mp_instr_in, ms_riscv32_mp_rc_in, ms_riscv32_mp_eirq_in, ms_riscv32_mp_tirq_in, ms_riscv32_mp_sirq_in,ms_riscv32_mp_dmwr_req_out,ms_riscv32_mp_imaddr_out,ms_riscv32_mp_dmaddr_out,ms_riscv32_mp_dmdata_out, ms_riscv32_mp_dmwr_mask_out);

input ms_riscv32_mp_clk_in;
input ms_riscv32_mp_rst_in;
input [31:0] ms_riscv32_mp_dmdata_in;
input [31:0] ms_riscv32_mp_instr_in;
input [63:0] ms_riscv32_mp_rc_in;
input ms_riscv32_mp_eirq_in;
input ms_riscv32_mp_tirq_in;
input ms_riscv32_mp_sirq_in;

output ms_riscv32_mp_dmwr_req_out;
output [31:0] ms_riscv32_mp_imaddr_out;
output [31:0] ms_riscv32_mp_dmaddr_out;
output [31:0] ms_riscv32_mp_dmdata_out;
output [3:0] ms_riscv32_mp_dmwr_mask_out;

//assign ms_riscv32_mp_imaddr_out = iadder_out;

/// wire from pc mux wire declaration 

    wire rst_in, branch_taken_in;
    wire [1:0]pc_src_in;
    wire [31:0]pc_in, epc_in, trap_address_in;
    wire [30:0] iaddr_in;
    wire misaligned_instr_out;
    wire [31:0]pc_mux_out, pc_plus_4_out, i_addr_out;



////  reg block 1 signal wire declaration

    wire [31:0]pc_mux_in;
//     input msrv32_mp_rst_in, msrv32_mp_clk_in;
    wire  [31:0]pc_out;



/// immediate generator signal wire declaration

    wire [2:0] imm_type_in;
    wire [31:7]instr_in;
    wire [31:0] imm_out;



//// immediate adder signal wire declaration

    //wire [31:0]pc_in;
    wire [31:0] rst1_in, imm_in;
    wire iadder_src_in;
    
    wire [31:0]iadder_out;





//// integer file signal wire declaration

    wire msrv32_mp_clk_in, msrv32_mp_rst_in;
	wire  wr_en_in;
    wire [4:0]rs_2_addr_in, rs_1_addr_in;
	wire [4:0] rd_addr_in;
    wire [31:0]rd_in;

    wire [31:0] rs_1_out, rs_2_out;



//// write enable generator signal wire declaration

wire flush_in;
wire rf_wr_en_reg_in;
wire csr_wr_en_reg_in;//csr_wr_en_reg_in
wire wr_en_int_file_out;
wire wr_en_csr_file_out;





//// instruction mux signal wire declaration

    //wire flush_in;
    //wire [31:0]msrv_riscv32_mp_instr_in;

    wire [6:0] opcode_out;
    wire [6:0] func7_out;
    wire [2:0] func3_out;
    wire [4:0]rs1_addr_out, rs2_addr_out, rd_addr_out;
    wire [11:0]csr_addr_out;
    wire [24:0]instr_out;  //31:7 ??





//// branch unit signal wire declaration

    //wire [31:0] rs1_in; 
	wire [31:0] rs2_in;
    wire [6:2]opcode_6_to_2_in;
    wire [2:0]func3_in;

    wire branch_taken_out;



//// decoder signal wire declaration

    wire trap_taken_in;
	wire funct7_5_in;
    wire [6:0] opcode_in;
//    wire [2:0] func3_in;      //should be included or not ???
    wire [1:0] iadder_out_1_to_0_in;

    wire [2:0] wb_mux_sel_out, imm_type_out, csr_op_out;  
    wire [3:0] alu_opcode_out;
    wire [1:0] load_size_out;
    wire load_unsigned_out, iadder_src_out;
    wire misaligned_load_out, misaligned_store_out;
    wire alu_src_out, rf_wr_en_out, csr_wr_en_out, mem_wr_req_out, illegal_instr_out;


//// machine control signal wire declaration

//wire ms_riscv32_mp_clk_in;
//wire ms_riscv32_mp_rst_in;
//wire ms_riscv32_mp_eirq_in;
//wire ms_riscv32_mp_tirq_in;
//wire ms_riscv32_mp_sirq_in;
wire illegal_instr_in;
wire misaligned_load_in;
wire misaligned_store_in;
wire misaligned_instr_in;
//wire [6:2] opcode_6_to_2_in;
//wire [2:0] func3_in;
wire [6:0] func7_in;
wire [4:0] rs1_addr_in;
wire [4:0] rs2_addr_in;
//wire [4:0] rd_addr_in;

wire i_or_e_out;
wire [3:0] cause_out;
wire instret_inc_out;
wire mie_clear_out;
wire mie_set_out;
wire misaligned_exception_out;
wire set_epc_out;
wire set_cause_out;
wire flush_out;
wire trap_taken_out;

wire e_irq_in,t_irq_in, s_irq_in,mie_in;
//wire rst_in;


wire meie_in;
wire mtie_in;
wire msie_in;
wire meip_in;
wire mtip_in;
wire msip_in;
wire [1:0] pc_src_out;




//// csr file signal  wire declaration

wire i_or_e_in;
wire [3:0] cause_in;
wire instret_inc_in;
wire mie_clear_in;
wire mie_set_in;
wire set_epc_in;
wire set_cause_in;
//wire ms_riscv32_mp_clk_in;
//wire ms_riscv32_mp_rst_in;
wire meie_out;
wire mtie_out;
wire msie_out;
wire meip_out;
wire mtip_out;
wire msip_out;

wire [63:0]real_time_in;


//wire ms_riscv32_mp_eirq_in;
//wire ms_riscv32_mp_sirq_in;
//wire ms_riscv32_mp_tirq_in;

wire [31:0] csr_data_out;
//wire [63:0] ms_riscv32_mp_rc_in;

wire wr_en_csr_in;
wire [11:0] csr_addr_reg_in;
wire [2:0] csr_op_reg_in;
wire [4:0] csr_uimm_in;
wire [31:0] csr_data_reg_in;
wire [31:0] pc_reg_in;
wire [31:0] iadder_reg_in;
wire [31:0] trap_address_out;
wire [31:0] epc_out;
wire  		mie_out;
		    


///  reg block 2 signal wire declaration

    //input clk_in, reset_in, branch_taken_in;
	wire load_unsigned_in, alu_src_in, csr_wr_en_in, rf_wr_en_in;
    wire [1:0] load_size_in;
    wire [2:0] wb_mux_sel_in, csr_op_in;
    wire [3:0] alu_opcode_in;
//    wire [4:0]rd_addr_in;
    wire [11:0] csr_addr_in;
    //wire [31:0] rs1_in, rs2_in, pc_in;
	wire [31:0] pc_plus_4_in, iadder_out_in;
	//wire [31:0] imm_in;

    wire load_unsigned_reg_out, alu_src_reg_out, csr_wr_en_reg_out, rf_wr_en_reg_out;  //branch_taken_in output equivalent signal ???
    wire [1:0] load_size_reg_out;
    wire [2:0] wb_mux_sel_reg_out, csr_op_reg_out;
    wire [3:0] alu_opcode_reg_out;
    wire [4:0] rd_addr_reg_out;
    wire [11:0] csr_addr_reg_out;
    wire [31:0] rs1_reg_out, rs2_reg_out, pc_reg_out, pc_plus_4_reg_out, iadder_out_reg_out, imm_reg_out;



//// store unit signal wire declaration

//wire [1:0] func3_in;
//wire [31:0] iadder_in;
//wire [31:0] rs2_in;
wire mem_wr_req_in;
//wire [31:0] ms_riscv32_mp_dmdata_out;
//wire [31:0] ms_riscv32_mp_dmaddr_out;
//wire [3:0] ms_riscv32_mp_dmwr_mask_out;
//wire ms_riscv32_mp_dmwr_req_out;

//assign func3_in = INSTRUCTION_MUX.func3_out;
//assign iadder_in = IMMEDIATE_ADDER.iadder_out;
//assign rs2_in = INTEGER_FILE.rs_2_out;




///  load unit signal declaration

//wire [31:0] ms_riscv32_mp_dmdata_in;
//wire [1:0] iadder_out_1_to_0_in;
wire load_unsigned_reg_in;
wire [1:0] load_size_reg_in;

wire [31:0] lu_output_out;




///  alu unit signal declaration

wire [31:0] op_1_in;
wire [31:0] op_2_in;
//wire [3:0] opcode_in;

wire [31:0] result_out;



//// wb mux unit wire declaration

wire alu_src_reg_in;
wire [2:0] wb_mux_sel_reg_in;
wire [31:0] alu_result_in;
wire [31:0] lu_output_in;
wire [31:0] imm_reg_in;
wire [31:0] iadder_out_reg_in;
wire [31:0] csr_data_in;
wire [31:0] pc_plus_4_reg_in;
wire [31:0] rs2_reg_in;

wire [31:0] wb_mux_out;
wire [31:0] alu_2nd_src_mux_out;




 //==============  continue from here



/// PC MUX INSTANTIATION

	msrv32_pc PC_MUX(		.rst_in(ms_riscv32_mp_rst_in), 
							.pc_src_in(pc_src_out),
							.pc_in(pc_out),
							.epc_in(epc_out), 
							.trap_address_in(trap_address_out), 
							.branch_taken_in(branch_taken_out), 
							.iaddr_in(iadder_out[31:1]), 
							.misaligned_instr_out(misaligned_instr_out), 
							.pc_mux_out(pc_mux_out), 
							.pc_plus_4_out(pc_plus_4_out), 
							.i_addr_out(i_addr_out));

/// REG BLOCK 1 INSTANTIATION

	msrv32_reg_block_1 REG_1( 	
							.msrv32_mp_clk_in(ms_riscv32_mp_clk_in),
							.msrv32_mp_rst_in(ms_riscv32_mp_rst_in), 
							.pc_mux_in(pc_mux_out), 
							.pc_out(pc_out));

/// IMMEDIATE GENERATOR INSTANTIATION

	msrv32_imm_generator IMMEDIATE_GEN(		.instr_in(instr_out), 
							.imm_type_in(imm_type_out), 
							.imm_out(imm_out));

/// IMMEDIATE ADDER INSTANTIATION

	msrv32_immediate_adder IMMEDIATE_ADDER(
							.pc_in(pc_out), 
							.rs1_in(rs_1_out), 
							.imm_in(imm_out), 
							.iadder_src_in(iaddr_src_out), 
							.iadder_out(iadder_out));

/// INTERGER FILE INSTANTIATION

	msrv32_integer_file IRF(
							.msrv32_mp_clk_in(ms_riscv32_mp_clk_in),
							.msrv32_mp_rst_in(ms_riscv32_mp_rst_in),
							.wr_en_in(wr_en_int_file_out), 
							.rs_1_addr_in(rs1_addr_out),
							.rs_2_addr_in(rs2_addr_out), 
							.rd_addr_in(rd_addr_reg_out),   //============  MADE AN ASSIGNMENT CHANGE ACCORDING TO VANDAN. 
							.rd_in(wb_mux_out), 
							.rs_1_out(rs_1_out),
							.rs_2_out(rs_2_out));

/// WRITE ENABLE GENERATOR INSTANTIATION

	msrv32_wr_en_generator WR_EN_GENERATOR(
							.flush_in(flush_out), 
							.rf_wr_en_reg_in(rf_wr_en_reg_out), 
							.csr_wr_en_reg_in(csr_wr_en_reg_out), 
							.wr_en_int_file_out(wr_en_int_file_out), 
							.wr_en_csr_file_out(wr_en_csr_file_out));

/// INSTRUCTION  INSTANTIATION

	msrv32_instruction_decoder INSTRUCTION_DEC(
							.flush_in(flush_out), 
							.ms_riscv32_mp_instr_in(ms_riscv32_mp_instr_in),
							.opcode_out(opcode_out), 
							.funct7_out(func7_out), 
							.funct3_out(func3_out), 
							.rs1_addr_out(rs1_addr_out),
							.rs2_addr_out(rs2_addr_out),
							.rd_addr_out(rd_addr_out),
							.csr_addr_out(csr_addr_out), 
							.instr_out(instr_out));

/// BRANCH UNIT INSTANTIATION

	msrv32_branch_unit BRANCH_UNIT(
							.rs1_in(rs_1_out),
							.rs2_in(rs_2_out), 
							.opcode_in(opcode_out[6:2]), 
							.funct3_in(func3_out), 
							.branch_taken_out(branch_taken_out));

/// DECODER INSTANTIATION

	msrv32_decoder DECODER(
							.trap_taken_in(trap_taken_out),
							.funct7_5_in(func7_out[5]), 
							.opcode_in(opcode_out),
							.funct3_in(func3_out), 
							.iadder_out_1_to_0_in(iadder_out[1:0]),
							.wb_mux_sel_out(wb_mux_sel_out),
							.imm_type_out(imm_type_out),
							.csr_op_out(csr_op_out),
							.mem_wr_req_out(mem_wr_req_out),
							.alu_opcode_out(alu_opcode_out),
							.load_size_out(load_size_out),
							.load_unsigned_out(load_unsigned_out),
							.alu_src_out(alu_src_out),
							.iadder_src_out(iaddr_src_out),
							.csr_wr_en_out(csr_wr_en_out),
							.rf_wr_en_out(rf_wr_en_out),
							.illegal_instr_out(illegal_instr_out),
							.misaligned_load_out(misaligned_load_out),
							.misaligned_store_out(misaligned_store_out));

/// MACHINE CONTROL INSTANTIATION

	msrv32_machine_control MACHINE_CONTROL(   
								.clk_in(ms_riscv32_mp_clk_in), 
								.reset_in(ms_riscv32_mp_rst_in),
                               // from control unit
                                 .illegal_instr_in(illegal_instr_out),
								 .misaligned_load_in(misaligned_load_out),
								 .misaligned_store_in(misaligned_store_out),
                               // from pipeline stage 1
                                 .misaligned_instr_in(misaligned_instr_out),
                               // from instruction
                                .opcode_6_to_2_in(opcode_out[6:2]),
                                .funct3_in(func3_out),
                                .funct7_in(func7_out),
                                .rs1_addr_in(rs1_addr_out),
                                .rs2_addr_in(rs2_addr_out),
                                .rd_addr_in(rd_addr_out),
                               // from interrupt controller
                                .e_irq_in(ms_riscv32_mp_eirq_in),
								.t_irq_in(ms_riscv32_mp_tirq_in), 
								.s_irq_in(ms_riscv32_mp_sirq_in),
								// from CSR file
								.mie_in(mie_out), 
								.meie_in(meie_out),
								.mtie_in(mtie_out), 
								.msie_in(msie_out), 
								.meip_in(meip_out),
								.mtip_in(mtip_out),
								.msip_in(msip_out),         
                               // to CSR file
                                .i_or_e_out(i_or_e_out), 
								.set_epc_out(set_epc_out), 
								.set_cause_out(set_cause_out),
                                .cause_out(cause_out),
                                .instret_inc_out(instret_inc_out), 
								.mie_clear_out(mie_clear_out), 
								.mie_set_out(mie_set_out),
								.misaligned_exception_out(misaligned_exception_out),
                               // to PC MUX
                                .pc_src_out(pc_src_out),
                               // to pipeline stage 2 ister
                                .flush_out(flush_out),
                               // to Control Unit
                                .trap_taken_out(trap_taken_out) );

/// CSR FILE INSTANTIATION

	msrv32_csr_file 	CSR_FILE(        
							.clk_in(ms_riscv32_mp_clk_in),
							.rst_in(ms_riscv32_mp_rst_in),
							.wr_en_in(wr_en_csr_file_out),
							.csr_addr_in(csr_addr_reg_out),
							.csr_op_in(csr_op_reg_out),
							.csr_uimm_in(imm_reg_out[4:0]),
							.csr_data_in(rs1_reg_out),
							.pc_in(pc_reg_out),
							.iadder_in(iadder_out_reg_out),
							.e_irq_in(ms_riscv32_mp_eirq_in),
							.s_irq_in(ms_riscv32_mp_sirq_in),
							.t_irq_in(ms_riscv32_mp_tirq_in),
							.i_or_e_in(i_or_e_out),
							.set_cause_in(set_cause_out),
							.set_epc_in(set_epc_out),
							.instret_inc_in(instret_inc_out),
							.mie_clear_in(mie_clear_out),
							.mie_set_in(mie_set_out),
							.cause_in(cause_out),
							.real_time_in(ms_riscv32_mp_rc_in),
							.misaligned_exception_in(misaligned_exception_out),
							.csr_data_out(csr_data_out),
							.mie_out(mie_out),
							.epc_out(epc_out),
							.trap_address_out(trap_address_out),
							.meie_out(meie_out),
							.mtie_out(mtie_out),
							.msie_out(msie_out),
							.meip_out(meip_out),
							.mtip_out(mtip_out),
							.msip_out(msip_out));
							
///  REG BLOCK 2 INSTANTIATION

	msrv32_reg_block_2 REG_BLOCK_2(	
							.clk_in(ms_riscv32_mp_clk_in), 
							.reset_in(ms_riscv32_mp_rst_in), 
							.branch_taken_in(branch_taken_out),
							.rd_addr_in(rd_addr_out), 
							.csr_addr_in(csr_addr_out),
							.rs1_in(rs_1_out),
							.rs2_in(rs_2_out),
							.pc_in(pc_mux_out),
							.pc_plus_4_in(pc_plus_4_out),
							.alu_opcode_in(alu_opcode_out),
							.load_size_in(load_size_out),
							.load_unsigned_in(load_unsigned_out), 
							.alu_src_in(alu_src_out),
							.csr_wr_en_in(csr_wr_en_out),
							.rf_wr_en_in(rf_wr_en_out),
							.wb_mux_sel_in(wb_mux_sel_out),
							.csr_op_in(csr_op_out), 
							.imm_in(imm_out),
							.iadder_out_in(iadder_out),
							.rd_addr_reg_out(rd_addr_reg_out),
							.csr_addr_reg_out(csr_addr_reg_out),
							.rs1_reg_out(rs1_reg_out),
							.rs2_reg_out(rs2_reg_out),
							.pc_reg_out(pc_reg_out),
							.pc_plus_4_reg_out(pc_plus_4_reg_out),
							.alu_opcode_reg_out(alu_opcode_reg_out), 
							.load_size_reg_out(load_size_reg_out), 
							.load_unsigned_reg_out(load_unsigned_reg_out),
							.alu_src_reg_out(alu_src_reg_out),
							.csr_wr_en_reg_out(csr_wr_en_reg_out), 
							.rf_wr_en_reg_out(rf_wr_en_reg_out), 
							.wb_mux_sel_reg_out(wb_mux_sel_reg_out), 
							.csr_op_reg_out(csr_op_reg_out), 
							.imm_reg_out(imm_reg_out),
							.iadder_out_reg_out(iadder_out_reg_out));

/// STORE UNIT INSTANTIATION

	msrv32_store_unit STORE_UNIT(
							.funct3_in(func3_out[1:0]),
							.iadder_in(iadder_out),
							.rs2_in(rs_2_out),
							.mem_wr_req_in(mem_wr_req_out),
							.ms_riscv32_mp_dmaddr_out(ms_riscv32_mp_dmaddr_out),
							.ms_riscv32_mp_dmdata_out(ms_riscv32_mp_dmdata_out),
							.ms_riscv32_mp_dmwr_req_out(ms_riscv32_mp_dmwr_req_out),
							.ms_riscv32_mp_dmwr_mask_out(ms_riscv32_mp_dmwr_mask_out)
							);

/// LOAD UNIT INSTANTIATION

	msrv32_load_unit LOAD_UNIT(
							.ms_riscv32_mp_dmdata_in(ms_riscv32_mp_dmdata_in),
							.iadder_out_1_to_0_in(iadder_out[1:0]),
							.load_unsigned_in(load_unsigned_reg_out),
							.load_size_in(load_size_reg_out),
							.lu_output_out(lu_output_out));

/// ALU INSTANTIATION

	msrv32_alu ALU(
							.op_1_in(rs1_reg_out),
							.op_2_in(alu_2nd_src_mux_out),
							.opcode_in(alu_opcode_reg_out),
							.result_out(result_out));

/// WB MUX SELECTION UNIT 

	msrv32_wb_mux_sel_unit WB_MUX_SEL_UNIT(
							.alu_src_reg_in(alu_src_reg_out),
							.wb_mux_sel_reg_in(wb_mux_sel_reg_out),
							.alu_result_in(result_out),
							.lu_output_in(lu_output_out),
							.imm_reg_in(imm_reg_out),
							.iadder_out_reg_in(iadder_out_reg_out),
							.csr_data_in(csr_data_out),
							.pc_plus_4_reg_in(pc_plus_4_reg_out),
							.rs2_reg_in(rs2_reg_out),
							.wb_mux_out(wb_mux_out),
							.alu_2nd_src_mux_out(alu_2nd_src_mux_out));

/// 

endmodule
