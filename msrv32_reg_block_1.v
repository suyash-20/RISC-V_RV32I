module msrv32_reg_block_1(
    pc_mux_in, msrv32_mp_clk_in, msrv32_mp_rst_in,
    pc_out);

    parameter WIDTH = 32;

    input [WIDTH-1:0]pc_mux_in;
    input msrv32_mp_rst_in, msrv32_mp_clk_in;
    output reg [WIDTH-1:0]pc_out;


    always@(posedge msrv32_mp_clk_in) begin
        if(msrv32_mp_rst_in) begin
            pc_out = pc_out; //DOUBT FOR WHEN RST IS ASSERTED 
        end

        else
        pc_out = pc_mux_in;
        

    end

endmodule