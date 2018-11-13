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

module alu (rst, alu_in_a_lsb, alu_in_b, alu_op, alu_out);
    input               	rst, alu_in_a_lsb, alu_op ;
    input signed [11:0] 	alu_in_b;
    output reg signed [11:0]	alu_out ;

    always @(*)
    begin
    	case (alu_op) 
    	    `alu_op_add1:
    	        begin
    	            alu_out = alu_in_b + alu_in_a_lsb;			
    	        end
    	    `alu_op_sub1:
    	        begin
    	            alu_out = alu_in_b - alu_in_a_lsb;
    	        end
    	    default:
    	        begin
    	            alu_out = 8'b0; 
    	        end
    	endcase

    end
endmodule