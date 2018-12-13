//~ `New testbench
`timescale  1ns / 1ps

module tb_nn;

// nn Parameters
parameter PERIOD     = 10;
parameter alu_width  = 12;
parameter agg_width  = 12;

// nn Inputs
reg   clk                                  = 0 ;
reg   rst                                  = 1 ;
reg   nn_1                         = 1 ;
reg   nn_in                               = 0 ;

// nn Outputs
wire  [alu_width-1:0]agg_out2alu                      ;
wire  [alu_width-1:0]alu_out                       ;



initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst  =  0; 
    #10 nn_in=0;
    #10 nn_in=1;
    #10 nn_in=0;
    #10 nn_in=1;
    #10 nn_in=1;
    #10 nn_in=0;
end

nn #(
    .alu_width ( alu_width ),
    .agg_width ( agg_width ))
 u_nn (
    .clk                     ( clk             ),
    .rst                     ( rst             ),
    .nn_1            ( nn_1    ),
    .nn_in                  ( nn_in          ),

    .agg_out2alu          ( agg_out2alu [agg_width-1:0] ),
    .alu_out          ( alu_out [agg_width-1:0] )
);

initial
begin
    $dumpfile("/home/netlab/nna/df.vcd");
    $dumpvars(0,tb_nn);

//$monitor("%d,\t%b",$time,agg_out_acted);
    $display("\t\ttime,\tclk,\treset,\top,\t1,\tout,\taluout"); 
    
    $monitor("%d,\t%b,\t%b,\t%b,\t%b,\t%b,\t\t%b",$time, clk,rst,nn_in,nn_1,agg_out2alu,alu_out);
    #(PERIOD*20)$finish;
end

endmodule
