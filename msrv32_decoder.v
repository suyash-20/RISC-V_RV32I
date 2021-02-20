module msrv32_decoder(
    trap_taken_in, funct7_5_in, opcode_in, funct3_in, iadder_out_1_to_0_in,
    wb_mux_sel_out, imm_type_out, csr_op_out, mem_wr_req_out, alu_opcode_out, 
    load_size_out, load_unsigned_out, alu_src_out, iadder_src_out, csr_wr_en_out, 
    rf_wr_en_out, illegal_instr_out, misaligned_load_out, misaligned_store_out);

    input trap_taken_in, funct7_5_in;
    input [6:0] opcode_in;
    input [2:0] funct3_in;
    input [1:0] iadder_out_1_to_0_in;

    output reg [2:0] wb_mux_sel_out, imm_type_out, csr_op_out;
    output reg [3:0] alu_opcode_out;
    output reg [1:0] load_size_out;

    output reg mem_wr_req_out, load_unsigned_out, alu_src_out, iadder_src_out;
    output reg csr_wr_en_out, rf_wr_en_out, illegal_instr_out, misaligned_load_out, misaligned_store_out;

    //========Micro-architecture DEMUX Logic [INTERNAL SIGNALS]
    reg [4:0] opcode__reg_sel;
    reg is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op;
    reg is_op_imm, is_load, is_store, is_system, is_misc_mem;
    reg is_csr; //NOT FROM DEMUX OUTPUTS

    //========Micro-architecture DEMUX Logic for alu_opcode_out [INTERNAL SIGNALS]
    reg is_addi_in, is_slti_in, is_sltiu_in, is_andi_in, is_ori_in, is_xori_in; //input stage signals
    
    wire is_addi, is_slti, is_sltiu, is_andi, is_ori, is_xori; //intermediate output stage signals
    wire alu_opcode_out_3; //output stage signal

    //=======IS PENDING LIST
    /*  wb_mux_sel_out
        alu_opcode_out overall logic alongwith the concatenation and micro-architecture

    */ 

    //=================================================================================



    //====================== DEMUX Logic from the micro-architecture

    assign opcode__reg_sel = opcode_in[6:2];

    always @(*) begin
        case(opcode__reg_sel)

            5'b11_000: is_branch = 1'b1;

            5'b11_011: is_jal = 1'b1;

            5'b11_001: is_jalr = 1'b1;

            5'b00_101: is_auipc = 1'b1;

            5'b01_101: is_lui = 1'b1;

            5'b01_100: is_op = 1'b1;

            5'b00_100: is_op_imm = 1'b1;

            5'b00_000: is_load = 1'b1;

            5'b01_000: is_store = 1'b1;

            5'b11_100: is_system = 1'b1;

            5'b00_011: is_misc_mem = 1'b1;

            default:  begin
                {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op} = 0;
                {is_op_imm, is_load, is_store, is_system, is_misc_mem} = 0;
            end

        endcase

    end

    //=======================================================================  IS_CSR LOGIC PENDING ======================================================================= \\

    //===============FUNCTIONAL BLOCK PENDING 


    //=================================================================================


    //============ imm_type_out AND csr_op_out Logic

    assign imm_type_out = funct3_in;  //DOUBT WITH THE MICRO-ARCHITECTURE
    assign csr_op_out = funct3_in;
    
    //=================================================================================



    //============ alu_opcode_out Logic


    //assign alu_opcode_out = {funct7_5_in, funct3_in};

    always @(*) begin
        
        case(funct3_in)

            3'b000: is_addi_in = 1'b1;
            3'b010: is_slti_in = 1'b1;
            3'b011: is_sltiu_in = 1'b1;
            3'b111: is_andi_in = 1'b1;
            3'b110: is_ori_in = 1'b1;
            3'b100: is_xori_in = 1'b1;

            default: {is_addi_in, is_slti_in, is_sltiu_in, is_andi_in, is_ori_in, is_xori_in} = 0;
        
        endcase

    end

    assign is_addi = is_addi_in & is_op_imm;
    assign is_slti = is_slti_in & is_op_imm;
    assign is_sltiu = is_sltiu_in & is_op_imm;
    assign is_andi = is_andi_in & is_op_imm;
    assign is_ori = is_ori_in & is_op_imm;
    assign is_xori = is_xori_in & is_op_imm;

    assign alu_opcode_out_3 = ~(is_addi | is_slti | is_sltiu | is_andi | is_ori | is_xori);

    assign alu_opcode_out[3] = alu_opcode_out_3 & funct7_5_in;

    //assign alu_opcode_out = {funct7_5_in, funct3_in};  DOUBT DOUBT WITH BIT ASSIGNMENT

    //=================================================================================