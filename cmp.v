// *********************************************************************************
// Project Name : CSEE 4823 Project: Neural Network Accelerator
// File Name    : cmp.v
// *********************************************************************************
// Modification History:
// Date         By              Version                 Change Description
// -----------------------------------------------------------------------
// 11/26/2018 Shixin Qin      1.0                     Basic function design
// 
// *********************************************************************************

module cmp (clk, rst, cmp_in_a, cmp_out);
    input               clk, rst, cmp_in_a ;
    output              cmp_out ;
    wire				clk, rst, cmp_in_a, cmp_out;
    reg					cmp_b;
    
    assign cmp_a = cmp_in_a;

    always @(posedge clk or posedge rst)
    begin
    	if (rst==1) 
    	    begin
    	        cmp_b <= 0;
    	    end
    	else 
    	    begin
    	        cmp_b <= cmp_out;
    	    end

    end

    
    assign cmp_out = (cmp_b>cmp_a) ? cmp_b : cmp_a;	
    
endmodule