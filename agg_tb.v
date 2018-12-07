//~ `New testbench
`timescale  1ns / 1ps

module tb_agg;

// agg Parameters
parameter PERIOD = 10;
parameter n  = 12;

// agg Inputs
reg   clk                                  = 0 ;
reg   rst                                  = 0 ;
reg   [n-1:0]  agg_in                      = 0 ;

// agg Outputs
wire  [n-1:0]  agg_out                     ;
wire  agg_out2alu                          ;
wire  agg_out2act                          ;
wire  agg_out_acted                        ;


initial
begin
    forever #(PERIOD/2)  clk=~clk;
end

initial
begin
    #(PERIOD*2) rst_n  =  1;
end

agg #(
    .n ( n ))
 u_agg (
    .clk                     ( clk                    ),
    .rst                     ( rst                    ),
    .agg_in                  ( agg_in         [n-1:0] ),

    .agg_out                 ( agg_out        [n-1:0] ),
    .agg_out2alu             ( agg_out2alu            ),
    .agg_out2act             ( agg_out2act            ),
    .agg_out_acted           ( agg_out_acted          )
);

initial
begin

    $finish;
end

endmodule
