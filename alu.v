`include "ctrl_signal.v"

// *********************************************************************************
// Project Name : CSEE 4823 Project: Neural Network Accelerator
// File Name    : alu.v
// Module Name  : alu
// *********************************************************************************
// Modification History:
// Date         By              Version                 Change Description
// -----------------------------------------------------------------------
// 11/13/2018 Shixin Qin      1.0                     Basic function design
// 
// *********************************************************************************

module alu (alu_in_a_lsb, alu_in_b, alu_op, alu_out);
    parameter n = 12;
    input               		alu_in_a_lsb, alu_op ;
    input signed [n-1:0] 		alu_in_b;
    output signed [n-1:0]	alu_out ;
    wire						alu_in_a_lsb, alu_in_b, alu_op, alu_b;
    
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


    reg [n-1:0]					alu_result;
    assign alu_out = alu_result;

    always @(*)
    begin
    	case (alu_op) 
    	    `alu_op_add1:
    	        begin
    	            alu_result = alu_b + alu_in_a_lsb;			
    	        end
    	    `alu_op_sub1:
    	        begin
    	            alu_result = alu_b - alu_in_a_lsb;
    	        end
    	    default:
    	        begin
    	            alu_result = {n{1'b0}}; 
    	        end
    	endcase

    end
endmodule