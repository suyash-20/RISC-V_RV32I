module msrv32_integer_file(
    msrv32_mp_clk_in, msrv32_mp_rst_in, rd_addr_in, rs_2_addr_in, wr_en_in, rd_in, rs_1_addr_in, 
    rs_1_out, rs_2_out);

    parameter WIDTH = 32;
    parameter DEPTH = 32;
    parameter ADDR_WIDTH = 5;

    input msrv32_mp_clk_in, msrv32_mp_rst_in, wr_en_in;
    input [ADDR_WIDTH-1:0]rs_2_addr_in, rd_addr_in, rs_1_addr_in;
    input [WIDTH-1:0]rd_in;

    output [WIDTH-1:0] rs_1_out, rs_2_out; //Assign statement, hence wire type output signals

    reg[WIDTH-1:0]reg_file[0:DEPTH-1];
    integer i;

    
    always@(posedge msrv32_mp_clk_in, posedge msrv32_mp_rst_in) begin
        reg_file[0]<= 32'd0;

        if(msrv32_mp_rst_in) begin
            for(i=1; i<DEPTH; i= i+1)begin
                reg_file[i]<=32'd0;
            end
        end
        else if(wr_en_in && (rd_addr_in != 0))begin
            reg_file[rd_addr_in] <= rd_in;
        end         
    end

    assign rs_1_out = (wr_en_in && (rs_1_addr_in==rd_addr_in)) ? rd_in: reg_file[rs_1_addr_in];
    assign rs_2_out = (wr_en_in && (rs_2_addr_in==rd_addr_in)) ? rd_in: reg_file[rs_2_addr_in];

endmodule