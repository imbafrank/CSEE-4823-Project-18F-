
// *********************************************************************************
// Project Name : CSEE 4823 Project: Neural Network Accelerator
// File Name    : agg.v
// *********************************************************************************
// Modification History:
// Date         By              Version                 Change Description
// -----------------------------------------------------------------------
// 11/21/2018 	Shixin Qin      1.0                     Basic function design
// 12/13/2018	Shixin Qin		2.0						Tested, func
// *********************************************************************************

module agg (clk, rst, agg_in, agg_out2alu, agg_out_acted);
    parameter agg_width = 12;

    input wire              		clk, rst;
    input wire [agg_width-1:0] 		agg_in ;

    output reg						agg_out_acted;
    output reg	[agg_width-1:0] 	agg_out2alu; 
	
	assign agg_msb = agg_in[agg_width-1];
 
    always @(posedge clk or posedge rst)
    begin
    	if(rst==1)
    		begin
    			agg_out2alu <= 0;
    		end
    	else 
    	    begin
    	       agg_out2alu <= (^agg_in===1'bx)?0:agg_in;
				agg_out_acted <= ~agg_msb;
	   	    end
    	
    end

endmodule