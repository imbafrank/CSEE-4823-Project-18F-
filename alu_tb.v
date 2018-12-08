//~ `New testbench
`timescale  1ns / 1ps

module tb_alu;

// alu Parameters
parameter PERIOD = 10;
parameter n  = 12;

// alu Inputs
reg   alu_in_a_lsb                         = 0 ;
reg   alu_op                               = 0 ;
reg   [n-1:0]  alu_in_b                    = 0 ;

// alu Outputs
wire  [n-1:0]  alu_out                     ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

alu #(
    .n ( n ))
 u_alu (
    .alu_in_a_lsb            ( alu_in_a_lsb          ),
    .alu_op                  ( alu_op                ),
    .alu_in_b                ( alu_in_b      [n-1:0] ),

    .alu_out                 ( alu_out       [n-1:0] )
);

initial
begin

    $finish;
end

endmodule
