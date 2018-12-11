//~ `New testbench
`timescale  1ns / 1ps

module tb_alu;

// alu Parameters
parameter PERIOD = 10;
parameter alu_width  = 12;

// alu Inputs
reg   clk                                  = 0 ;
reg   rst                                  = 0 ;
reg   alu_in_a_lsb                         = 0 ;
reg   alu_op                               = 0 ;
reg   [alu_width-1:0]  alu_in_b                    = 0 ;

// alu Outputs
wire  [alu_width-1:0]  alu_out                     ;



initial
begin
    #10 rst  =  1;
    #10 alu_op=0;alu_in_a_lsb=1;alu_in_b=0;
    #10 alu_op=0;alu_in_a_lsb=1;alu_in_b=1;
    #10 alu_op=0;alu_in_a_lsb=0;alu_in_b=2;
    #10 alu_op=0;alu_in_a_lsb=1;alu_in_b=3;
    #10 alu_op=1;alu_in_a_lsb=1;alu_in_b=2;
    #10 alu_op=1;alu_in_a_lsb=0;alu_in_b=2;
    #10 alu_op=1;alu_in_a_lsb=1;alu_in_b=-1;
    #10 alu_op=1;alu_in_a_lsb=1;alu_in_b=0;
    #10 alu_op=0;alu_in_a_lsb=1;alu_in_b=4095;
    

end

alu #(
    .alu_width ( alu_width ))
 u_alu (
    .alu_in_a_lsb            ( alu_in_a_lsb          ),
    .alu_op                  ( alu_op                ),
    .alu_in_b                ( alu_in_b      [alu_width-1:0] ),

    .alu_out                 ( alu_out       [alu_width-1:0] )
);

initial
begin

    $dumpfile("/home/netlab/nna/df.vcd");
    $dumpvars(0, tb_alu);
    $display("\t\ttime,\tclk,\treset,\top,\ta,\tb,\tout"); 
    $monitor("%d,\t%b,\t%b,\t%b,\t%b,\t%b",$time, clk,rst,alu_op, alu_in_a_lsb, alu_in_b,alu_out); 
    #100$finish;
end

endmodule
