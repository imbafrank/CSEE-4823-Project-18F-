	`define alu_op_add1   	1'b0
	`define alu_op_sub1 	1'b1
// *********************************************************************************
// Project Name : CSEE 4823 Project: Neural Network Accelerator
// File Name    : alu.v
// Module Name  : alu
// *********************************************************************************
// Modification History:
// Date         By              Version                 Change Description
// -----------------------------------------------------------------------
// 11/13/2018 Shixin Qin      1.0                     Basic function design
// 12/10/2018 Shixin Qin      1.1                      Tested, q:signed or unsigned?
// *********************************************************************************

module alu (alu_in_a_lsb, alu_in_b, alu_op, alu_out);
    parameter alu_width = 12;
    input               		alu_in_a_lsb, alu_op ;
    input signed[alu_width-1:0] 		alu_in_b;
    output reg signed[alu_width-1:0]	alu_out ;
    wire						alu_in_a_lsb, alu_in_b, alu_op;
    
    // always @(*)
    // begin
    // 	case (alu_op) 
    // 	    `alu_op_add1:
    // 	        begin
    // 	            alu_out = alu_b + alu_in_a_lsb;			
    // 	        end
    // 	    `alu_op_sub1:
    // 	        begin
    // 	            alu_out = alu_b - alu_in_a_lsb;
    // 	        end
    // 	    default:
    // 	        begin
    // 	            alu_out = {n{1'b0}}; 
    // 	        end
    // 	endcase

    // end


    //reg 					alu_result;
    wire [alu_width-1:0] alu_b;
    assign alu_b = alu_in_b;
    
    always @(*)
    begin
    // assign alu_out =  alu_in_b;	
    	case (alu_op) 
    	    0:
    	        begin
    	            alu_out = alu_b+alu_in_a_lsb;			
    	        end
    	    1:
    	        begin
    	            alu_out = alu_b-alu_in_a_lsb;
    	        end
    	    default:
    	        begin
    	            alu_out = 0; 
    	        end
    	endcase

    end
    
    

endmodule