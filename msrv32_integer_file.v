module msrv32_integer_file(
    msrv32_mp_clk_in, msrv32_mp_rst_in, rd_addr_in, rs_2_addr_in, wr_en_in, rd_in, rs_1_addr_in, 
    rs_1_out, rs_2_out);

    parameter WIDTH = 32;
    parameter HEIGHT = 32;
    parameter ADDR_WIDTH = 5;

    input msrv32_mp_clk_in, msrv32_mp_rst_in, wr_en_in;
    input [ADDR_WIDTH-1:0]rs_2_addr_in, rd_addr_in, rs_1_addr_in;
    input [WIDTH-1:0]rd_in;

    output reg [WIDTH-1:0] rs_1_out, rs_2_out;

    reg[WIDTH-1:0]reg_file[HEIGHT-1:0];

    integer i;

    
    always@(posedge msrv32_mp_clk_in) begin
        reg_file[0]<= 32'd0;

        if(msrv32_mp_rst_in) begin
            for(i=1; i<HEIGHT; i= i+1)begin
                reg_file[i]<=32'd0;
            end
        end
        else 
            begin
            if(wr_en_in)begin  // DOUBT for what happens when wr_en_in = 0
                if(rs_1_addr_in==rd_addr_in)begin
                    rs_1_out <= rd_in;
                end
                else
                    rs_1_out <= reg_file[rs_1_addr_in];
                    //reg_file[rs_1_addr_in] <= rs_1_out;

                if(rs_2_addr_in==rd_addr_in)begin
                    rs_2_out <= rd_in;
                end
                else
                    rs_2_out <= reg_file[rs_2_addr_in];  //DOUBT FOR WHETHER it should be rs1 or rs2
                    //reg_file[rs_2_addr_in] <= rs_2_out;
            end            
      end
    end
endmodule