

// *********************************************************************************
// Project Name : CSEE 4823 Project: Neural Network Accelerator
// File Name    : nn.v
// Module Name  : nn
// *********************************************************************************
// Modification History:
// Date         By              Version                 Change Description
// -----------------------------------------------------------------------
// 11/13/2018 Shixin Qin      1.0                     Basic function design
// 12/12.2018 Shixin Qin      2.0						Tested (alu+agg)
// *********************************************************************************

module nn (clk, rst, nn_1, nn_in, agg_out2alu, alu_out);
    input               clk, rst ;

/*Contol Signal*/
//(for each) memory 

//alu 
	input 				nn_1, nn_in;
parameter alu_width  = 12;
//agg 
	
	output [alu_width-1:0]				agg_out2alu;
	output [alu_width-1:0]				alu_out;
/*Instantiate Module*/

//alu 
// alu Parameters


// alu Inputs
//reg   alu_in_a_lsb;
//reg   alu_op;
reg   signed[alu_width-1:0]             alu_in_b;

// alu Outputs
wire  signed[alu_width-1:0]     alu_out;

alu #(
    .alu_width ( 12 ))
 u_alu (
    .alu_in_a_lsb                      ( nn_1                      ),
    .alu_op                            ( nn_in                           ),
    .alu_in_b  (  agg_out2alu [alu_width-1:0]                 ),

    .alu_out     ( alu_out [alu_width-1:0]           )
);

//agg 
// agg Parameters
parameter agg_width  = 12;

// agg Inputs
//reg   clk;
//reg   rst;

// agg Outputs
wire  agg_out_acted;
wire  agg_out2act;
wire  [agg_width-1:0]  agg_out2alu;

agg #(
    .agg_width ( 12 ))
 u_agg (
    .clk                     ( clk             ),
    .rst                     ( rst             ),
    .agg_in                  ( alu_out [alu_width-1:0]          ),

    .agg_out_acted           ( agg_out_acted   ),
    .agg_out2act             ( agg_out2act     ),
    .agg_out2alu             ( agg_out2alu [agg_width-1:0]  )
);

// //cmp
// // cmp Parameters
// parameter cmp_width  = 4;

// // cmp Inputs
// reg   clk;
// reg   rst;
// reg   [cmp_width-1:0]  cmp_in_a;

// // cmp Outputs
// wire  [cmp_width-1:0]  cmp_out;
// wire  [cmp_width-1:0]  cmp_b;

// cmp #(
//     .cmp_width ( 4 ))
//  u_cmp (
//     .clk                     ( clk        ),
//     .rst                     ( rst        ),
//     .cmp_in_a                ( cmp_in_a   ),

//     .cmp_out                 ( cmp_out    ),
//     .cmp_b                   ( cmp_b      )
// );





endmodule