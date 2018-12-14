//~ `New testbench
`timescale  1ns / 1ps

`include "calc.v"
module tb_calc;

// calc Parameters
parameter PERIOD     = 10;
parameter alu_width  = 12;
//parameter agg_width  = 12;

// calc Inputs
reg   clk                                  = 0 ;
reg   rst                                  = 1 ;
reg   calc_1                         = 1 ;
reg   calc_in                               = 0 ;

// calc Outputs
wire  [alu_width-1:0]   agg_out2alu                      ;
wire                    agg_out_acted                    ;



initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst  =  0; 
    #10 calc_in=0;
    #10 calc_in=1;
    #10 calc_in=0;
    #10 calc_in=1;
    #10 calc_in=1;
    #10 calc_in=0;
    #10 rst = 1;
    #10 rst=0;calc_in=1;
    #10 calc_in=0;
end

calc #(
    .alu_width ( alu_width ),
    .agg_width ( alu_width ))
 u_calc (
    .clk                     ( clk             ),
    .rst                     ( rst             ),
    .calc_1            ( calc_1    ),
    .calc_in                  ( calc_in          ),

    .agg_out2alu          ( agg_out2alu [alu_width-1:0] ),
    .agg_out_acted          ( agg_out_acted )
);

initial
begin
    $dumpfile("df.vcd");
    $dumpvars(0,tb_calc);
    $display("\t\ttime,\tclk,\treset,\top,\t1,\tout,\tacted");   
    $monitor("%d,\t%b,\t%b,\t%b,\t%b,\t%b,\t\t%b",$time, clk,rst,calc_in,calc_1,agg_out2alu,agg_out_acted);
    #(PERIOD*20)$finish;
end

endmodule
