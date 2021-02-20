Additional Information on the decoder
 
  1]  is_system is an internal signal enabled whenever ecall and ebreak occurs.
  2]  is_csr is an internal signal that is enabled for the occurance of is_system and funct3 is 3'b000.
  3]  misaligned_load and misaligned_store are enabled whenever an misaligned_word or misaligned_half occurs in tandem with 
      load or store operation.
      Note: Check Load & Store instruction along with Funct3
  
  4]  alu_opcode is driven to the ALU so as to select the specific operation to be done.
      a) alu_opcode[2:0] is assigned by the funct3 value.
      b) alu_opcode[3] is high for every occurrence of funct7[5] in R type instructions and for 'Shift Right Arith Imm'     instruction in I type.
  5]  alu_src is a select line driven to selecting between rs2 and imm value as the operand 2 to the alu (Check R-Type & I Type ALU instruction).
  6]  iadder_src is a select line driven to the immediate adder to select between [rs1+imm] and [PC+imm].
  7] load_size is a signal to specify the size of data to be loaded in the load unit.
  8] load_unsigned is a signal driven to the load unit so as to indicate if the data is unsigned or not.
  9] mem_wr_req_out is asserted for store instruction when there is no misalignment & no Interrupt occurred