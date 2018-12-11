// *********************************************************************************
// Project Name : CSEE 4823 Project: Neural Network Accelerator
// File Name    : mem_alu_reg.v
// *********************************************************************************
// Modification History:
// Date         By              Version                 Change Description
// -----------------------------------------------------------------------
// 11/26/2018 Shixin Qin      1.0                     Basic function design
// 12/10/2018 Shixin Qin      1.1                       Tested, f=xor(x,w)in the next cycle.
// *********************************************************************************

module mareg (clk, rst, //mareg_in, (mem_data), 
                    mareg_in_x, mareg_in_w,
					//reg_out_a,
					mareg_out_op);
    
	//intput 1bit x and 1bit w.
    parameter mareg_input_width = 4;
    input               			clk, rst;
    input wire [mareg_input_width/2-1:0]  	mareg_in_x, mareg_in_w ;
    output reg [mareg_input_width/2-1:0]    mareg_out_op ;
    //wire							mareg_in_x, mareg_in_w;
    //reg 							mareg_x, mareg_w;

    //assign mareg_in_x = mareg_in_x[mareg_input_width/2-1:0];
	//assign mareg_in_w = mareg_in_w[mareg_input_width/2-1:0];

    always @(posedge clk or posedge rst)
    begin
        if (rst == 0) 
            begin
                mareg_out_op <= 0;
            end 
        else 
            begin
                //mareg_x <= mareg_in_x;
    	        //mareg_w <= mareg_in_w;
    	        mareg_out_op <= mareg_in_w ^ mareg_in_x;
            end
    end

    //intput 2bit x or 2bit w.
 //    parameter input_width = 2;	
 //    input               			clk;
 //    input wire [input_width-1:0]  	mareg_in ;
 //    output reg             			mareg_out_op ;
 //    wire							mareg_in_x, mareg_in_w;
 //    reg 							mareg_x, mareg_w;

 //    assign mareg_in_x = mareg_in[input_width-1:input_width/2];
	// assign mareg_in_w = mareg_in[input_width/2-1:0];

 //    always @(posedge clk)
 //    begin
 //    	mareg_x <= mareg_in_x;
 //    	mareg_w <= mareg_in_w;
 //    	mareg_out_op <= mareg_w ^ mareg_x;
 //    end
endmodule