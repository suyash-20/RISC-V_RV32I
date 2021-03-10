module msrv32_decoder(
    trap_taken_in, funct7_5_in, opcode_in, funct3_in, iadder_out_1_to_0_in,
    wb_mux_sel_out, imm_type_out, csr_op_out, mem_wr_req_out, alu_opcode_out, 
    load_size_out, load_unsigned_out, alu_src_out, iadder_src_out, csr_wr_en_out, 
    rf_wr_en_out, illegal_instr_out, misaligned_load_out, misaligned_store_out);

    input trap_taken_in, funct7_5_in;
    input [6:0] opcode_in;
    input [2:0] funct3_in;
    input [1:0] iadder_out_1_to_0_in;

    output [2:0] wb_mux_sel_out, imm_type_out, csr_op_out;  //assign statement, hence wire type output signals
    output reg [3:0] alu_opcode_out;
    output reg [1:0] load_size_out;

    output reg mem_wr_req_out, load_unsigned_out, alu_src_out, iadder_src_out;
    output reg csr_wr_en_out, rf_wr_en_out, misaligned_load_out, misaligned_store_out;
    output illegal_instr_out;
    //========Micro-architecture DEMUX Logic [INTERNAL SIGNALS]
    reg [4:0] opcode__reg_sel;
    reg is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op;
    reg is_op_imm, is_load, is_store, is_system, is_misc_mem;
    reg is_csr; //NOT FROM DEMUX OUTPUTS


    wire is_implemented_instr;

    //========Micro-architecture DEMUX Logic for alu_opcode_out [INTERNAL SIGNALS]
    reg is_addi_in, is_slti_in, is_sltiu_in, is_andi_in, is_ori_in, is_xori_in; //input stage signals
    
    wire is_addi, is_slti, is_sltiu, is_andi, is_ori, is_xori; //intermediate output stage signals
    //wire alu_opcode_out_3; //output stage signal

    //=======IS PENDING LIST
    /*  wb_mux_sel_out
        alu_opcode_out overall logic alongwith the concatenation and micro-architecture

    */ 

    assign alu_src_out = (opcode_in[5]) ? is_op : is_op_imm;

    //=================================================================================



    //====================== DEMUX Logic from the micro-architecture

    assign opcode__reg_sel = opcode_in[6:2];

    always @(*) begin
        case(opcode__reg_sel)

            5'b11_000: begin
                        is_branch = 1'b1;
                        {is_jal, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_load, is_store, is_system, is_misc_mem} = 0;

            end

            5'b11_011: begin
                        is_jal = 1'b1;
                        {is_branch, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_load, is_store, is_system, is_misc_mem} = 0;

            end
            5'b11_001: begin
                        is_jalr = 1'b1;
                        {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_load, is_store, is_system, is_misc_mem} = 0;

            end

            5'b00_101: begin 
                        is_auipc = 1'b1;
                        {is_branch, is_jal, is_jalr, is_lui, is_op, is_op_imm, is_load, is_store, is_system, is_misc_mem} = 0;

            end

            5'b01_101: begin 
                        is_lui = 1'b1;
                        {is_branch, is_jal, is_jalr, is_auipc, is_op, is_op_imm, is_load, is_store, is_system, is_misc_mem} = 0;
            end

            5'b01_100: begin 
                        is_op = 1'b1;
                        {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op_imm, is_load, is_store, is_system, is_misc_mem} = 0;
            end

            5'b00_100: begin 
                        is_op_imm = 1'b1;
                        {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op, is_load, is_store, is_system, is_misc_mem} = 0;
            end

            5'b00_000: begin 
                        is_load = 1'b1;
                        {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_store, is_system, is_misc_mem} = 0;
            end

            5'b01_000: begin 
                        is_store = 1'b1;
                        {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_load, is_system, is_misc_mem} = 0;
            end

            5'b11_100: begin 
                        is_system = 1'b1;
                        {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_load, is_store, is_misc_mem} = 0;
            end
            
            5'b00_011: begin 
                        is_misc_mem = 1'b1;
                        {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op, is_op_imm, is_load, is_store, is_system} = 0;
            end

            default:  begin
                        {is_branch, is_jal, is_jalr, is_auipc, is_lui, is_op} = 0;
                        {is_op_imm, is_load, is_store, is_system, is_misc_mem} = 0;
            end

        endcase

    end


    //load_size_out load_unsigned_out Logic

    always @(*) begin

        if(opcode_in == 000_0011)begin
            case(funct3_in)

                3'b000: begin
                    load_size_out = funct3_in[1:0];
                    load_unsigned_out = funct3_in[2];

                    misaligned_load_out = 0;
                end

                3'b001: begin
                    load_size_out = funct3_in[1:0];
                    load_unsigned_out = funct3_in[2];

                    if(iadder_out_1_to_0_in[0] == 0)
                        misaligned_load_out = 0;
                    else
                        misaligned_load_out = 1;
                end

                3'b010: begin
                    load_size_out = funct3_in[1:0];
                    load_unsigned_out = funct3_in[2];

                    if(iadder_out_1_to_0_in[1:0]==2'b00)
                        misaligned_load_out = 0;
                    else
                        misaligned_load_out = 1;
                end

                3'b100: begin
                    load_size_out = funct3_in[1:0];
                    load_unsigned_out = funct3_in[2];

                    misaligned_load_out = 0;
                end

                3'b101: begin
                    load_size_out = funct3_in[1:0];
                    load_unsigned_out = funct3_in[2];

                    if(iadder_out_1_to_0_in[0] == 0)
                        misaligned_load_out = 0;
                    else
                        misaligned_load_out = 1;
                end

            endcase
        end
        
    end


    always @(*) begin

        if(opcode_in == 010_0011)begin
            case(funct3_in)

                3'b000: begin
                    misaligned_store_out = 0;
                end

                3'b001: begin
                    if(iadder_out_1_to_0_in[0]==0)
                        misaligned_store_out = 0;
                    else
                        misaligned_store_out = 1;
                end

                3'b010: begin
                    if(iadder_out_1_to_0_in[1:0]==2'b00)
                        misaligned_store_out = 0;
                    else
                        misaligned_store_out = 1;
                end
            endcase
        end
        
    end


    //=======================================================================  IS_CSR LOGIC ======================================================================= \\

    assign is_csr = is_system & (~(funct3_in[0] | funct3_in[1] | funct3_in[2]));


    //=============================================FUNCTIONAL BLOCK PENDING 


    //=============== WB_MUX_SEL_OUT Logic
/*
    WB_MUX_SEL_OUT       |    
____________________________________________________________________________________________________________________________________________
    000  WB_MUX/ALU      |  {is_op, is_op_imm}
    
    001  WB_LU           |  {[ LSB => is_load, is_op, is_op_imm, is_lui, is_auipc]}
    
    010  WB_IMM(imm)  |  {[ [1] => is_op_imm, is_store, is_jalr, is_load]}
    
    011  WB_IADER_OUT(pc/rs+ imm) |  {[ [1] => is_op_imm, is_branch, is_jal, is_jalr, is_auipc]} { [LSB => is_op_imm, is_branch, is_jal, is_jalr, is_auipc]}
    
    100  WB_CSR          |  { [MSB => is_csr]} 
    
    101  WB_PC_PLUS      |  { [MSB => is_branch, is_jal, is_jalr, is_auipc, is_lui, is_csr]} { [LSB => is_branch, is_jal, is_jalr, is_auipc, is_lui, is_csr ]}


*/

    assign wb_mux_sel_out[2] =  (is_jal | is_jalr | is_auipc | is_lui | is_csr | is_branch) ? 1 : 0;
    assign wb_mux_sel_out[1] = (is_load | is_store | is_branch | is_jal | is_jalr | is_auipc | is_op_imm) ? 1: 0;
    assign wb_mux_sel_out[0] = (is_jal | is_jalr | is_lui | is_csr | is_branch | is_lui | is_auipc | is_load) ? 1 : 0;

//    imm_type_out Logic

    assign imm_type_out[0] = (is_op_imm | is_branch | is_jal | is_jalr);
    assign imm_type_out[1] = (is_store | is_branch | is_csr | is_op_imm | is_jalr);
    assign imm_type_out[2] = (is_lui | is_auipc | is_jal | is_csr | is_op_imm | is_jalr);


//    rf_wr_en_out Logic

    assign rf_wr_en_out = (is_op | is_op_imm | is_load | is_jal | is_jalr | is_lui | is_auipc);

    //=================================================================================


    //============ csr_op_out Logic

    assign csr_op_out = funct3_in;

    //============ csr_wr_en_out Logic

    assign csr_wr_en_out = is_csr;
    
    //=================================================================================

    //is_implemented_instr Logic
    
    assign is_implemented_instr = (is_branch | is_jal | is_jalr | is_auipc | is_lui | is_op | is_op_imm | is_load | is_store | is_system | is_misc_mem);

    //====================== illegal_instr_out Logic 

    assign illegal_instr_out =  (~(is_implemented_instr) | ~(opcode_in[1]) | ~(opcode_in[0]));

    //=================================================================================


    //============ alu_opcode_out Logic

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

    //assign alu_opcode_out_3 = ~(is_addi | is_slti | is_sltiu | is_andi | is_ori | is_xori);

    assign alu_opcode_out[3] = ~(is_addi | is_slti | is_sltiu | is_andi | is_ori | is_xori) & funct7_5_in;
    assign alu_opcode_out[2:0] = funct3_in;
    
    //=================================================================================

    
    
    //====================== mem_wr_req_out Logic

    assign mem_wr_req_out = (((funct3_in[1:0] == 2'b01 && iadder_out_1_to_0_in[0] == 1'b0) || 
      (funct3_in[1:0] == 2'b10 && iadder_out_1_to_0_in[1:0] == 2'b00)) 
      && (trap_taken_in == 1'b0)) ? 1'b1 : 1'b0;


endmodule