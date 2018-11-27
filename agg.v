
// *********************************************************************************
// Project Name : CSEE 4823 Project: Neural Network Accelerator
// File Name    : agg.v
// *********************************************************************************
// Modification History:
// Date         By              Version                 Change Description
// -----------------------------------------------------------------------
// 11/21/2018 Shixin Qin      1.0                     Basic function design
// 
// *********************************************************************************

module agg (clk, rst, agg_in, agg_out2alu, agg_out2act, agg_out_acted, agg_out);
    parameter n = 12;
    input               clk, rst;
    input wire [n-1:0] 		agg_in ;
    output [n-1:0]      agg_out ;
    output reg			agg_out2alu, agg_out2act;
    output 				agg_out_acted; 
	wire 				clk, rst;
	wire					agg;
	assign agg_lsb = agg_in[0];

    always @(posedge clk, posedge rst)
    begin
    	if(rst==1)
    		begin
    			agg_out2alu <= 0;
    		end
    		
    	else 
    	    begin
    	        agg_out2alu <= agg_in;
    			agg_out2act <= agg_lsb;
    	    end
    	
    end

    assign act_out_acted = !agg_out2act;
endmodule